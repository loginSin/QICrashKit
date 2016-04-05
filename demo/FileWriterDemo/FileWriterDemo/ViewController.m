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
    
//    [QIFileWriter appendToFileWithContent:[@"data" dataUsingEncoding:NSUTF8StringEncoding]];
//    NSArray *array = [QIFileWriter data];
//    NSLog(@"array %@",array);
//    
//    [QIFileWriter appendToFileWithContent:@"123" withFilename:debugFilename];
//    NSArray *tmpArray = [QIFileWriter dataWithFilename:debugFilename];
//    NSLog(@"array %@",tmpArray);
    
//    [self testCrashHandle];
    [self testDebugHandle];
//    [self testErrorHandle];
//    [self testReleaseHandle];
//    [self testInfoHandle];
    
    NSLog(@"%s",__func__);
    
}

- (void)testCrashHandle {
    NSArray *crashArray = [QICrashHandle crashInfo];
    NSLog(@"crashArray %@",crashArray);
}

- (void)testDebugHandle {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"jack" forKey:@"name"];
    [dict setValue:@"1234" forKey:@"pass"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [QIDebugHandle debugInfoForWriteToFileWithSelectorName:@"getUserInfo" debugMessage:str debugAddition:@"addition"];
    
    NSArray *array = [QIDebugHandle debugInfo];
    NSLog(@"debug array %@",array);
    //清除之前的debug信息
    [QIDebugHandle deleteDebugInfo];
}

- (void)testErrorHandle {
    
}

- (void)testReleaseHandle {
    
}

- (void)testInfoHandle {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //模拟下坐标溢出的崩溃
    NSArray *array = @[@"1"];
    NSString *str = [array objectAtIndex:3];
    NSLog(@"str %@",str);
    
}
@end
