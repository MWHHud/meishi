//
//  StuffModle.m
//  GourmetShare
//
//  Created by jang on 15/10/15.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "StuffModle.h"

@implementation StuffModle

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    if ([key isEqualToString:@"id"]) {
        
        self.sid = value;
    }
}

//编码方法
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.steps forKey:@"p_steps"];
}

//反编码
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.steps = [aDecoder decodeObjectForKey:@"p_steps"];
    }
    return self;
}

@end
