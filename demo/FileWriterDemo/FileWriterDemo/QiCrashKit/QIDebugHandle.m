//
//  QIDebugHandle.m
//  FileWriterDemo
//
//  Created by Xerses on 16/4/1.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import "QIDebugHandle.h"
#import "QIFileWriter.h"
#import "QIDeviceInfo.h"

static BOOL needCoverDebugInfo = NO;

@implementation QIDebugHandle

/**
 *  是否覆盖之前的数据
 */
+ (void)coverPreviousData {
    needCoverDebugInfo = YES;
}

+ (BOOL)debugInfoForWriteToFileWithSelectorName:(NSString *)selName debugMessage:(id)message debugAddition:(id)addition {
    NSDictionary *dic = @{debugSelecotrNameKey:selName,debugMessageKey:message,debugAdditionKey:addition,debugTimeKey:deviceToGetCurrentTime(),debugDeviceKey:deviceToGetDeviceInfo()};
    if(needCoverDebugInfo) {
        [QIFileWriter coverPreviousDataWithLogType:QILogType_Debug];
    }
    return [QIFileWriter appendToFileWithContent:dic withFilename:debugFilename];
}
+ (BOOL)deleteDebugInfo {
    return [QIFileWriter deleteDataWithFilename:debugFilename];
}
+ (NSArray *)debugInfo {
    return [QIFileWriter dataWithFilename:debugFilename];
}
@end
