//
//  QIDebugModel.m
//  FileWriterDemo
//
//  Created by Xerses on 16/4/8.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import "QIDebugModel.h"

@implementation QIDebugModel
- (instancetype)initWithDict:(NSDictionary *)dic {
    self = [super init];
    if(self){
        self.debugSelecotrName = dic[@"debugSelecotrName"];
        self.debugMessage = dic[@"debugMessage"];
        self.debugAddition = dic[@"debugAddition"];
        self.debugTime = dic[@"debugTime"];
        self.debugDevice = dic[@"debugDevice"];
    }
    return self;
}
+ (id)debugModelWithDictionary:(NSDictionary *)dic {
    return [[self alloc]initWithDict:dic];
}
@end
