//
//  PJCrashProtector.h
//  PJCrashProtector_Example
//
//  Created by 孙鹏举 on 2021/5/19.
//  Copyright © 2021 PJStation. All rights reserved.
//

#ifndef PJCrashProtector_h
#define PJCrashProtector_h

#include <stdio.h>
#include <objc/runtime.h>
//extern IMP lookUpImpOrForward(Class cls, SEL sel, id inst,
//                       bool initialize, bool cache, bool resolver);
void PJ_ReplaceMethod(Class _originalClass ,SEL _originalSel, Class _targetClass, SEL _targetSel);
void PJ_ExchangeClassMethod(Class _class ,SEL _originalSel,SEL _exchangeSel);
#endif /* PJCrashProtector_h */
