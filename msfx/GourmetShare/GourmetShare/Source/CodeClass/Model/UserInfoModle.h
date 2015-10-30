//
//  UserInfoModle.h
//  GourmetShare
//
//  Created by jang on 15/10/24.
//  Copyright © 2015年 jang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModle : NSObject
@property (nonatomic,strong)NSString *headImage;//头像
@property (nonatomic,strong)NSString *nickname;//昵称
@property (nonatomic,strong)NSString *email;//邮箱
@property (nonatomic,strong)NSString *gender;//性别
@property (nonatomic,strong)NSString *hobby;//爱好
@property (nonatomic,strong)NSString *likeFood;//喜欢的食物
@property (nonatomic,strong)NSString *skill;//会做的菜
@end
