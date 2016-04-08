//
//  QICrashModel.h
//  FileWriterDemo
//
//  Created by Xerses on 16/4/8.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QICrashModel : NSObject
@property (nonatomic,copy) NSString *crashTime;
@property (nonatomic,copy) NSString *crashInfo;
@property (nonatomic,copy) NSString *crashStack;
@property (nonatomic,copy) NSString *crashDevice;

- (instancetype)initWithDict:(NSDictionary *)dic;
+ (id)crashModelWithDictionary:(NSDictionary *)dic;
@end
