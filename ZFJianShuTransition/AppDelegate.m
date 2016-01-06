//
//  AppDelegate.m
//  ZFJianShuTransition
//
//  Created by macOne on 16/1/5.
//  Copyright © 2016年 WZF. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    ViewController *mainVC = [ViewController new];
    
    
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:mainVC];
    
    
    [self.window setRootViewController:navigation];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}



@end
