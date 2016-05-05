//
//  QIErrorHandle.m
//  FileWriterDemo
//
//  Created by Xerses on 16/4/1.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import "QIErrorHandler.h"
#import "QIFileWriter.h"
#import "QIDeviceInfo.h"

static BOOL needCoverErrorInfo = NO;

@implementation QIErrorHandler

/**
 *  是否覆盖之前的数据
 */
+ (void)coverPreviousData {
    needCoverErrorInfo = YES;
}

/**
 *  保存error日志到沙盒
 */
+ (BOOL)errorInfoForWriteToFileWithSelectorName:(NSString *)selName errorMessage:(id)message errorAddition:(id)addition {
    if(!message || !addition){
        return NO;
    }
    NSDictionary *dic = @{errorSelecotrNameKey:selName,errorMessageKey:message,errorAdditionKey:addition,errorTimeKey:deviceToGetCurrentTime(),errorDeviceKey:deviceToGetDeviceInfo()};
    if(needCoverErrorInfo){
        [QIFileWriter coverPreviousDataWithLogType:QILogType_Error];
    }
    return [QIFileWriter appendToFileWithContent:dic withFilename:errorFilename];
}

/**
 *  清空之前的error日志
 */
+ (BOOL)deleteErrorInfo {
    return [QIFileWriter deleteDataWithFilename:errorFilename];
}

/**
 *  获取error日志
 */
+ (NSArray *)errorInfo {
    return [QIFileWriter dataWithFilename:errorFilename];
}
@end
