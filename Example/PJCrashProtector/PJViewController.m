//
//  PJViewController.m
//  PJCrashProtector
//
//  Created by PJStation on 05/19/2021.
//  Copyright (c) 2021 PJStation. All rights reserved.
//

#import "PJViewController.h"
#import "PJTest.h"
#import <objc/runtime.h>
#import "PJTest+Protector.h"
@interface PJViewController (){
    PJTest *_test;
}
@end

@implementation PJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//
    
    NSObject *object = [NSObject new];
    [object performSelector:@selector(testFunction)];
    
    
    _test = [PJTest new];
    [_test performSelector:@selector(testFunction:)];

}

- (void)testImplementation
{
   
}

- (void)testFunction2{
    NSLog(@"%@",NSStringFromClass(self.class));
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [_test performSelector:@selector(testFunction:)];
}


@end
