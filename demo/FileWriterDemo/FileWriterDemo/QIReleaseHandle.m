//
//  QIReleaseHandle.m
//  FileWriterDemo
//
//  Created by Xerses on 16/4/1.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import "QIReleaseHandle.h"
#import "QIFileWriter.h"

static BOOL needCoverReleaseInfo = NO;

@implementation QIReleaseHandle

/**
 *  是否覆盖之前的数据
 */
+ (void)coverPreviousData {
    needCoverReleaseInfo = YES;
}

+ (BOOL)releaseInfoForWriteToFileWithSelectorName:(NSString *)selName releaseMessage:(id)message releaseAddition:(id)addition {
    NSDictionary *dic = @{releaseSelecotrNameKey:selName,releaseMessageKey:message,releaseAdditionKey:addition};
    if(needCoverReleaseInfo){
        [QIFileWriter coverPreviousDataWithLogType:QILogType_Release];
    }
    return [QIFileWriter appendToFileWithContent:dic withFilename:releaseFilename];
}
+ (BOOL)deletereleaseInfo {
    return [QIFileWriter deleteDataWithFilename:releaseFilename];
}
+ (NSArray *)releaseInfo {
    return [QIFileWriter dataWithFilename:releaseFilename];
}

@end
