//
//  MessageViewController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/16.
//  Copyright © 2020 fang. All rights reserved.
//

#import "MessageViewController.h"
#import "YBModelFile.h"


@interface MessageViewController ()
@property(nonatomic,strong) NSThread *myThread;

@property(nonatomic,strong) MAMapView *mapView;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    self.title  =@"消息";
    

        MAMapView *mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    mapView.showsCompass = NO;
    mapView.showsUserLocation = YES;
    [mapView metersPerPointForZoomLevel:10];
    mapView.userTrackingMode = MAUserTrackingModeFollow;
     [self.view addSubview:mapView];
    self.mapView = mapView ;
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.mapView.frame = CGRectMake(0, 300, self.view.width, 300);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(39.992520, 116.336170) animated:YES];

//    [self.subInfoInterface uploadImage:nil callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
//        if (error == nil) {
//            [self alertWithMessage:@"XXXXX"];
//        }
//    }];

    
//      NSString *path = [[NSBundle mainBundle] pathForResource:@"xsjson" ofType:@"json"];
//      // 将文件数据化
//      NSData *data = [[NSData alloc] initWithContentsOfFile:path];
//      [YBModelFile createFileWithName:@"XSHouseDetails" data:data];
}
@end

