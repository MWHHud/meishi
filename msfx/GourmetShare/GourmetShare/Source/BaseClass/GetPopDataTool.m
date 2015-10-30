//
//  GetPopDataTool.m
//  GourmetShare
//
//  Created by lanou3g on 15/10/19.
//  Copyright © 2015年 jang. All rights reserved.
//

#import "GetPopDataTool.h"

static GetPopDataTool *pData;

@implementation GetPopDataTool

+(GetPopDataTool *)shareGetPopData
{
    static dispatch_once_t once_token;
    if (pData == nil) {
        dispatch_once(&once_token, ^{
            pData = [[GetPopDataTool alloc]init];
        });
    }
    return pData;
}


-(void)getPopDataWithPassValue:(PassValue)passValue
{
    dispatch_queue_t globl_t = dispatch_get_global_queue(0, 0);
    dispatch_async(globl_t, ^{
       
        self.dataArray = [NSMutableArray array];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:popURL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            
            NSString *html = operation.responseString;
            NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *arr = [NSArray arrayWithObject:[[dict objectForKey:@"S1426836893754"] objectForKey:@"topics"]];
            for (NSDictionary *d in  [arr[0][0] objectForKey:@"docs"]) {
                PopNews *pNew = [[PopNews alloc]init];
                [pNew setValuesForKeysWithDictionary:d];
                [_dataArray addObject:pNew];
            }
            passValue(self.dataArray);
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        }];
        
    });
}

-(PopNews *)getPopNewsWithIndex:(NSInteger)index
{
    return self.dataArray[index];
}

-(void)getNewsDataWithDocid:(NSString *)docid Pdetail:(PDetail)detail
{

    NSString *urlStr = [NSString stringWithFormat:detailURL,docid];
    
    
    //1.请求管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  
    //2.发起请求
    [manager GET:urlStr parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 检索成功
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
       self.newsdetail = [[NewsDetail alloc]init];
        [self.newsdetail setValuesForKeysWithDictionary:[dict objectForKey:docid]];
        detail(self.newsdetail);
    }
         failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
 
}

@end
