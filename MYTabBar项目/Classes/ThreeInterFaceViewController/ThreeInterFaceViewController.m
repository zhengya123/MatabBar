//
//  ThreeInterFaceViewController.m
//  MYTabBar项目
//
//  Created by dqong on 16/2/23.
//  Copyright © 2016年 dqong. All rights reserved.
//

#import "ThreeInterFaceViewController.h"
#import "APIKey.h"
#import "BaseMapViewController.h"
#import <MapKit/MKAnnotation.h>
@interface ThreeInterFaceViewController ()<MAMapViewDelegate,AMapLocationManagerDelegate>

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@end

@implementation ThreeInterFaceViewController
{
    CLLocationManager * locationManage;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"周边服务";
    
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
//    MAPointAnnotation * pointAnnotation = [[MAPointAnnotation alloc]init];
//    pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.989631, 116.481018);
//    pointAnnotation.title = @"方恒国际";
//    pointAnnotation.subtitle = @"阜通东大街6号";
//    [_mapView addAnnotation:pointAnnotation];

}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}
-(void)createUI{

    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
    //BaseMapViewController *subViewController = [[BaseMapViewController alloc] init];

    //BaseMapViewController.mapView = self.mapView;
    UIButton * dingwei = [UIButton buttonWithType:UIButtonTypeCustom];
    dingwei.frame = CGRectMake(10, self.view.bounds.size.height - 250, 50, 50);
    dingwei.layer.cornerRadius= 50/2;
    dingwei.backgroundColor = [UIColor yellowColor];
    [dingwei addTarget:self action:@selector(dingweiClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dingwei];
    
    locationManage = [[CLLocationManager alloc]init];//创建位置管理
    self.locationManager = [[AMapLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    locationManage.delegate = self;
    locationManage.desiredAccuracy = kCLLocationAccuracyBest;//指定需要的精度级别
    locationManage.distanceFilter = 100.f;//设置距离筛选器
    [locationManage startUpdatingLocation];//启动位置管理器

}
-(void)dingweiClick{
    NSLog(@"点击定位了");
    
    
    
    
    [_mapView setUserTrackingMode:MAUserTrackingModeFollow];
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error) {
            NSLog(@"locError:{%ld - %@};",(long)error.code,error.localizedDescription);
        }else{
            [self locationMap:location];
        
        }
    }];
    //[self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    //[self.locationManager setAllowsBackgroundLocationUpdates:YES];



}
-(void)locationMap:(CLLocation *)location{
    NSLog(@"%@",location);
    MAPointAnnotation * pointAnnotation = [[MAPointAnnotation alloc]init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.95634467, 116.27451172);
   // pointAnnotation.title = @"方恒国际";
    //pointAnnotation.subtitle = @"阜通东大街6号";
    [_mapView addAnnotation:pointAnnotation];



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
