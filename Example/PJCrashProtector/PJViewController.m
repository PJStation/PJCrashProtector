//
//  PJViewController.m
//  PJCrashProtector
//
//  Created by PJStation on 05/19/2021.
//  Copyright (c) 2021 PJStation. All rights reserved.
//

#import "PJViewController.h"
#import <objc/runtime.h>

@interface PJViewController (){
    NSObject *object;
}
@end

@implementation PJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//
    object = [NSObject new];
//    [object performSelector:@selector(testFunction)];
    


}

- (void)testImplementation
{
   
}

- (void)testFunction2{
    NSLog(@"%@",NSStringFromClass(self.class));
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [object performSelector:@selector(testFunction:)];
}


@end
