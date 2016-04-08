//
//  QIErrorModel.m
//  FileWriterDemo
//
//  Created by Xerses on 16/4/8.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import "QIErrorModel.h"

@implementation QIErrorModel
- (instancetype)initWithDict:(NSDictionary *)dic {
    self = [super init];
    if(self){
        self.errorSelecotrName = dic[@"errorSelecotrName"];
        self.errorMessage = dic[@"errorMessage"];
        self.errorAddition = dic[@"errorAddition"];
        self.errorTime = dic[@"errorTime"];
        self.errorDevice = dic[@"errorDevice"];
    }
    return self;
}
+ (id)errorModelWithDictionary:(NSDictionary *)dic {
    return [[self alloc]initWithDict:dic];
}
@end
