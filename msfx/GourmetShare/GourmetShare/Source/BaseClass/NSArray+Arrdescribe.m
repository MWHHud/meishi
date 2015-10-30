//
//  NSArray+Arrdescribe.m
//  GourmetShare
//
//  Created by 马文豪 on 15/10/19.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "NSArray+Arrdescribe.h"

@implementation NSArray (Arrdescribe)
- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *str = [NSMutableString stringWithFormat:@"count:%lu (\n", (unsigned long)self.count];
    
    for (id obj in self) {
        [str appendFormat:@"\t%@, \n", obj];
    }
    
    [str appendString:@")"];
    
    return str;
}

@end
