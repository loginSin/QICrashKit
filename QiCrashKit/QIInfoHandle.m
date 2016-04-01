//
//  QIInfoHandle.m
//  FileWriterDemo
//
//  Created by Xerses on 16/4/1.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import "QIInfoHandle.h"
#import "QIFileWriter.h"

static BOOL needCoverInfo = NO;

@implementation QIInfoHandle

/**
 *  是否覆盖之前的数据
 */
+ (void)coverPreviousData {
    needCoverInfo = YES;
}

+ (BOOL)infoInfoForWriteToFileWithSelectorName:(NSString *)selName infoMessage:(id)message infoAddition:(id)addition {
    NSDictionary *dic = @{infoSelecotrNameKey:selName,infoMessageKey:message,infoAdditionKey:addition};
    if(needCoverInfo){
        [QIFileWriter coverPreviousDataWithLogType:QILogType_Info];
    }
    return [QIFileWriter appendToFileWithContent:dic withFilename:infoFilename];
}
+ (BOOL)deleteinfoInfo {
    return [QIFileWriter deleteDataWithFilename:infoFilename];
}
+ (NSArray *)infoInfo {
    return [QIFileWriter dataWithFilename:infoFilename];
}
@end
