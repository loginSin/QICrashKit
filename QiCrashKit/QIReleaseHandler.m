//
//  QIReleaseHandle.m
//  FileWriterDemo
//
//  Created by Xerses on 16/4/1.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import "QIReleaseHandler.h"
#import "QIFileWriter.h"
#import "QIDeviceInfo.h"

static BOOL needCoverReleaseInfo = NO;

@implementation QIReleaseHandler

/**
 *  是否覆盖之前的数据
 */
+ (void)coverPreviousData {
    needCoverReleaseInfo = YES;
}

/**
 *  保存release日志到沙盒
 */
+ (BOOL)releaseInfoForWriteToFileWithSelectorName:(NSString *)selName releaseMessage:(id)message releaseAddition:(id)addition {
    NSDictionary *dic = @{releaseSelecotrNameKey:selName,releaseMessageKey:message,releaseAdditionKey:addition,releaseTimeKey:deviceToGetCurrentTime(),releaseDeviceKey:deviceToGetDeviceInfo()};
    if(needCoverReleaseInfo){
        [QIFileWriter coverPreviousDataWithLogType:QILogType_Release];
    }
    return [QIFileWriter appendToFileWithContent:dic withFilename:releaseFilename];
}

/**
 *  清空release日志
 */
+ (BOOL)deleteReleaseInfo {
    return [QIFileWriter deleteDataWithFilename:releaseFilename];
}

/**
 *  获取release日志
 */
+ (NSArray *)releaseInfo {
    return [QIFileWriter dataWithFilename:releaseFilename];
}

@end
