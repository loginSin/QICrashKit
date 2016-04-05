//
//  QICrashHandle.m
//  FileWriterDemo
//
//  Created by Xerses on 16/4/1.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import "QICrashHandle.h"
#import "QIFileWriter.h"
#import "QIDeviceInfo.h"

static BOOL needCoverCrashInfo = NO;

@implementation QICrashHandle

/**
 *  是否覆盖之前的数据
 */
+ (void)coverPreviousData {
    needCoverCrashInfo = YES;
}

+ (void)monitor {
    NSSetUncaughtExceptionHandler(&p_MailUncaughtExceptionHandler);
}

+ (BOOL)deleteCrashInfo {
    return [QIFileWriter deleteDataWithFilename:crashFilename];
}

+ (NSArray *)crashInfo {
    return [QIFileWriter dataWithFilename:crashFilename];
}

+ (NSString *)p_filePath {
    return [QIFileWriter filePathWithFilename:crashFilename];
}

void p_MailUncaughtExceptionHandler(NSException * exception){
    
    //获取app名称，用来筛选栈中的错误信息
    NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = appInfo[@"CFBundleName"];
    
    //获取崩溃日志的堆栈信息
    NSArray *array = [exception callStackSymbols];
    NSMutableArray *stackArray = [array mutableCopy];
    
    for(int i=0;i<stackArray.count;i++){
        NSString *errorString = stackArray[i];
        if(![errorString containsString:appName]){
            [stackArray removeObject:errorString];
            i--;
        }
    }
    NSDictionary *dic = @{crashTimekey:deviceToGetCurrentTime(),crashDevicekey:deviceToGetDeviceInfo(),crashInfokey:exception.reason,crashStackkey:stackArray};
    if(needCoverCrashInfo){
        [QIFileWriter coverPreviousDataWithLogType:QILogType_Crash];
    }
    [QIFileWriter appendToFileWithContent:dic withFilename:crashFilename];
}

@end
