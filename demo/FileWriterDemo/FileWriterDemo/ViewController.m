//
//  ViewController.m
//  FileWriterDemo
//
//  Created by Xerses on 16/4/1.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import "ViewController.h"
#import "QIFileWriter.h"
#import "QICrashHandler.h"
#import "QIDebugHandler.h"
#import "QIErrorHandler.h"
#import "QIReleaseHandler.h"
#import "QIInfoHandler.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"%@",[QIFileWriter filePath]);
    
    //第一次运行这个项目会报testCrashHandle方法中的NSJSONSerialization空参数的崩溃，同时数据就会被保存在沙盒的崩溃日志文件中
    //点击页面还会触发数组下坐标越界的崩溃，数据会覆盖之前的的崩溃日志，因为在AppDelegate中调用了覆盖之前数据的方法
    [self testCrashHandle];
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"jack" forKey:@"name"];
    [dict setValue:@"1234" forKey:@"pass"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    for(int i=0;i<10;i++){
        [self testDebugHandleWithInfo:str];
        [self testErrorHandleWithInfo:str];
        [self testReleaseHandleWithInfo:str];
        [self testInfoHandleWithInfo:str];
    }
    
}

/**
 *  点击屏幕触发数组坐标越界的崩溃
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //模拟下坐标溢出的崩溃
    NSArray *array = @[@"1"];
    NSString *str = [array objectAtIndex:3];
    NSLog(@"str %@",str);
    
}

- (void)testCrashHandle {
    NSArray *crashArray = [QICrashHandler crashInfo];
    NSLog(@"crashArray %@",crashArray);
    
    NSDictionary *dic = crashArray[0];
    NSData *crashData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *crashMessage = [[NSString alloc]initWithData:crashData encoding:NSUTF8StringEncoding];
    
    UIAlertView *crashAlertView = [[UIAlertView alloc]initWithTitle:@"上次崩溃日志" message:crashMessage delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [crashAlertView show];
}

- (void)testDebugHandleWithInfo:(NSString *)str {
    //覆盖之前的数据
//    [QIDebugHandler coverPreviousData];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
    });
    [QIDebugHandler debugInfoForWriteToFileWithSelectorName:@"getUserInfo" debugMessage:str debugAddition:@"debug"];
    
    NSArray *array = [QIDebugHandler debugInfo];
    NSLog(@"debug array %@",array);
}

- (void)testErrorHandleWithInfo:(NSString *)str {
//    [QIErrorHandler coverPreviousData];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [QIErrorHandler errorInfoForWriteToFileWithSelectorName:@"getUserInfo" errorMessage:str errorAddition:@"error"];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *array = [QIErrorHandler errorInfo];
            NSLog(@"error array %@",array);
        });
    });
    
}

- (void)testReleaseHandleWithInfo:(NSString *)str {
    [QIReleaseHandler coverPreviousData];
    [QIReleaseHandler releaseInfoForWriteToFileWithSelectorName:@"getUserInfo" releaseMessage:str releaseAddition:@"release"];
    
    NSArray *array = [QIReleaseHandler releaseInfo];
    NSLog(@"release array %@",array);
}

- (void)testInfoHandleWithInfo:(NSString *)str {
    [QIInfoHandler coverPreviousData];
    [QIInfoHandler infoInfoForWriteToFileWithSelectorName:@"getUserInfo" infoMessage:str infoAddition:@"info"];
    
    NSArray *array = [QIInfoHandler infoInfo];
    NSLog(@"info array %@",array);
}

@end
