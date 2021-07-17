//
//  NSObject+PJProtector.m
//  PJCrashProtector_Example
//
//  Created by 孙鹏举 on 2021/5/20.
//  Copyright © 2021 PJStation. All rights reserved.
//

#import "NSObject+PJProtector.h"
#import "PJTest.h"
#import "PJCrashProtector.h"
#import "NSObject+MKSwizzleHook.h"
#import "MKException.h"
@implementation NSObject (PJProtector)


+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        mk_swizzleInstanceMethod([self class], @selector(forwardingTargetForSelector:), @selector(pj_forwardingTargetForSelector:));
    });
}

- (id)pj_forwardingTargetForSelector:(SEL)aSelector {
    
    return [self pj_forwardingTargetForSelector:aSelector];
}
@end
