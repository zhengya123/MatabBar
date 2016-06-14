//
//  UITableView+HeightCache.m
//  CacheTableViewHeightDemo
//
//  Created by Wicky on 16/5/11.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "UITableView+HeightCache.h"
#import <objc/runtime.h>
@implementation UITableView (HeightCache)

#pragma mark ---接口方法---
-(CGFloat)DW_CalculateCellWithIdentifier:(NSString *)identifier
                               indexPath:(NSIndexPath *)indexPath
                           configuration:(void(^)(id cell))configuration
{
    if(self.bounds.size.width != 0)//防止初始宽度为0（如autoLayout初次加载时）
    {
        if (!identifier.length || !indexPath) {//非空判断
            return 0;
        }
        NSString * key = [self.cache makeKeyWithIdentifier:identifier indexPath:indexPath];//制作key
        if ([self.cache existInCacheByKey:key]) {//如果key存在
            return [self.cache heightFromCacheWithKey:key];//从字典中取出高
        }
        CGFloat height = [self DW_CalCulateCellWithIdentifier:identifier configuration:configuration];//不存在则计算高度
        [self.cache cacheHeight:height byKey:key];//并缓存
        return height;
    }
    return 0;
}
-(void)DW_RemoveHeightCacheWithIdentifier:(NSString *)identifier
                                indexPath:(NSIndexPath *)indexPath
                             numberOfRows:(NSInteger)rows
{
    [self.cache removeHeightByIdentifier:identifier indexPath:indexPath numberOfRows:rows];
}
-(void)DW_RemoveAllHeightCache
{
    [self.cache removeAllHeight];
}
-(void)DW_InsertCellToIndexPath:(NSIndexPath *)indexPath
                 withIdentifier:(NSString *)identifier
                   numberOfRows:(NSInteger)rows
{
    [self.cache insertCellToIndexPath:indexPath withIdentifier:identifier numberOfRows:rows toDictionaryForCache:self.cache.dicHeightCurrent];
}
-(void)DW_MoveCellFromIndexPath:(NSIndexPath *)sourceIndexPath
    sourceIndexPathNumberOfRows:(NSInteger)sourceRows
                    toIndexPath:(NSIndexPath *)destinationIndexPath
