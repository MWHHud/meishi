//
//  GetFoodDataTool.m
//  GourmetShare
//
//  Created by jang on 15/10/15.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "GetFoodDataTool.h"
#import <AVOSCloud/AVOSCloud.h>
#import "DataBaseHandler.h"

static GetFoodDataTool *gf;
@implementation GetFoodDataTool

//单例初始化工具类
+(GetFoodDataTool *)shareGetFoodData
{
    static dispatch_once_t once_token;
    if (gf == nil) {
        dispatch_once(&once_token, ^{
            gf = [[GetFoodDataTool alloc]init];
        });
    }
    return gf;
}


//返回美食总数据
-(void)getFoodDataWithPassValue:(PassValue)passValue
{
    


    dispatch_queue_t globl_t = dispatch_get_global_queue(0, 0);
    
    dispatch_async(globl_t, ^{
        if ([[DataBaseHandler shareGetFoodData] getAllCategory] == nil) {
        
        AVQuery *query = [AVQuery queryWithClassName:@"postCategory"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                // 检索成功
                for (AVQuery *q in objects) {
                    FoodCategoryModel *f = [[FoodCategoryModel alloc]init];
                    f.name = [q valueForKey:@"name"];
                    f.parentId = [q valueForKey:@"parentId"];
                    [self.dataArr addObject:f];
                }
                passValue(self.dataArr);
                [[DataBaseHandler shareGetFoodData]insertFoodCategoryWith:self.dataArr];
            } else {
               
            }
        }];
        }
        else{
            passValue([[DataBaseHandler shareGetFoodData] getAllCategory]);
        }
    });
    
}

-(NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        self.dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

//根据大分类名返回（标签集合）数据
-(NSArray *)getModleWithName:(NSString *)name
{
    for (FoodCategoryModel *f in _dataArr) {
        if ([f.name isEqualToString:name]) {
            return f.list;
        }
    }
    return 0;
}


//根据大分类ID返回（标签集合）数据
-(NSArray *)getModleWithParentId:(NSString *)parentId
{
    for (FoodCategoryModel *f in _dataArr) {
        if ([f.parentId isEqualToString:parentId]) {
            return f.list;
        }
    }
    return 0;
}


//根据index返回（标签集合）数据
-(NSArray *)getModleWithIndex:(NSInteger)index
{
    return self.dataArr[index];
}


//根据大分类 ID 和 标签 名返回 标签ID
-(NSString *)getIdWithParentId:(NSString *)parentId Name:(NSString *)name
{
    NSArray *tempArry = [NSArray array];
    tempArry = [self getModleWithParentId:parentId];
    for (FoodListModle *f in tempArry) {
        if ([f.name isEqualToString:name]) {
            return f.lid;
        }
    }
    return 0;
}

//根据标签ID返回（菜谱列表）数据
-(NSArray *)getFoodListInfoWithId:(NSString *)lid
{
    self.dataListArr = [NSMutableArray array];
    
    NSString *urlStr = [NSString stringWithFormat:cidURL];
    
    NSURL *url = [NSURL URLWithString:[urlStr stringByAppendingString:lid]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *d in [[dict objectForKey:@"result"] objectForKey:@"data"]) {
            StuffModle *s = [[StuffModle alloc]init];
            [s setValuesForKeysWithDictionary:d];
            [self.dataListArr addObject:s];
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
    return _dataListArr;
}




//根据菜谱ID返回菜谱数据
-(StuffModle *)getFoodInfoWithSid:(NSString *)sid
{
    for (StuffModle *f in self.dataListArr) {
        if ([f.sid isEqualToString:sid]) {
            return f;
        }
    }
    return 0;
}


#pragma mark ========================leancloud

-(void)getListWithParentId:(NSString *)parentId  PassValue:(PassValue)passVallue
{
    dispatch_queue_t globl_t = dispatch_get_global_queue(0, 0);
    NSMutableArray *ListArr = [NSMutableArray array];
    dispatch_async(globl_t, ^{
        
        AVQuery *query = [AVQuery queryWithClassName:@"postList"];
        [query whereKey:@"parentId" equalTo:parentId];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                // 检索成功
                for (AVQuery *q in objects) {
                    FoodListModle *f = [[FoodListModle alloc]init];
                    f.lid = [q valueForKey:@"lid"];
                    f.name = [q valueForKey:@"name"];
                    f.parentId = [q valueForKey:@"parentId"];
                    [ListArr addObject:f];
                }
                passVallue(ListArr);
            } else {
                         }
        }];
    });
}


//根据大分类名返回（标签集合）数据
-(void)getModleWithName:(NSString *)name PassValue:(PassValue)passVallue
{
    dispatch_queue_t globl_t = dispatch_get_global_queue(0, 0);
    self.dataListArr = [NSMutableArray array];
    dispatch_async(globl_t, ^{
        
        if ([[DataBaseHandler shareGetFoodData] findListByName:name] == nil) {
            AVQuery *query = [AVQuery queryWithClassName:@"postList"];
            [query whereKey:@"name" equalTo:name];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    // 检索成功
                    for (AVQuery *q in objects) {
                        FoodListModle *f = [[FoodListModle alloc]init];
                        f.lid = [q valueForKey:@"lid"];
                        f.name = [q valueForKey:@"name"];
                        f.parentId = [q valueForKey:@"parentId"];
                        [self.dataListArr addObject:f];
                    }
                    passVallue(_dataListArr);
                    [[DataBaseHandler shareGetFoodData]insertPostListWith:self.dataListArr];
                } else {
                   
                }
            }];
        }
        else{
            passVallue([[DataBaseHandler shareGetFoodData] findListByName:name]);
        }

    });
}


