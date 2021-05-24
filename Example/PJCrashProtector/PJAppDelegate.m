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
    
    //NSInvocation;用来包装方法和对应的对象，它可以存储方法的名称，对应的对象，对应的参数,
    /*
     NSMethodSignature：签名：再创建NSMethodSignature的时候，必须传递一个签名对象，签名对象的作用：用于获取参数的个数和方法的返回值
     */
    //创建签名对象的时候不是使用NSMethodSignature这个类创建，而是方法属于谁就用谁来创建
    NSMethodSignature*signature = [self.class instanceMethodSignatureForSelector:@selector(sendMessageWithNumber:WithContent:)];
    //1、创建NSInvocation对象
    NSInvocation*invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    //invocation中的方法必须和签名中的方法一致。
    invocation.selector = @selector(sendMessageWithNumber:WithContent:);
    /*第一个参数：需要给指定方法传递的值
           第一个参数需要接收一个指针，也就是传递值的时候需要传递地址*/
    //第二个参数：需要给指定方法的第几个参数传值
    NSString*number = @"1111";
    //注意：设置参数的索引时不能从0开始，因为0已经被self占用，1已经被_cmd占用
    [invocation setArgument:&number atIndex:2];
    NSString*number2 = @"啊啊啊";
    [invocation setArgument:&number2 atIndex:3];
    //2、调用NSInvocation对象的invoke方法
    //只要调用invocation的invoke方法，就代表需要执行NSInvocation对象中制定对象的指定方法，并且传递指定的参数
    [invocation invoke];
    
    
    return YES;
}
- (void)sendMessageWithNumber:(NSString*)number WithContent:(NSString*)content{
   NSLog(@"电话号%@,内容%@",number,content);
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
