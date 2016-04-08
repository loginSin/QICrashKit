//
//  QIReleaseModel.h
//  FileWriterDemo
//
//  Created by Xerses on 16/4/8.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QIReleaseModel : NSObject
@property (nonatomic,copy) NSString *releaseSelecotrName;
@property (nonatomic,copy) NSString *releaseMessage;
@property (nonatomic,copy) NSString *releaseAddition;
@property (nonatomic,copy) NSString *releaseTime;
@property (nonatomic,copy) NSString *releaseDevice;

- (instancetype)initWithDict:(NSDictionary *)dic;
+ (id)releaseModelWithDictionary:(NSDictionary *)dic;
@end
