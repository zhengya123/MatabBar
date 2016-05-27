//
//  AddressListViewController.m
//  MYTabBar项目
//
//  Created by dqong on 16/5/6.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import "AddressListViewController.h"
#import <ContactsUI/ContactsUI.h>
@interface AddressListViewController ()<CNContactPickerDelegate>
@property (nonatomic , strong) CNContactPickerViewController *contactPicker;
@end

@implementation AddressListViewController

- (CNContactPickerViewController *)contactPicker{
    
    if (_contactPicker == nil) {
        _contactPicker = [[CNContactPickerViewController alloc] init];
        _contactPicker.delegate = self;
    }
    return _contactPicker;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //创建CNContactStore对象,用与获取和保存通讯录信息
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    
    if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusNotDetermined) {
        //首次访问通讯录会调用
        [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            NSLog(@"%d  --  %@",granted, error);
            if (error) return;
            if (granted) {//允许
                NSLog(@"授权访问通讯录");
                [self fetchContactWithContactStore:contactStore];//访问通讯录
            }else{//拒绝
                NSLog(@"拒绝访问通讯录");//访问通讯录
            }
        }];
    }
    else if([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized){
        
        NSError *error = nil;
        
        //创建数组,必须遵守CNKeyDescriptor协议,放入相应的字符串常量来获取对应的联系人信息
        NSArray <id<CNKeyDescriptor>> *keysToFetch = @[CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey];
        //创建获取联系人的请求
        CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
        //遍历查询
        [contactStore enumerateContactsWithFetchRequest:fetchRequest error:&error usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
            if (!error) {
                NSLog(@"familyName = %@", contact.familyName);//姓
                NSLog(@"givenName = %@", contact.givenName);//名字
                NSLog(@"phoneNumber = %@", ((CNPhoneNumber *)(contact.phoneNumbers.lastObject.value)).stringValue);//电话
                
            }
            else{
                NSLog(@"error:%@", error.localizedDescription);
            }
        }];
        
        //调用通讯录
        [self presentViewController:self.contactPicker  animated:YES completion:nil];
    }
    
    else{
        //无权限访问
        NSLog(@"拒绝访问通讯录");  
    }
}
#pragma  mark 访问通讯录
- (void)fetchContactWithContactStore:(CNContactStore *)contactStore{
    
    //调用通讯录
    self.contactPicker.displayedPropertyKeys =@[CNContactEmailAddressesKey, CNContactBirthdayKey, CNContactImageDataKey];
    [self presentViewController:self.contactPicker  animated:YES completion:nil];
    
}

#pragma mark 选择联系人进入详情
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        CNContactViewController *vc = [CNContactViewController viewControllerForContact:contact];
        vc.displayedPropertyKeys =@[CNContactGivenNameKey,CNContactPhoneNumbersKey,CNContactFamilyNameKey,CNContactInstantMessageAddressesKey,CNContactEmailAddressesKey,CNContactDatesKey,CNContactUrlAddressesKey,CNContactBirthdayKey, CNContactImageDataKey];
        [self presentViewController:vc animated:YES completion:nil];
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
