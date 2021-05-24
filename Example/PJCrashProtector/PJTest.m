//
//  PJTest.m
//  PJCrashProtector_Example
//
//  Created by 孙鹏举 on 2021/5/20.
//  Copyright © 2021 PJStation. All rights reserved.
//

#import "PJTest.h"
#include "PJCrashProtector.h"

@implementation PJTest


//+ (BOOL)resolveInstanceMethod:(SEL)sel{
//    
//    
//    
//    if (sel == NSSelectorFromString(@"testFunction")) {
//        Method swizzledMethod = class_getInstanceMethod(self, @selector(resolveTest));
//        IMP impNew = method_getImplementation(swizzledMethod);
//        class_addMethod(self, sel, impNew, "v@:@");
//        /**
//         事实上这里返回YES或NO没有任何区别，runtime内部调用resolveInstanceMethod获取的bool值只用于了log信息
//         主要是lookUpImpOrNil是否能查到imp
//         */
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}

//IMP lookUpImpOrForward(Class cls, SEL sel, id inst,
//                       bool initialize, bool cache, bool resolver){
//    IMP imp = nil;
//
//    //1.从缓存中查找imp
//    //2.是否initialize
//    //3._class_resolveInstanceMethod里利用objc_msgSend发消息调用resolveInstanceMethod，给机会动态添加方法
//    //4.lookUpImpOrNil查找imp
//    //5.
//
////    imp = (IMP)_objc_msgForward_impcache;
////    cache_fill(cls, sel, imp, inst);
//    return imp;
//}

//- (void)testFunction{
//    NSLog(@"上报bug");
//}

@end
