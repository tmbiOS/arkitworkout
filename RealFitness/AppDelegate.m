//
//  AppDelegate.m
//  RealFitness
//  Copyright © 2017 Satori Worldwide, Inc. All rights reserved.
//

#import "AppDelegate.h"
#import <HealthKit/HealthKit.h>
#import "RealFitness-Swift.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //[self.window setTintColor:[UIColor colorWithRed:246 green:18 blue:63 alpha:1.0]];

    [DBManager initDB];
    [DBManager observeWithCompletion:^(Message *message) {
      NSLog(@"%@", message);
    }];

    return YES;
}

@end
