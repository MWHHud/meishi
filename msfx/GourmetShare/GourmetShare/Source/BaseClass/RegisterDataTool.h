//
//  RegisterDataTool.h
//  GourmetShare
//
//  Created by jang on 15/10/20.
//  Copyright © 2015年 jang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>
@class UserInfoModle;
@interface RegisterDataTool : NSObject


@property (nonatomic,strong)AVObject *postRegister;
@property (nonatomic,strong)NSString *LoginName;//登录用户
@property (nonatomic,strong)AVUser *user;
@property (nonatomic,strong)UserInfoModle *userInfo;//用户信息
@property (nonatomic,strong)NSString *oldHeadImageUrl;


//单例初始化工具类
+(RegisterDataTool *)shareRegisterData;

-(void)podRegisterWith:(RegisterModer *)regist;

-(NSInteger)getRegisterWith:(RegisterModer *)regist;

-(NSString *)getLoginWithName:(NSString *)name;

//用户注册
-(NSInteger)podRegisterWithEmail:(RegisterModer *)regist;

//用户登录
-(BOOL)LoginWithUserName:(NSString *)userName Password:(NSString *)password;

//修改密码
-(BOOL)ChangePasswordWithNewPassword:(NSString *)newPassword;

//忘记密码
-(BOOL)ForgetPasswordWithEmail:(NSString *)aEmail;

//修改资料
-(BOOL)ChangeUserInfoWith:(UserInfoModle *)userInfo;
//修改头像
-(BOOL)ChangeUserHeadImage:(UIImage *)headImage;

//返回图片文件路径
- (NSString *)imageFilePath:(NSString *)name;

@end
