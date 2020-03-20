//
//  AppDelegate.m
//  EuropeanTravel
//
//  Created by crespo on 2020/3/5.
//  Copyright © 2020 EuropeanTravel. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "XLSlideMenu.h"
#import "EuropeanTravel-Swift.h"
#import "ZSBMainViewController.h"
#import <AFNetworking/AFNetworking.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    AFNetworkReachabilityManager *netManager = [AFNetworkReachabilityManager sharedManager];
        [netManager startMonitoring];  //开始监听
        [netManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
            
            if (status == AFNetworkReachabilityStatusNotReachable)
            {
                return;
            }else if (status == AFNetworkReachabilityStatusUnknown){
                
                
            }else if ((status == AFNetworkReachabilityStatusReachableViaWWAN)||(status == AFNetworkReachabilityStatusReachableViaWiFi)){
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshNetWork" object:nil];
            }
            
        }];
    
    
    
    BaseNAVViewController *nav=[[BaseNAVViewController alloc]initWithRootViewController:[ZSBMainViewController new]];
    
    
    ZSBLeftViewController *leftVc=[ZSBLeftViewController new];
    XLSlideMenu *menu=[[XLSlideMenu alloc]initWithRootViewController:nav];
    menu.leftViewController=leftVc;
    
    
    self.window.rootViewController=menu;

    
    [UINavigationBar.appearance setTitleTextAttributes:@{
      NSFontAttributeName:[UIFont boldSystemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
      [[UINavigationBar appearance] setBarTintColor:ColorWithRGB(0xee2238)];
    return YES;
}




@end
