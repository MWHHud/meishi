//
//  LoginDataTool.m
//  GourmetShare
//
//  Created by jang on 15/10/21.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "LoginDataTool.h"
static LoginDataTool *ld;
@implementation LoginDataTool

+(LoginDataTool *)shareLoginData
{
    static dispatch_once_t once_token;
    if (ld == nil) {
        dispatch_once(&once_token, ^{
            ld = [[LoginDataTool alloc]init];
        });
    }
    return ld;
}

-(BOOL)NewFavoriteWithNew:(News *)aNew
{
    NSString *name = [RegisterDataTool shareRegisterData].LoginName;
    if (name == nil) {
        return NO;
    }
    self.postNew = [AVObject objectWithClassName:[NSString stringWithFormat:@"%@New",name]];
    [_postNew setObject:name forKey:@"name"];
    [_postNew setObject:aNew.cid forKey:@"cid"];
    [_postNew setObject:aNew.content forKey:@"content"];
    [_postNew setObject:aNew.contents forKey:@"contents"];
    [_postNew setObject:aNew.image forKey:@"image"];
    [_postNew setObject:aNew.title forKey:@"title"];
    [_postNew setObject:aNew.tags forKey:@"tags"];
    [_postNew save];
    
    AVQuery *queryName = [AVQuery queryWithClassName:[NSString stringWithFormat:@"%@New",name]];
    [queryName whereKey:@"cid" equalTo:aNew.cid];
    if ([[queryName findObjects] count] == 0) {
        return NO;
    }
    
    return YES;
}

-(BOOL)FoodFavoriteWithStuffModle:(StuffModle *)stuff
{
    NSString *name = [RegisterDataTool shareRegisterData].LoginName;
    if (name == nil) {
        return NO;
    }
    self.postStuffModle = [AVObject objectWithClassName:[NSString stringWithFormat:@"%@Food",name]];
    [_postStuffModle setObject:name forKey:@"name"];
    [_postStuffModle setObject:stuff.albums forKey:@"albums"];
    [_postStuffModle setObject:stuff.burden forKey:@"burden"];
    [_postStuffModle setObject:stuff.sid forKey:@"sid"];
    [_postStuffModle setObject:stuff.imtro forKey:@"imtro"];
    [_postStuffModle setObject:stuff.ingredients forKey:@"ingredients"];
    [_postStuffModle setObject:stuff.steps forKey:@"steps"];
    [_postStuffModle setObject:stuff.tags forKey:@"tags"];
    [_postStuffModle setObject:stuff.title forKey:@"title"];
    [_postStuffModle save];
    
    AVQuery *queryName = [AVQuery queryWithClassName:[NSString stringWithFormat:@"%@Food",name]];
    [queryName whereKey:@"sid" equalTo:stuff.sid];
    if ([[queryName findObjects] count] == 0) {
        return NO;
    }
    
    return YES;
}

//返回美食收藏
- (void)getFoodDataWithName:(NSString *)name PassValue:(PassValue)passValue
{
    dispatch_queue_t globl_t = dispatch_get_global_queue(0, 0);
    NSMutableArray *food = [NSMutableArray array];
    dispatch_async(globl_t, ^{
        
        AVQuery *query = [AVQuery queryWithClassName:[NSString stringWithFormat:@"%@Food",name]];
        [query whereKey:@"name" equalTo:name];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                // 检索成功
                for (AVQuery *q in objects) {
                    StuffModle *s = [[StuffModle alloc]init];
                    s.albums = [q valueForKey:@"albums"];
                    s.burden = [q valueForKey:@"burden"];
                    s.sid = [q valueForKey:@"sid"];
                    s.imtro = [q valueForKey:@"imtro"];
                    s.ingredients = [q valueForKey:@"ingredients"];
                    NSMutableArray *stArr = [NSMutableArray array];
                    for (StepModle *st in [q valueForKey:@"steps"]) {
                        [stArr addObject:st];
                    }
                    s.steps = stArr;
                    s.tags = [q valueForKey:@"tags"];
                    s.title = [q valueForKey:@"title"];
                    [food addObject:s];
                }
                passValue(food);
            } else {

            }
        }];
    });
}

//返回新闻收藏
- (void)getNewsDataWithName:(NSString *)name PassValue:(PassValue)passValue;
{
    dispatch_queue_t globl_t = dispatch_get_global_queue(0, 0);
    NSMutableArray *new = [NSMutableArray array];
    dispatch_async(globl_t, ^{
        
        AVQuery *query = [AVQuery queryWithClassName:[NSString stringWithFormat:@"%@New",name]];
        [query whereKey:@"name" equalTo:name];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                // 检索成功
                [_postNew setObject:name forKey:@"name"];
                for (AVQuery *q in objects) {
                    News *s = [[News alloc]init];
                    s.cid = [q valueForKey:@"cid"];
                    s.content = [q valueForKey:@"content"];
                    s.image = [q valueForKey:@"image"];
                    s.title = [q valueForKey:@"title"];
                    s.tags = [q valueForKey:@"tags"];
                    [new addObject:s];
                }
                passValue(new);
            } else {

            }
        }];
    });
}

@end
