//
//  PJCrashProtector.c
//  PJCrashProtector_Example
//
//  Created by 孙鹏举 on 2021/5/19.
//  Copyright © 2021 PJStation. All rights reserved.
//

#include "PJCrashProtector.h"




void PJ_ReplaceMethod(Class _originalClass ,SEL _originalSel, Class _targetClass, SEL _targetSel){
    Method methodOriginal = class_getInstanceMethod(_originalClass, _originalSel);
    Method methodNew = class_getInstanceMethod(_targetClass, _targetSel);
    
    IMP impNew = method_getImplementation(methodNew);
    const char *typeNew = method_getTypeEncoding(methodNew);
    
    IMP impOriginal = method_getImplementation(methodOriginal);
    const char *typeOriginal = method_getTypeEncoding(methodOriginal);
    
    BOOL isAdded = class_addMethod(_originalClass, _originalSel, impNew, typeNew);
    if (isAdded) {
        //class_addMethod返回的布尔值为YES，添加方法成功，表示被替换的方法没有实现，可以通过class_addMethod添加方法实现
        class_replaceMethod(_targetClass, _targetSel, impOriginal, typeOriginal);
    } else {
        //返回的布尔值为NO，表示被目标方法已经存在，可以直接进行IMP指针交换
        method_exchangeImplementations(methodOriginal, methodNew);

    }
}


/*交换类方法*/
void PJ_ExchangeClassMethod(Class _class ,SEL _originalSel,SEL _exchangeSel){
    Method methodOriginal = class_getClassMethod(_class, _originalSel);
    Method methodNew = class_getClassMethod(_class, _exchangeSel);
    method_exchangeImplementations(methodOriginal, methodNew);
}
