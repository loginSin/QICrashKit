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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"%@",[QIFileWriter filePath]);
    
    [QIFileWriter appendToFileWithContent:[@"data" dataUsingEncoding:NSUTF8StringEncoding]];
    NSArray *array = [QIFileWriter data];
    NSLog(@"array %@",array);
    
    [QIFileWriter appendToFileWithContent:@"123" withFilename:debugFilename];
    NSArray *tmpArray = [QIFileWriter dataWithFilename:debugFilename];
    NSLog(@"array %@",tmpArray);
    
    NSArray *crashArray = [QICrashHandle crashInfo];
    NSLog(@"crashArray %@",crashArray);
    
    NSLog(@"%s",__func__);
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //模拟下坐标溢出的崩溃
    NSArray *array = @[@"1"];
    NSString *str = [array objectAtIndex:3];
    NSLog(@"str %@",str);
    
}
@end
