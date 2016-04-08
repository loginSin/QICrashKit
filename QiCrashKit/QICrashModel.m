//
//  QICrashModel.m
//  FileWriterDemo
//
//  Created by Xerses on 16/4/8.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import "QICrashModel.h"

@implementation QICrashModel
- (instancetype)initWithDict:(NSDictionary *)dic {
    self = [super init];
    if(self){
        self.crashTime = dic[@"crashTime"];
        self.crashInfo = dic[@"crashInfo"];
        self.crashStack = dic[@"crashStack"];
        self.crashDevice = dic[@"crashDevice"];
    }
    return self;
}
+ (id)crashModelWithDictionary:(NSDictionary *)dic {
    return [[self alloc]initWithDict:dic];
}
@end
