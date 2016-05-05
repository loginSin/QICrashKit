//
//  QIInfoHandle.m
//  FileWriterDemo
//
//  Created by Xerses on 16/4/1.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import "QIInfoHandler.h"
#import "QIFileWriter.h"
#import "QIDeviceInfo.h"

static BOOL needCoverInfo = NO;

@implementation QIInfoHandler

/**
 *  是否覆盖之前的数据
 */
+ (void)coverPreviousData {
    needCoverInfo = YES;
}

/**
 *  保存info日志到沙盒
 */
+ (BOOL)infoInfoForWriteToFileWithSelectorName:(NSString *)selName infoMessage:(id)message infoAddition:(id)addition {
    if(!message || !addition){
        return NO;
    }
    NSDictionary *dic = @{infoSelecotrNameKey:selName,infoMessageKey:message,infoAdditionKey:addition,infoTimeKey:deviceToGetCurrentTime(),infoDeviceKey:deviceToGetDeviceInfo()};
    if(needCoverInfo){
        [QIFileWriter coverPreviousDataWithLogType:QILogType_Info];
    }
    return [QIFileWriter appendToFileWithContent:dic withFilename:infoFilename];
}

/**
 *  清空之前的info日志
 */
+ (BOOL)deleteinfoInfo {
    return [QIFileWriter deleteDataWithFilename:infoFilename];
}

/**
 *  获取info日志
 */
+ (NSArray *)infoInfo {
    return [QIFileWriter dataWithFilename:infoFilename];
}
@end
