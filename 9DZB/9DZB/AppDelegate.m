//
//  AppDelegate.m
//  9DZB
//
//  Created by 上海灏月 on 2017/11/20.
//  Copyright © 2017年 上海灏月. All rights reserved.
//

#import "AppDelegate.h"

#import <AFNetworking/AFNetworkReachabilityManager.h>
#import "JDAccountTool.h"
#import "JDAccount.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //实时监测网络状态,程序打开的时候,就开始监听,否则有可能导致监听不到网络状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [self showRootViewController];
    
    return YES;
}

- (void)showRootViewController
{
    /*
    NSString * versionKey = @"CFBundleShortVersionString";
    // 从沙河中取出上次存储的软件版本号（取出上次的使用记录）
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * lastVersion = [defaults objectForKey:versionKey];
    
    NSDictionary * versionDict = [NSBundle mainBundle].infoDictionary;
    NSString * currentVersion = versionDict[versionKey];
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    if (![currentVersion isEqualToString:lastVersion]) { // 如果是第一次使用，就进入版本新特性控制器(引导页)
        
        // 更新之后清除账号
        [JDAccountTool removeAccount];
        window.rootViewController = [[JDNewFeatureController alloc] init];
        // 将当前版本号存到沙盒中
        [defaults setObject:currentVersion forKey:versionKey];
        //记录当前需要登录 1需要展示 其他不需要展示
        [defaults setObject:@"1" forKey:@"kBIGAdDisplayer"];
        [defaults synchronize];
    } else {
        if ([JDAccountTool judgeLogin]) { // 登录
            
            window.rootViewController = [[JDTabBarController alloc] init];
            [JDControllerTool createAdView:nil];
            [JDControllerTool loadLaunchAd];
            
            
            //            苹果审核专用账户特殊处理
            JDAccount *account = [JDAccountTool account];
            if ([account.userid isEqual:@"90145"]) {
                JDTabBarController *tabbarvc = (JDTabBarController *)window.rootViewController;
                NSMutableArray *tabbarViewControllers = [NSMutableArray arrayWithArray: [tabbarvc viewControllers]];
                if (tabbarViewControllers.count>3) {
                    [tabbarViewControllers removeObjectAtIndex:0];
                    
                    [tabbarViewControllers removeObjectAtIndex:2];
                    
                    [tabbarvc setViewControllers: tabbarViewControllers ];
                }
            }
        }else{
            CJAccoutFirstLoginViewController *vc = [[CJAccoutFirstLoginViewController alloc]initWithNibName:@"CJAccoutFirstLoginViewController" bundle:nil];
            JDNavigationController *nav = [[JDNavigationController alloc] initWithRootViewController:vc];
            window.rootViewController = nav;
            [defaults setObject:@"1" forKey:@"kBIGAdDisplayer"];
            [defaults synchronize];
            
        }
        
    }
     */
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
