//
//  GetShareDataTool.m
//  GourmetShare
//
//  Created by jang on 15/10/22.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "GetShareDataTool.h"
#import "UserInfoModle.h"
static GetShareDataTool *gs;
@implementation GetShareDataTool
//单例初始化工具类
+(GetShareDataTool *)shareShareData
{
    static dispatch_once_t once_token;
    if (gs == nil) {
        dispatch_once(&once_token, ^{
            gs = [[GetShareDataTool alloc]init];
        });
    }
    return gs;
}

//用户分享食谱
-(BOOL)podShareWith:(StuffModle *)stuff UserName:(NSString *)userName Image:(UIImage *)image
{
    self.postShareite = [AVObject objectWithClassName:@"postShare"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSDate *date = [NSDate  dateWithTimeIntervalSinceNow:3600*2];
    [formatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    NSString * strdate = [formatter stringFromDate:date];
    NSString *sid = [NSString stringWithFormat:@"%@-%@",userName,strdate];
    NSString *fileName = [NSString stringWithFormat:@"%@-%@.JPEG",userName,strdate];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.01);
    AVFile *file = [AVFile fileWithName:fileName data:imageData];
    [file save];
    [_postShareite setObject:sid forKey:@"sid"];
    [_postShareite setObject:userName forKey:@"userName"];
    [_postShareite setObject:file.url forKey:@"albums"];
    [_postShareite setObject:stuff.imtro forKey:@"imtro"];
    [_postShareite setObject:stuff.ingredients forKey:@"ingredients"];
    [_postShareite setObject:stuff.title forKey:@"title"];
    [_postShareite setObject:[RegisterDataTool shareRegisterData].userInfo.nickname forKey:@"nickname"];
    
    NSError *error = [[NSError alloc]init];
    if ([_postShareite save:&error]) {
        return YES;
    }
    
    [file deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    }];
    return NO;
}

//获取全部用户分享列表
-(void)getShareWithPassValue:(PassValue)passVallue
{
    
    NSMutableArray *tempArr = [NSMutableArray array];
    AVQuery *query = [AVQuery queryWithClassName:@"postShare"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // 检索成功
            for (AVQuery *q in objects) {
                StuffModle *s = [[StuffModle alloc]init];
                s.sid = [q valueForKey:@"sid"];
                s.shareName = [q valueForKey:@"userName"];
                NSMutableArray *temp = [NSMutableArray array];
                [temp addObject:[q valueForKey:@"albums"]];
                s.albums = temp;
                s.imtro = [q valueForKey:@"imtro"];
                s.ingredients = [q valueForKey:@"ingredients"];
                s.title = [q valueForKey:@"title"];
                s.nickname = [q valueForKey:@"nickname"];
                [tempArr addObject:s];
            }
            passVallue(tempArr);
        } else {

        }
    }];
}


//获取我的用户分享
-(void)getShareWithUserName:(NSString *)userName PassValue:(PassValue)passVallue
{
    NSMutableArray *tempArr = [NSMutableArray array];
    AVQuery *query = [AVQuery queryWithClassName:@"postShare"];
    [query whereKey:@"userName" equalTo:userName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // 检索成功
            for (AVQuery *q in objects) {
                StuffModle *s = [[StuffModle alloc]init];
                s.sid = [q valueForKey:@"sid"];
                s.shareName = [q valueForKey:@"userName"];
                NSMutableArray *temp = [NSMutableArray array];
                [temp addObject:[q valueForKey:@"albums"]];
                s.albums = temp;
                s.imtro = [q valueForKey:@"imtro"];
                s.ingredients = [q valueForKey:@"ingredients"];
                s.title = [q valueForKey:@"title"];
                s.nickname = [q valueForKey:@"nickname"];
                [tempArr addObject:s];
            }
            passVallue(tempArr);
        } else {

        }
    }];
}

//用户删除分享
-(BOOL)deleteShareWithUserName:(NSString *)userName Sid:(NSString *)sid
{
    AVQuery *query = [AVQuery queryWithClassName:@"postShare"];
    [query whereKey:@"userName" equalTo:userName];
    [query whereKey:@"sid" equalTo:sid];
    if ([query findObjects] > 0) {
        AVObject *q =[query findObjects][0];
        if ([q delete]) {
            AVQuery *imageQuery = [AVQuery queryWithClassName:@"_File"];
            NSMutableArray *temp = [NSMutableArray array];
            [temp addObject:[q valueForKey:@"albums"]];
            [imageQuery whereKey:@"url" equalTo:temp[0]];
            AVFile *deleteFile = [AVFile fileWithAVObject:[imageQuery findObjects][0]];
            [deleteFile deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
            }];
            return YES;
        }
        return NO;
    }
    return NO;
}
@end
