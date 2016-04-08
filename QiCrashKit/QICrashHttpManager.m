//
//  QICrashHttpManager.m
//  FileWriterDemo
//
//  Created by Xerses on 16/4/8.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import "QICrashHttpManager.h"

@implementation QICrashHttpManager
+ (id)sharedInstance {
    static QICrashHttpManager *manager ;
    static dispatch_once_t once ;
    dispatch_once(&once, ^{
        manager = [[[self class] alloc] init];
    });
    return manager;
}
- (void)uploadLogWithUrl:(NSString *)url
               paramters:(id)param
                 logType:(QILogType)type
            successBlock:(void(^)(NSData *data))aSuccessBlock
               failBlock:(void(^)(NSError *error))aFailBlock {
    
    NSURLRequest *request = [self p_uploadUrlRequestWithUrl:url paramters:param logType:type];
    
    [self p_executeAsycRequest:request queue:[NSOperationQueue new] successBlock:^(NSData *data) {
        aSuccessBlock(data);
    } failBlock:^(NSError *error) {
        aFailBlock(error);
    }];
    
}

- (void)downloadLogWithUrl:(NSString *)url
                 paramters:(id)param
                   logType:(QILogType)type
              successBlock:(void(^)(NSData *data))aSuccessBlock
                 failBlock:(void(^)(NSError *error))aFailBlock {
    
    NSURLRequest *request = [self p_downloadUrlRequestWithUrl:url paramters:param logType:type];
    
    [self p_executeAsycRequest:request queue:[NSOperationQueue new] successBlock:^(NSData *data) {
        aSuccessBlock(data);
    } failBlock:^(NSError *error) {
        aFailBlock(error);
    }];
}

- (void)p_executeAsycRequest:(NSURLRequest *)request
                       queue:(NSOperationQueue *)queue 
                successBlock:(void(^)(NSData *data))aSuccessBlock
                   failBlock:(void(^)(NSError *error))aFailBlock{
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(connectionError){
                aFailBlock(connectionError);
                return ;
            }
            //在主线程中处理服务器返回的数据
            //目前没有服务器，我也不知道该怎么做了
        });
    }];
}

- (NSURLRequest *)p_uploadUrlRequestWithUrl:(NSString *)url paramters:(id)param logType:(QILogType)type {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.timeoutInterval = 5;
    [request setHTTPMethod:@"POST"];
    [request setValue:@"Keep-Alive" forHTTPHeaderField:@"Connection"];
    [request setValue:@"UTF-8" forHTTPHeaderField:@"Charset"];
    [request setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSArray *array = (NSArray *)param;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    if(error){
        NSLog(@"error occured");
    }
#if TARGET_IPHONE_SIMULATOR
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"jsonString %@",jsonString);
#endif
    [request setHTTPBody:jsonData];
    
    return request;
}

- (NSURLRequest *)p_downloadUrlRequestWithUrl:(NSString *)url paramters:(id)param logType:(QILogType)type  {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.timeoutInterval = 15;
    [request setHTTPMethod:@"POST"];
    [request setValue:@"Keep-Alive" forHTTPHeaderField:@"Connection"];
    [request setValue:@"UTF-8" forHTTPHeaderField:@"Charset"];
    [request setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary *dic = (NSDictionary *)param;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    if(error){
        NSLog(@"error occured");
    }
#if TARGET_IPHONE_SIMULATOR
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"jsonString %@",jsonString);
#endif
    [request setHTTPBody:jsonData];
    
    return request;
}
@end
