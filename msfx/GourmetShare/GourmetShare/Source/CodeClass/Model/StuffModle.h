//
//  StuffModle.h
//  GourmetShare
//
//  Created by jang on 15/10/15.
//  Copyright © 2015年 jang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StuffModle : NSObject

@property (nonatomic,strong)NSMutableArray *albums;//专辑
@property (nonatomic,strong)NSString *burden;//调料
@property (nonatomic,strong)NSString *sid;//菜品ID
@property (nonatomic,strong)NSString *imtro;//介绍
@property (nonatomic,strong)NSString *ingredients;//配料
@property (nonatomic,strong)NSMutableArray *steps;//步骤
@property (nonatomic,strong)NSString *tags;//标签
@property (nonatomic,strong)NSString *title;//菜名
@property (nonatomic,strong)NSString *shareName;//分享菜谱用户名
@property (nonatomic,strong)NSString *nickname;

@end
