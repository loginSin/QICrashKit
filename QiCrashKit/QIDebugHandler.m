//
//  QIDebugHandle.m
//  FileWriterDemo
//
//  Created by Xerses on 16/4/1.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import "QIDebugHandler.h"
#import "QIFileWriter.h"
#import "QIDeviceInfo.h"

static BOOL needCoverDebugInfo = NO;

@implementation QIDebugHandler

/**
 *  是否覆盖之前的数据
 */
+ (void)coverPreviousData {
    needCoverDebugInfo = YES;
}

/**
 *  保存debug日志到沙盒
 */
+ (BOOL)debugInfoForWriteToFileWithSelectorName:(NSString *)selName debugMessage:(id)message debugAddition:(id)addition {
    if(!message || !addition){
        return NO;
    }
    NSDictionary *dic = @{debugSelecotrNameKey:selName,debugMessageKey:message,debugAdditionKey:addition,debugTimeKey:deviceToGetCurrentTime(),debugDeviceKey:deviceToGetDeviceInfo()};
    if(needCoverDebugInfo) {
        [QIFileWriter coverPreviousDataWithLogType:QILogType_Debug];
    }
    return [QIFileWriter appendToFileWithContent:dic withFilename:debugFilename];
}

/**
 *  清空之前的debug日志
 */
+ (BOOL)deleteDebugInfo {
    return [QIFileWriter deleteDataWithFilename:debugFilename];
}

/**
 *  获取当前的debug日志
 */
+ (NSArray *)debugInfo {
    return [QIFileWriter dataWithFilename:debugFilename];
}
@end
