//
//  GetNewsDataTool.m
//  GourmetShare
//
//  Created by jang on 15/10/18.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "GetNewsDataTool.h"
static GetNewsDataTool *gd;
@implementation GetNewsDataTool

//单例初始化工具类
+ (GetNewsDataTool *)shareGetNewsData
{
    static dispatch_once_t once_token;
    if (gd == nil) {
        dispatch_once(&once_token, ^{
            gd = [[GetNewsDataTool alloc]init];
        });
    }
    return gd;
}

//返回新闻信息
- (void)getNewsDataWithPassValue:(PassValue)passValue
{
    dispatch_queue_t globl_t = dispatch_get_global_queue(0, 0);
    
    dispatch_async(globl_t, ^{
        self.dataArr = [NSMutableArray array];
        
        //1.请求管理器
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        //2.发起请求
        [manager GET:newsURL parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            
            // 检索成功
            NSString *html = operation.responseString;
            NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

            for (NSDictionary *d in [[dict objectForKey:@"data"] objectForKey:@"article"] ) {
                News *aNew = [[News alloc]init];
                [aNew setValuesForKeysWithDictionary:d];
                [_dataArr addObject:aNew];
            }
            passValue(self.dataArr);
            
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        }];
    });

}

@end
