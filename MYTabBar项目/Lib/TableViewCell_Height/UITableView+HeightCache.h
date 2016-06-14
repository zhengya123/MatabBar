//
//  UITableView+HeightCache.h
//  CacheTableViewHeightDemo
//
//  Created by Wicky on 16/5/11.
//  Copyright © 2016年 Wicky. All rights reserved.
//

/*
 tableView优化之高度缓存方案
 
 
 1.0.1
 这是一个tableView高度缓存的分类。
 你只需调用 UITableView (HeightCache) 中的五个方法即可完成对高度缓存的所有操作
 所有方法请在操作数据源之前调用，切记切记。
 2016.05.16
 */

#import <UIKit/UIKit.h>

@class HeightCache;
@interface UITableView (HeightCache)
@property (strong ,nonatomic)HeightCache * cache;//缓存实例

///返回cell高度并缓存高度
/*
 indetifier:重用标识
 indexPath:cell的角标
 configuration:回调block，可在block中对cell进行相关操作，操作后在计算高度
 */
-(CGFloat)DW_CalculateCellWithIdentifier:(NSString *)identifier
                               indexPath:(NSIndexPath *)indexPath
                           configuration:(void(^)(id cell))configuration;
///移除某个cell的高度缓存
/*
 indetifier:重用标识
 indexPath:cell的角标
 */
-(void)DW_RemoveHeightCacheWithIdentifier:(NSString *)identifier
                                indexPath:(NSIndexPath *)indexPath
                             numberOfRows:(NSInteger)rows;
///移除所有缓存的高度
-(void)DW_RemoveAllHeightCache;
///插入cell时插入高度缓存
/*
 indetifier:重用标识
 indexPath:cell的角标
 rows:插入的分组插入前的元素个数
 */
-(void)DW_InsertCellToIndexPath:(NSIndexPath *)indexPath
                 withIdentifier:(NSString *)identifier
                   numberOfRows:(NSInteger)rows;
///移动cell时交换高度缓存
/*
 indetifier:重用标识
 sourceIndexPath:cell移动的初始角标
 sourceRows:移动前初始分组的元素个数
 destinationIndexPath:cell移动的目标角标
 sourceRows:移动前目标分组的元素个数
 */
-(void)DW_MoveCellFromIndexPath:(NSIndexPath *)sourceIndexPath
    sourceIndexPathNumberOfRows:(NSInteger)sourceRows
                    toIndexPath:(NSIndexPath *)destinationIndexPath
destinationIndexPathNumberOfRows:(NSInteger)destinationRows
                 withIdentifier:(NSString *)identifier;
@end


@interface UITableViewCell (HeightCacheCell)
@property (assign ,nonatomic)BOOL JustForCal;//计算用的cell标识符（将计算用的cell与正常显示的cell进行区分，避免不必要的ui响应）
@property (assign ,nonatomic)BOOL NoAutoSizing;//不适用autoSizing标识符（不依靠约束计算，只进行自适应）
@end


@interface HeightCache : NSObject
@property (strong ,nonatomic)NSMutableDictionary * dicHeightCacheV;//竖直行高缓存字典
@property (strong ,nonatomic)NSMutableDictionary * dicHeightCacheH;//水平行高缓存字典
@property (strong ,nonatomic)NSMutableDictionary * dicHeightCurrent;//当前状态行高缓存字典（中间量）

-(NSString *)makeKeyWithIdentifier:(NSString *)identifier
                         indexPath:(NSIndexPath *)indexPath;
-(BOOL)existInCacheByKey:(NSString *)key;
-(CGFloat)heightFromCacheWithKey:(NSString *)key;
-(void)cacheHeight:(CGFloat)height
             byKey:(NSString *)key;
-(void)removeHeightByIdentifier:(NSString *)identifier
                      indexPath:(NSIndexPath *)indexPath
                   numberOfRows:(NSInteger)rows;
-(void)removeAllHeight;
-(void)moveCellFromIndexPath:(NSIndexPath *)sourceIndexPath
   sourceSectionNumberOfRows:(NSInteger)sourceRows
                 toIndexPath:(NSIndexPath *)destinationIndexPath
destinationSectionNumberOfRows:(NSInteger)destinationRows
              withIdentifier:(NSString *)identifier;
-(void)insertCellToIndexPath:(NSIndexPath *)indexPath
              withIdentifier:(NSString *)identifier
                numberOfRows:(NSInteger)rows
        toDictionaryForCache:(NSMutableDictionary *)dic;
@end