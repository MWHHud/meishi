//
//  NewsDetail.h
//  GourmetShare
//
//  Created by lanou3g on 15/10/19.
//  Copyright © 2015年 jang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsDetail : NSObject

@property (nonatomic,strong)NSString *docid; // 数据id

@property (nonatomic,strong)NSString *dkeys; // 标签关键字

@property (nonatomic,strong)NSString *body; // 内容

@property (nonatomic,strong)NSArray *bodyArr;

@property (nonatomic,strong)NSArray *img; // 图片
@property (nonatomic,strong)NSMutableArray *imgArr;
@property (nonatomic,strong)NSString *title; //标题

@end
