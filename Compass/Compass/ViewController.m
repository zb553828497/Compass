//
//  ViewController.m
//  Compass
//
//  Created by zhangbin on 16/6/28.
//  Copyright © 2016年 zhangbin. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()<CLLocationManagerDelegate>
/** 定位管理者*/
@property(nonatomic,strong)CLLocationManager *mgr;
/** 指南针图片*/
@property(nonatomic,strong)UIImageView *imageV;
@end

@implementation ViewController

-(CLLocationManager *)mgr{
    if(_mgr == nil){
        _mgr = [[CLLocationManager alloc] init];
    }
    return _mgr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   // 1.添加指南针图片
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_compasspointer"]];
    imageV.center = CGPointMake(self.view.center.x,self.view.center.y);
    [self.view addSubview:imageV];
    self.imageV = imageV;
   // 2.让控制器成为CoreLocation的代理
    self.mgr.delegate = self;
   // 3.获取用户位置
    [self.mgr startUpdatingHeading];
}
#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    // 打印的结果中0度就是北方，所以你将手机平放在桌面，手机的宽度和键盘平行，你必须提前知道北方的位置
    // 打印的结果为50度，那么要实现图片的旋转和打印的位置一直，必须将图片也旋转50度，并且这个50度为-50度
    // 记住，打印多少度，你就在度数前面加负数
    NSLog(@"%lf",newHeading.magneticHeading);
    
    // 1.将获取到的角度转为弧度     弧度 = (角度 * π) / 180;
    CGFloat angle = newHeading.magneticHeading *M_PI / 180;
    
    // 2.利用transform属性旋转图片
    
    self.imageV.transform = CGAffineTransformMakeRotation(-angle);
}

@end