-(void)getModleWithParentId:(NSString *)parentId PassValue:(PassValue)passVallue
{
    dispatch_queue_t globl_t = dispatch_get_global_queue(0, 0);
    self.dataListArr = [NSMutableArray array];
    dispatch_async(globl_t, ^{
        
        if ([[DataBaseHandler shareGetFoodData] findListByParentId:parentId] == nil) {
            AVQuery *query = [AVQuery queryWithClassName:@"postList"];
            [query whereKey:@"parentId" equalTo:parentId];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    // 检索成功
                   
                    for (AVQuery *q in objects) {
                        FoodListModle *f = [[FoodListModle alloc]init];
                        f.lid = [q valueForKey:@"lid"];
                        f.name = [q valueForKey:@"name"];
                        f.parentId = [q valueForKey:@"parentId"];
                        [self.dataListArr addObject:f];
                    }
                    passVallue(_dataListArr);
                    [[DataBaseHandler shareGetFoodData]insertPostListWith:self.dataListArr];
                    
                } else {
                                  }
            }];
        }
        else{
            passVallue([[DataBaseHandler shareGetFoodData] findListByParentId:parentId]);
        }
    });
}

-(void)getIdWithParentId:(NSString *)parentId Name:(NSString *)name PassId:(PassID)passId
{
    NSArray *tempArry = [NSArray array];
    tempArry = [self getModleWithParentId:parentId];
    for (FoodListModle *f in tempArry) {
        
        if ([f.name isEqualToString:name]) {
            passId(f.lid);
        }
    }
}

-(void)getFoodListInfoWithId:(NSString *)lid PassValue:(PassValue)passVallue
{
    dispatch_queue_t globl_t = dispatch_get_global_queue(0, 0);
    
    dispatch_async(globl_t, ^{
        NSMutableArray *tempArr = [NSMutableArray array];
        if ([[DataBaseHandler shareGetFoodData]findStuffByLid:lid] == nil) {
            AVQuery *query = [AVQuery queryWithClassName:@"postStuff"];
            [query whereKey:@"lid" equalTo:lid];
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
                        [tempArr addObject:s];
                    }
                    passVallue(tempArr);
                    [[DataBaseHandler shareGetFoodData]insertPostStuffWithStuffArr:tempArr lib:lid];
                } else {
                           }
            }];
        }
        else
        {
            passVallue([[DataBaseHandler shareGetFoodData]findStuffByLid:lid]);
        }
    });
}


-(void)getFoodListInfoWithName:(NSString *)name PassValue:(PassValue)passVallue
{
    dispatch_queue_t globl_t = dispatch_get_global_queue(0, 0);
    
    dispatch_async(globl_t, ^{
        NSMutableArray *tempArr = [NSMutableArray array];
        AVQuery *query = [AVQuery queryWithClassName:@"postStuff"];
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
                    [tempArr addObject:s];
                }
                passVallue(tempArr);
            } else {
               
            }
        }];
    });
    
}


-(void)getFoodInfoWithSid:(NSString *)sid stuff:(Stuff)stuff
{
    dispatch_queue_t globl_t = dispatch_get_global_queue(0, 0);
    
    dispatch_async(globl_t, ^{
        if ([[DataBaseHandler shareGetFoodData]findStuffBySid:sid] == nil) {
            AVQuery *query = [AVQuery queryWithClassName:@"postStuff"];
            [query whereKey:@"sid" equalTo:sid];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    // 检索成功
                   
                    AVQuery *q = objects[0];
                    StuffModle *s = [[StuffModle alloc]init];
                    s.albums = [q valueForKey:@"albums"];
                    s.burden = [q valueForKey:@"burden"];
                    s.sid = [q valueForKey:@"sid"];
                    s.imtro = [q valueForKey:@"imtro"];
                    s.ingredients = [q valueForKey:@"ingredients"];
                    NSMutableArray *tempArr = [NSMutableArray array];
                    for (StepModle *sm in [q valueForKey:@"steps"]) {
                        [tempArr addObject:sm];
                    }
                    s.steps = tempArr;
                    s.tags = [q valueForKey:@"tags"];
                    s.title = [q valueForKey:@"title"];
                    stuff(s);
                } else {
                    
                }
            }];
        }
        else
        {
            stuff([[DataBaseHandler shareGetFoodData]findStuffBySid:sid]);
        }
    });
}



-(StuffModle *)getPopFoodInfoWithSid:(NSString *)sid
{
    AVQuery *query = [AVQuery queryWithClassName:@"postStuff"];
    [query whereKey:@"sid" equalTo:sid];
    AVQuery *q = [query findObjects][0];
    StuffModle *s = [[StuffModle alloc]init];
    s.albums = [q valueForKey:@"albums"];
    s.burden = [q valueForKey:@"burden"];
    s.sid = [q valueForKey:@"sid"];
    s.imtro = [q valueForKey:@"imtro"];
    s.ingredients = [q valueForKey:@"ingredients"];
    NSMutableArray *tempArr = [NSMutableArray array];
    for (StepModle *sm in [q valueForKey:@"steps"]) {
        [tempArr addObject:sm];
    }
    s.steps = tempArr;
    s.tags = [q valueForKey:@"tags"];
    s.title = [q valueForKey:@"title"];
    return s;
}


@end
