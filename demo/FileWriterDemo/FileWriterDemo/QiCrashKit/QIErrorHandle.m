//
//  QIErrorHandle.m
//  FileWriterDemo
//
//  Created by Xerses on 16/4/1.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import "QIErrorHandle.h"
#import "QIFileWriter.h"
#import "QIDeviceInfo.h"

static BOOL needCoverErrorInfo = NO;

@implementation QIErrorHandle

/**
 *  是否覆盖之前的数据
 */
+ (void)coverPreviousData {
    needCoverErrorInfo = YES;
}

+ (BOOL)errorInfoForWriteToFileWithSelectorName:(NSString *)selName errorMessage:(id)message errorAddition:(id)addition {
    NSDictionary *dic = @{errorSelecotrNameKey:selName,errorMessageKey:message,errorAdditionKey:addition,errorTimeKey:deviceToGetCurrentTime(),errorDeviceKey:deviceToGetDeviceInfo()};
    if(needCoverErrorInfo){
        [QIFileWriter coverPreviousDataWithLogType:QILogType_Error];
    }
    return [QIFileWriter appendToFileWithContent:dic withFilename:errorFilename];
}
+ (BOOL)deleteErrorInfo {
    return [QIFileWriter deleteDataWithFilename:errorFilename];
}
+ (NSArray *)errorInfo {
    return [QIFileWriter dataWithFilename:errorFilename];
}
@end