destinationIndexPathNumberOfRows:(NSInteger)destinationRows
                 withIdentifier:(NSString *)identifier
{
    [self.cache moveCellFromIndexPath:sourceIndexPath sourceSectionNumberOfRows:sourceRows toIndexPath:destinationIndexPath destinationSectionNumberOfRows:destinationRows withIdentifier:identifier];
}
#pragma mark ---工具方法---
///从重用池中返回计算用的cell
-(__kindof UITableViewCell *)DW_CalculateCellWithIdentifier:(NSString *)identifier
{
    if (!identifier.length) {
        return nil;
    }
    NSMutableDictionary <NSString * ,UITableViewCell *> *DicForTheUniqueCalCell = objc_getAssociatedObject(self, _cmd);//利用runtime取出tableV绑定的存有cell的字典
    if (!DicForTheUniqueCalCell) {
        DicForTheUniqueCalCell = [NSMutableDictionary dictionary];//如果取不到则新建并绑定
        objc_setAssociatedObject(self, _cmd, DicForTheUniqueCalCell, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//动态绑定（绑定目标，关键字，绑定者，策略）
    }
    //以上只是为了只绑定一个字典，类比懒加载
    UITableViewCell * cell = DicForTheUniqueCalCell[identifier];
    if (!cell) {
        cell = [self dequeueReusableCellWithIdentifier:identifier];//从重用池中取一个cell用来计算，必须以本方式从重用池中取，若以indexPath方式取由于-heightForRowAtIndexPath方法会造成循环。
        cell.contentView.translatesAutoresizingMaskIntoConstraints = NO;//开启约束
        cell.JustForCal = YES;//标记只用来计算
        DicForTheUniqueCalCell[identifier] = cell;
    }
    //同上，保证只有一个用来计算的cell
    return cell;
}

///根据重用表示取出cell并操作cell后，计算高度
-(CGFloat)DW_CalCulateCellWithIdentifier:(NSString *)identifier
                           configuration:(void(^)(id cell))configuration
{
    if (!identifier.length) {
        return 0;
    }
    UITableViewCell * cell = [self DW_CalculateCellWithIdentifier:identifier];
    [cell prepareForReuse];//放回重用池
    if (configuration) {
        configuration(cell);//对cell进行操作
    }
    return [self DW_CalculateCellHeightWithCell:cell];
}

///根据cell计算cell的高度
-(CGFloat)DW_CalculateCellHeightWithCell:(UITableViewCell *)cell
{
    CGFloat width = self.bounds.size.width;
    //根据辅助视图校正width
    if (cell.accessoryView) {
        width -= cell.accessoryView.bounds.size.width + 16;
    }
    else
    {
        static const CGFloat accessoryWidth[] = {
            [UITableViewCellAccessoryNone] = 0,
            [UITableViewCellAccessoryDisclosureIndicator] = 34,
            [UITableViewCellAccessoryDetailDisclosureButton] = 68,
            [UITableViewCellAccessoryCheckmark] = 40,
            [UITableViewCellAccessoryDetailButton] = 48
        };
        width -= accessoryWidth[cell.accessoryType];
    }
    CGFloat height = 0;
    if (!cell.NoAutoSizing && width > 0) {//如果不是非自适应模式则添加约束后计算约束后高度
        NSLayoutConstraint * widthConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];//创建约束
        [cell.contentView addConstraint:widthConstraint];//添加约束
        height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;//计算高度
        [cell.contentView removeConstraint:widthConstraint];//移除约束
    }
    if (height == 0) {//如果约束错误可能导致计算结果为零，则以自适应模式再次计算
        height = [cell sizeThatFits:CGSizeMake(width, 0)].height;
    }
    if (height == 0) {//如果计算仍然为0，则给出默认高度
        height = 44;
    }
    if (self.separatorStyle != UITableViewCellSeparatorStyleNone) {//如果不为无分割线模式则添加分割线高度
        height += 1.0 /[UIScreen mainScreen].scale;
    }
    return height;
}

