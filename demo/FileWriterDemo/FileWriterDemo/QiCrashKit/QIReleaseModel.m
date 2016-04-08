//
//  QIReleaseModel.m
//  FileWriterDemo
//
//  Created by Xerses on 16/4/8.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import "QIReleaseModel.h"

@implementation QIReleaseModel
- (instancetype)initWithDict:(NSDictionary *)dic {
    self = [super init];
    if(self){
        self.releaseSelecotrName = dic[@"releaseSelecotrName"];
        self.releaseMessage = dic[@"releaseMessage"];
        self.releaseAddition = dic[@"releaseAddition"];
        self.releaseTime = dic[@"releaseTime"];
        self.releaseDevice = dic[@"releaseDevice"];
    }
    return self;
}
+ (id)releaseModelWithDictionary:(NSDictionary *)dic {
    return [[self alloc]initWithDict:dic];
}
@end
