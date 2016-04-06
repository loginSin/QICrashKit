//
//  QICrashHandle.m
//  FileWriterDemo
//
//  Created by Xerses on 16/4/1.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import "QICrashHandler.h"
#import "QIFileWriter.h"
#import "QIDeviceInfo.h"

static BOOL needCoverCrashInfo = NO;

@implementation QICrashHandler

/**
 *  是否覆盖之前的数据
 */
+ (void)coverPreviousData {
    needCoverCrashInfo = YES;
}
/**
 *  开始监测崩溃日志
 */
+ (void)monitor {
    NSSetUncaughtExceptionHandler(&p_MailUncaughtExceptionHandler);
}

/**
 *  清空之前的日志
 */
+ (BOOL)deleteCrashInfo {
    return [QIFileWriter deleteDataWithFilename:crashFilename];
}

/**
 *  崩溃日志信息
 */
+ (NSArray *)crashInfo {
    return [QIFileWriter dataWithFilename:crashFilename];
}

/**
 *  私有方法，获取日志在沙盒的路径
 */
+ (NSString *)p_filePath {
    return [QIFileWriter filePathWithFilename:crashFilename];
}

/**
 *  私有方法，当有崩溃发生的时候就会调用此方法，在里面进行崩溃日志的保存操作
 */
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