#pragma mark ---setter、getter---
-(HeightCache *)cache//懒加载形式
{
    HeightCache * cacheTemp = objc_getAssociatedObject(self, _cmd);
    if (!cacheTemp) {
        cacheTemp = [HeightCache new];
        objc_setAssociatedObject(self, _cmd, cacheTemp, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return cacheTemp;
}
-(void)setCache:(HeightCache *)cache
{
    objc_setAssociatedObject(self, @selector(cache), cache, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end


@implementation UITableViewCell (HeightCacheCell)
#pragma mark ---setter、getter---
-(BOOL)NoAutoSizing
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
-(void)setNoAutoSizing:(BOOL)NoAutoSizing
{
    objc_setAssociatedObject(self, @selector(NoAutoSizing), @(NoAutoSizing), OBJC_ASSOCIATION_RETAIN);//关键字用getter的方法名，为保持关键字一致
}
-(BOOL)JustForCal
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
-(void)setJustForCal:(BOOL)JustForCal
{
    objc_setAssociatedObject(self, @selector(JustForCal), @(JustForCal), OBJC_ASSOCIATION_RETAIN);
}
@end

@implementation HeightCache
///制作key
-(NSString *)makeKeyWithIdentifier:(NSString *)identifier
                         indexPath:(NSIndexPath *)indexPath
{
    return [NSString stringWithFormat:@"%@S%ldR%ld",identifier,indexPath.section,indexPath.row];
}

///高度是否存在
-(BOOL)existInCacheByKey:(NSString *)key
{
    NSNumber * value = [self.dicHeightCurrent valueForKey:key];
    return (value && ![value isEqualToNumber:@-1]);
}

///取出缓存的高度
-(CGFloat)heightFromCacheWithKey:(NSString *)key
{
    NSNumber * value = [self.dicHeightCurrent valueForKey:key];
    if ([self is64bit]) {
        return [value doubleValue];
    }
    return [value floatValue];
}

///64位判断
- (BOOL)is64bit
{
#if defined(__LP64__) && __LP64__
    return YES;
#else
    return NO;
#endif
}

///高度缓存
-(void)cacheHeight:(CGFloat)height
             byKey:(NSString *)key
{
    [self.dicHeightCurrent setValue:@(height) forKey:key];
}

///根据key删除缓存
-(void)removeHeightByIdentifier:(NSString *)identifier
                      indexPath:(NSIndexPath *)indexPath
                   numberOfRows:(NSInteger)rows
{
    if (indexPath.row < rows) {
        for (int i = 0; i < rows - 1 - indexPath.row; i ++) {
            NSIndexPath * indexPathA = [NSIndexPath indexPathForRow:indexPath.row + i inSection:indexPath.section];
            NSLog(@"%ld,%ld",indexPathA.row,indexPathA.section);
            NSIndexPath * indexPathB = [NSIndexPath indexPathForRow:indexPath.row + i + 1 inSection:indexPath.section];
            NSLog(@"%ld,%ld",indexPathB.row,indexPathB.section);
            [self exchangeValueForIndexPathA:indexPathA andIndexPathB:indexPathB withIdentifier:identifier dictionary:self.dicHeightCacheH];
            [self exchangeValueForIndexPathA:indexPathA andIndexPathB:indexPathB withIdentifier:identifier dictionary:self.dicHeightCacheV];
        }
        NSIndexPath * indexPathC = [NSIndexPath indexPathForRow:rows - 1 inSection:indexPath.section];
        NSString * key = [self makeKeyWithIdentifier:identifier indexPath:indexPathC];
        [self.dicHeightCacheH removeObjectForKey:key];
        [self.dicHeightCacheV removeObjectForKey:key];
    }
}

///删除所有缓存
-(void)removeAllHeight
{
    [self.dicHeightCacheH removeAllObjects];
    [self.dicHeightCacheV removeAllObjects];
}

///插入cell是插入value
-(void)insertCellToIndexPath:(NSIndexPath *)indexPath
            withNumberOfRows:(NSInteger)rows
                heightNumber:(NSNumber *)height
                  identifier:(NSString *)identifier
        toDictionaryForCache:(NSMutableDictionary *)dic
{
    if (indexPath.row < rows + 1) {
        [self insertCellToIndexPath:indexPath withIdentifier:identifier numberOfRows:rows toDictionaryForCache:dic];
        NSString * key = [self makeKeyWithIdentifier:identifier indexPath:indexPath];
        [dic setValue:height forKey:key];
    }
}
-(void)insertCellToIndexPath:(NSIndexPath *)indexPath withIdentifier:(NSString *)identifier numberOfRows:(NSInteger)rows toDictionaryForCache:(NSMutableDictionary *)dic
{
    if (indexPath.row < rows + 1) {
        for (int i = 0; i < rows - indexPath.row; i ++) {
            NSIndexPath * indexPathA = [NSIndexPath indexPathForRow:rows - i inSection:indexPath.section];
            NSIndexPath * indexPathB = [NSIndexPath indexPathForRow:rows - i - 1 inSection:indexPath.section];
            [self exchangeValueForIndexPathA:indexPathA andIndexPathB:indexPathB withIdentifier:identifier dictionary:dic];
        }
    }
}
///移动cell时交换value
-(void)moveCellFromIndexPath:(NSIndexPath *)sourceIndexPath
   sourceSectionNumberOfRows:(NSInteger)sourceRows
                 toIndexPath:(NSIndexPath *)destinationIndexPath
destinationSectionNumberOfRows:(NSInteger)destinationRows
              withIdentifier:(NSString *)identifier
{
    if (sourceIndexPath.section == destinationIndexPath.section) {
        [self moveCellInSectionFromIndexPath:sourceIndexPath toIndexPath:destinationIndexPath withIdentifier:identifier];
    }
    else
    {
        [self moveCellOutSectionFromIndexPath:sourceIndexPath sourceSectionNumberOfRows:sourceRows toIndexPath:destinationIndexPath destinationSectionNumberOfRows:destinationRows withIdentifier:identifier];
    }
}
///组内移动
-(void)moveCellInSectionFromIndexPath:(NSIndexPath *)sourceIndexPath
                          toIndexPath:(NSIndexPath *)destinationIndexPath
                       withIdentifier:(NSString *)identifier
{
    NSInteger rowA = sourceIndexPath.row;
    NSInteger rowB = destinationIndexPath.row;
    for (int i = 0; i < (MAX(rowA, rowB) - MIN(rowA, rowB)); i ++) {
        NSIndexPath * indexPathA = [NSIndexPath indexPathForRow:MIN(rowA, rowB) + i inSection:sourceIndexPath.section];
        NSIndexPath * indexPathB = [NSIndexPath indexPathForRow:MIN(rowA, rowB) + i + 1 inSection:sourceIndexPath.section];
        [self exchangeValueForIndexPathA:indexPathA andIndexPathB:indexPathB withIdentifier:identifier dictionary:self.dicHeightCacheV];
        [self exchangeValueForIndexPathA:indexPathA andIndexPathB:indexPathB withIdentifier:identifier dictionary:self.dicHeightCacheH];
    }
}
///组外移动
-(void)moveCellOutSectionFromIndexPath:(NSIndexPath *)sourceIndexPath
             sourceSectionNumberOfRows:(NSInteger)sourceRows
                           toIndexPath:(NSIndexPath *)destinationIndexPath
        destinationSectionNumberOfRows:(NSInteger)destinationRows
                        withIdentifier:(NSString *)identifier
{
    NSNumber * numberH;
    NSNumber * numberV;
    NSLog(@"%ld",sourceIndexPath.row);
    if (sourceIndexPath.row < sourceRows) {
        NSString * key = [self makeKeyWithIdentifier:identifier indexPath:sourceIndexPath];
        numberH = self.dicHeightCacheH[key];
        numberV = self.dicHeightCacheV[key];
        [self removeHeightByIdentifier:identifier indexPath:sourceIndexPath numberOfRows:sourceRows];
    }
    NSLog(@"%ld,%ld",destinationIndexPath.row,destinationIndexPath.section);
    [self insertCellToIndexPath:destinationIndexPath withNumberOfRows:destinationRows heightNumber:numberH identifier:identifier toDictionaryForCache:self.dicHeightCacheH];
    [self insertCellToIndexPath:destinationIndexPath withNumberOfRows:destinationRows heightNumber:numberV identifier:identifier toDictionaryForCache:self.dicHeightCacheV];
}
///根据indexPath交换两个Key
-(void)exchangeValueForIndexPathA:(NSIndexPath *)indexPathA
                    andIndexPathB:(NSIndexPath *)indexPathB
                   withIdentifier:(NSString *)identifier
                       dictionary:(NSMutableDictionary *)dic
{
    NSString * keyA = [self makeKeyWithIdentifier:identifier indexPath:indexPathA];
    NSString * keyB = [self makeKeyWithIdentifier:identifier indexPath:indexPathB];
    NSNumber * Temp = dic[keyA];
    dic[keyA] = dic[keyB];
    dic[keyB] = Temp;
}
#pragma mark ---懒加载---
-(NSMutableDictionary *)dicHeightCacheH
{
    if (!_dicHeightCacheH) {
        _dicHeightCacheH = [NSMutableDictionary dictionary];
    }
    return _dicHeightCacheH;
}
-(NSMutableDictionary *)dicHeightCacheV
{
    if (!_dicHeightCacheV) {
        _dicHeightCacheV = [NSMutableDictionary dictionary];
    }
    return _dicHeightCacheV;
}
-(NSMutableDictionary *)dicHeightCurrent//根据系统状态返回对应字典
{
    return UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)?self.dicHeightCacheV:self.dicHeightCacheH;
}
@end
