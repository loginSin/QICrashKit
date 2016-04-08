//
//  QIDebugModel.h
//  FileWriterDemo
//
//  Created by Xerses on 16/4/8.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QIDebugModel : NSObject
@property (nonatomic,copy) NSString *debugSelecotrName;
@property (nonatomic,copy) NSString *debugMessage;
@property (nonatomic,copy) NSString *debugAddition;
@property (nonatomic,copy) NSString *debugTime;
@property (nonatomic,copy) NSString *debugDevice;

- (instancetype)initWithDict:(NSDictionary *)dic;
+ (id)debugModelWithDictionary:(NSDictionary *)dic;
@end
