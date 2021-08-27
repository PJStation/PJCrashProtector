//
//  NSObject+PJProtector.m
//  PJCrashProtector_Example
//
//  Created by 孙鹏举 on 2021/5/20.
//  Copyright © 2021 PJStation. All rights reserved.
//

#import "NSObject+PJProtector.h"
#import "PJCrashProtector.h"
#import "NSObject+MKSwizzleHook.h"
#import "MKException.h"
@implementation NSObject (PJProtector)


+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //第一阶段：方法解析阶段
        //方法解析阶段虽然也有机会去添加未实现的方法，但是这一阶段无法判断一个随机的sel是否已实现，所以实际应用中，这个阶段做到的事情很少
        //第二阶段：快速转发阶段
        mk_swizzleInstanceMethod([self class], @selector(forwardingTargetForSelector:), @selector(pj_forwardingTargetForSelector:));
        
        //第三阶段：常规转发阶段
        mk_swizzleInstanceMethod([self class], @selector(methodSignatureForSelector:), @selector(mk_methodSignatureForSelector:));
        mk_swizzleInstanceMethod([self class], @selector(forwardInvocation:), @selector(mk_forwardInvocation:));

    });
}
#pragma mark - 第二阶段：快速转发阶段，在该阶段把消息转发给其它对象，并为这个对象添加方法以及方法实现
- (id)pj_forwardingTargetForSelector:(SEL)aSelector {
    if (![self isOverideForwardingMethods:[self class]]) {

//        SLCrashError *crashError = [SLCrashError errorWithErrorType:SLCrashErrorTypeUnrecognizedSelector errorDesc:[NSString stringWithFormat:@"异常:未识别方法 [%@ +%@]",NSStringFromClass([self class]),NSStringFromSelector(aSelector)] exception:nil callStack:[NSThread callStackSymbols]];
//        [[SLCrashHandler defaultCrashHandler].delegate crashHandlerDidOutputCrashError:crashError];
        //如果SLCrashHandler也没有实现aSelector，就动态添加上aSelector
        if (!class_getInstanceMethod([NSObject class], aSelector)) {
            class_addMethod([NSObject class], aSelector, (IMP)SL_DynamicAddMethodIMP, "v@:");
        }
        // 把aSelector转发给SLCrashHandler实例执行
        return [[NSObject alloc] init];
    }
    return [self pj_forwardingTargetForSelector:aSelector];
}



//class类是否重写了消息转发的相关方法
- (BOOL)isOverideForwardingMethods:(Class)class{
    BOOL overide = NO;
    overide = (class_getMethodImplementation([NSObject class], @selector(forwardInvocation:)) != class_getMethodImplementation(class, @selector(forwardInvocation:))) ||
    (class_getMethodImplementation([NSObject class], @selector(forwardingTargetForSelector:)) != class_getMethodImplementation(class, @selector(forwardingTargetForSelector:)));
    return overide;
}
/*动态添加方法的imp*/
static inline int SL_DynamicAddMethodIMP(id self,SEL _cmd,...){
    
    return 0;
}

#pragma mark - 第三阶段：常规转发阶段
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



}

- (void)mk_forwardInvocation:(NSInvocation*)invocation {
//    NSLog(@"mk_forwardInvocation");
    mkHandleCrashException([NSString stringWithFormat:@"forwardInvocation: Unrecognized instance class:%@ and selector:%@",NSStringFromClass(self.class),NSStringFromSelector(invocation.selector)]);
}

@end
