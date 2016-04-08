//
//  QIInfoModel.h
//  FileWriterDemo
//
//  Created by Xerses on 16/4/8.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QIInfoModel : NSObject
@property (nonatomic,copy) NSString *infoSelecotrName;
@property (nonatomic,copy) NSString *infoMessage;
@property (nonatomic,copy) NSString *infoAddition;
@property (nonatomic,copy) NSString *infoTime;
@property (nonatomic,copy) NSString *infoDevice;

- (instancetype)initWithDict:(NSDictionary *)dic;
+ (id)infoModelWithDictionary:(NSDictionary *)dic;
@end
