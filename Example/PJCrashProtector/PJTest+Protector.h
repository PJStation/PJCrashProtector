//
//  NSObject+Protector.h
//  PJCrashProtector_Example
//
//  Created by 孙鹏举 on 2021/5/19.
//  Copyright © 2021 PJStation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PJTest.h"
NS_ASSUME_NONNULL_BEGIN

@interface PJTest (Protector)
- (void)reserve_function;
@end

NS_ASSUME_NONNULL_END
