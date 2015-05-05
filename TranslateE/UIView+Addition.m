//
//  UIButton+Addition.m
//  LoanApproval
//
//  Created by admin on 14-8-9.
//  Copyright (c) 2014年 FormsSyntron. All rights reserved.
//

#import "UIView+Addition.h"
#import <objc/runtime.h>

@implementation UIView (Addition)
static void * MessageDictKey = &MessageDictKey;
static void * Mark = &Mark;

- (NSMutableDictionary *)messageDict {
    
    return objc_getAssociatedObject(self, MessageDictKey);
    
}

- (void)setMessageDict:(NSMutableDictionary *)messageDict {
    
    objc_setAssociatedObject(self, MessageDictKey, messageDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)mark{
    return objc_getAssociatedObject(self,Mark);
}

-(void)setMark:(NSString *)sMark{
    objc_setAssociatedObject(self, Mark, sMark, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
