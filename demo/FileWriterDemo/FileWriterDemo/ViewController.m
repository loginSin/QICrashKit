//
//  ViewController.m
//  FileWriterDemo
//
//  Created by Xerses on 16/4/1.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import "ViewController.h"
#import "QIFileWriter.h"
#import "QICrashHandle.h"
#import "QIDebugHandle.h"
#import "QIErrorHandle.h"
#import "QIReleaseHandle.h"
#import "QIInfoHandle.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"%@",[QIFileWriter filePath]);
    
    
//    [self testCrashHandle];
    [self testDebugHandle];
    [self testErrorHandle];
    [self testReleaseHandle];
    [self testInfoHandle];
    
    NSLog(@"%s",__func__);
    
}

- (void)testCrashHandle {
    NSArray *crashArray = [QICrashHandle crashInfo];
    NSLog(@"crashArray %@",crashArray);
}

- (void)testDebugHandle {
    [QIDebugHandle coverPreviousData];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"jack" forKey:@"name"];
    [dict setValue:@"1234" forKey:@"pass"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [QIDebugHandle debugInfoForWriteToFileWithSelectorName:@"getUserInfo" debugMessage:str debugAddition:@"debug"];
    
    NSArray *array = [QIDebugHandle debugInfo];
    NSLog(@"debug array %@",array);
}

- (void)testErrorHandle {
    [QIErrorHandle coverPreviousData];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"jack" forKey:@"name"];
    [dict setValue:@"1234" forKey:@"pass"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [QIErrorHandle errorInfoForWriteToFileWithSelectorName:@"getUserInfo" errorMessage:str errorAddition:@"error"];
    
    NSArray *array = [QIErrorHandle errorInfo];
    NSLog(@"error array %@",array);
}

- (void)testReleaseHandle {
    [QIReleaseHandle coverPreviousData];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"jack" forKey:@"name"];
    [dict setValue:@"1234" forKey:@"pass"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [QIReleaseHandle releaseInfoForWriteToFileWithSelectorName:@"getUserInfo" releaseMessage:str releaseAddition:@"release"];
    
    NSArray *array = [QIReleaseHandle releaseInfo];
    NSLog(@"release array %@",array);
}

- (void)testInfoHandle {
    [QIInfoHandle coverPreviousData];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"jack" forKey:@"name"];
    [dict setValue:@"1234" forKey:@"pass"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [QIInfoHandle infoInfoForWriteToFileWithSelectorName:@"getUserInfo" infoMessage:str infoAddition:@"info"];
    
    NSArray *array = [QIInfoHandle infoInfo];
    NSLog(@"info array %@",array);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //模拟下坐标溢出的崩溃
    NSArray *array = @[@"1"];
    NSString *str = [array objectAtIndex:3];
    NSLog(@"str %@",str);
    
}
@end
