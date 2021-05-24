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
//        PJ_ExchangeClassMethod(self, @selector(resolveInstanceMethod:), @selector(pj_resolveInstanceMethod:));
        
//        mk_swizzleInstanceMethod([self class], @selector(methodSignatureForSelector:), @selector(mk_methodSignatureForSelector:));
//        mk_swizzleInstanceMethod([self class], @selector(forwardInvocation:), @selector(mk_forwardInvocation:));
    });
}


//- (id)pj_forwardingTargetForSelector:(SEL)aSelector{
//    return [self pj_forwardingTargetForSelector];
//}
- (void)reserve_function{
    NSLog(@"reserve_function");
}

//+(BOOL)pj_resolveInstanceMethod:(SEL)sel{
//
//    NSMethodSignature *methodSig = [self methodSignatureForSelector:sel];
//    if(methodSig == nil) {
//        //没有sel方法，动态添加sel方法
//        Method method = class_getInstanceMethod(self, @selector(reserve_function));
////        Method method = class_getInstanceMethod(self, sel);
//        IMP imp = method_getImplementation(method);
//        const char *type = method_getTypeEncoding(method);
//        BOOL isAdded = class_addMethod(self, sel, imp, type);
//        return YES;
//    }
//    return [self pj_resolveInstanceMethod:sel];
//
//}

- (NSMethodSignature*)mk_methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature* methodSignature = [self mk_methodSignatureForSelector:aSelector];
    if (methodSignature) {
        return methodSignature;
    }
    return [self.class checkObjectSignatureAndCurrentClass:self.class];
}

- (void)mk_forwardInvocation:(NSInvocation*)invocation {
    NSLog(@"reserve_function");

//    mkHandleCrashException([NSString stringWithFormat:@"forwardInvocation: Unrecognized instance class:%@ and selector:%@",NSStringFromClass(self.class),NSStringFromSelector(invocation.selector)]);
}


+ (NSMethodSignature *)checkObjectSignatureAndCurrentClass:(Class)currentClass {
    IMP originIMP = class_getMethodImplementation([NSObject class], @selector(methodSignatureForSelector:));
    IMP currentClassIMP = class_getMethodImplementation(currentClass, @selector(methodSignatureForSelector:));
    
    // 已重写
    if (originIMP != currentClassIMP){
        return nil;
    }
    
    return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
}
@end
