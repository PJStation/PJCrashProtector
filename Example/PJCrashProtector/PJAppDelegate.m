//
//  PJAppDelegate.m
//  PJCrashProtector
//
//  Created by PJStation on 05/19/2021.
//  Copyright (c) 2021 PJStation. All rights reserved.
//

#import "PJAppDelegate.h"
#import "PJViewController.h"
#import "MKCrashGuardManager.h"
#include <objc/runtime.h>
#include <objc/message.h>
@implementation PJAppDelegate
- (void)testFunction3{
    NSLog(@"%@----%@",NSStringFromClass(self.class),NSStringFromClass(self.class));

}

- (void)testFunction4:(NSString *)str{
    NSLog(@"--%@",str);

}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    [MKCrashGuardManager executeAppGuard];
    [MKCrashGuardManager printLog:YES];
//    [MKCrashGuardManager registerCrashHandle:self];
    
//    Method method = class_getInstanceMethod([self class], @selector(testFunction2));
    
    
//    Method method = class_getInstanceMethod(self.class, @selector(testFunction2));
//    IMP imp = method_getImplementation(method);
//    SEL sel = @selector(testFunction3);
//
//    NSLog(@"%p",@selector(testFunction3));
//    NSLog(@"%p",sel);
    
    objc_msgSend(self, @selector(testFunction3));
    objc_msgSend(self, @selector(testFunction4:),@"1234567890");
//    BOOL (*msg)(Class, SEL, SEL) = (typeof(msg))objc_msgSend;
    
    typedef void (^Block) (int num);
    void (*pj_objc_msgSend)(id, SEL, Block) = (typeof(pj_objc_msgSend))objc_msgSend;
    pj_objc_msgSend(self,@selector(testFunction3),^(int num){
        NSLog(@"Block---%d",num);
    });
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
