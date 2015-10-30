//
//  News.m
//  GourmetShare
//
//  Created by jang on 15/10/18.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "News.h"

@implementation News

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

- (void)setImage:(NSArray *)image
{
    if (image.count == 0) {
        _image = image;
    }
    else{
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *d in image) {
            [array addObject:[d valueForKey:@"url"]];
        }
        _image = array;
    }
}

- (void)setContent:(NSString *)content
{
    NSArray *parArray = [content componentsSeparatedByString:@"<"];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSString *str in parArray) {
        if (str.length == 0 || [str isEqualToString:@"p>"]||
            [str isEqualToString:@"/strong>"]||[str isEqualToString:@"/p>"]) {
            continue;
        }

        if ([[str substringToIndex:1] isEqualToString:@"!"]) {
            [tempArray addObject:@"img"];
            
        }
        else if ([[str substringToIndex:1] isEqualToString:@"p"])
        {
            [tempArray addObject:[str substringFromIndex:2]];
        }else if (str.length > 5  && [[str substringToIndex:1] isEqualToString:@"s"])
        {
            [tempArray addObject:[str substringFromIndex:6]];
        }else if (str.length > 8  && [[str substringToIndex:1] isEqualToString:@"/"])
        {
            [tempArray addObject:[str substringFromIndex:9]];
        }
    }
    _contents = tempArray;
}

@end
