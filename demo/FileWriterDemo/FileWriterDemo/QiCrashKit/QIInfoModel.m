//
//  QIInfoModel.m
//  FileWriterDemo
//
//  Created by Xerses on 16/4/8.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import "QIInfoModel.h"

@implementation QIInfoModel
- (instancetype)initWithDict:(NSDictionary *)dic {
    self = [super init];
    if(self){
        self.infoSelecotrName = dic[@"infoSelecotrName"];
        self.infoMessage = dic[@"infoMessage"];
        self.infoAddition = dic[@"infoAddition"];
        self.infoTime = dic[@"infoTime"];
        self.infoDevice = dic[@"infoDevice"];
    }
    return self;
}
+ (id)infoModelWithDictionary:(NSDictionary *)dic {
    return [[self alloc]initWithDict:dic];
}
@end
