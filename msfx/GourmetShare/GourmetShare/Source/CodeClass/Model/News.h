//
//  News.h
//  GourmetShare
//
//  Created by jang on 15/10/18.
//  Copyright © 2015年 jang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

@property (nonatomic,strong)NSString *cid; //新闻的ID
@property (nonatomic,strong)NSString *content;//正文
@property (nonatomic,strong)NSArray *contents;
@property (nonatomic,strong)NSArray *image;//新闻图片
@property (nonatomic,strong)NSString *title;//新闻标题
@property (nonatomic,strong)NSArray *tags;//新闻标签

@end
