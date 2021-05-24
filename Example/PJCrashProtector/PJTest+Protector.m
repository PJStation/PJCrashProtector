//
//  NSObject+Protector.m
//  PJCrashProtector_Example
//
//  Created by 孙鹏举 on 2021/5/19.
//  Copyright © 2021 PJStation. All rights reserved.
//

#import "PJTest+Protector.h"
#import "PJCrashProtector.h"
#import "NSObject+MKSwizzleHook.h"
#import "MKException.h"

//unrecognized selector sent to instance
@implementation PJTest (Protector)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mk_swizzleInstanceMethod([self class], @selector(methodSignatureForSelector:), @selector(mk_methodSignatureForSelector:));
        mk_swizzleInstanceMethod([self class], @selector(forwardInvocation:), @selector(mk_forwardInvocation:));
    });
}



- (void)reserve_function{
    NSLog(@"reserve_function");
}


- (NSMethodSignature*)mk_methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature* methodSignature = [self mk_methodSignatureForSelector:aSelector];
    if (methodSignature) {
        return methodSignature;
    }
    IMP originIMP = class_getMethodImplementation([self class], @selector(methodSignatureForSelector:));
    IMP currentClassIMP = class_getMethodImplementation(self.class, @selector(methodSignatureForSelector:));

    // 已重写
    if (originIMP != currentClassIMP){
        return nil;
    }
    
    return [NSMethodSignature signatureWithObjCTypes:"v@:@"];

//    NSMethodSignature *methodSig = [self mk_methodSignatureForSelector:aSelector];
//    if(methodSig == nil) {
//        methodSig = [NSMethodSignature signatureWithObjCTypes:"v@:@"];
//        return methodSig;
//    }


}

- (void)mk_forwardInvocation:(NSInvocation*)invocation {
    NSLog(@"mk_forwardInvocation");
  
    SEL aSelector = [invocation selector];

    if ([[self.class alloc] respondsToSelector:aSelector]) {
        [invocation invokeWithTarget:[self.class  alloc]];
    }

//    mkHandleCrashException([NSString stringWithFormat:@"forwardInvocation: Unrecognized instance class:%@ and selector:%@",NSStringFromClass(self.class),NSStringFromSelector(invocation.selector)]);
}


+ (NSMethodSignature *)checkObjectSignatureAndCurrentClass:(Class)currentClass {
    IMP originIMP = class_getMethodImplementation([self class], @selector(methodSignatureForSelector:));
    IMP currentClassIMP = class_getMethodImplementation(currentClass, @selector(methodSignatureForSelector:));
    
    // 已重写
    if (originIMP != currentClassIMP){
        return nil;
    }
    
    return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
}


@end
 
