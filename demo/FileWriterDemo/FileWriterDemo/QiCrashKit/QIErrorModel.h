//
//  QIErrorModel.h
//  FileWriterDemo
//
//  Created by Xerses on 16/4/8.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QIErrorModel : NSObject
@property (nonatomic,copy) NSString *errorSelecotrName;
@property (nonatomic,copy) NSString *errorMessage;
@property (nonatomic,copy) NSString *errorAddition;
@property (nonatomic,copy) NSString *errorTime;
@property (nonatomic,copy) NSString *errorDevice;

- (instancetype)initWithDict:(NSDictionary *)dic;
+ (id)errorModelWithDictionary:(NSDictionary *)dic;
@end
