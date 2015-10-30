//
//  PopNews.h
//  GourmetShare
//
//  Created by lanou3g on 15/10/19.
//  Copyright © 2015年 jang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PopNews : NSObject

@property (nonatomic,strong)NSString *digest;// 标题内容简介

@property (nonatomic,strong)NSString *docid; // id

@property (nonatomic,strong)NSString *imgsrc; // 图片地址

@property (nonatomic,strong)NSString *title; // 标题

@end
