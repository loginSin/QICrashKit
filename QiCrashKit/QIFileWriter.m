//
//  QIFileWriter.m
//  FileWriterDemo
//
//  Created by Xerses on 16/4/1.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import "QIFileWriter.h"

static BOOL needCover = NO;

static BOOL needCoverCrash = NO;
static BOOL needCoverDebug = NO;
static BOOL needCoverError = NO;
static BOOL needCoverRelease = NO;
static BOOL needCoverInfo = NO;

@implementation QIFileWriter

/**
 *  是否覆盖之前的数据
 */
+ (void)coverPreviousData {
    needCover = YES;
}

/**
 *  往文件中追加数据，调用此方法数据默认保存在沙盒的Documents/log.txt中
 */
+ (BOOL)appendToFileWithContent:(id)obj {
    NSMutableArray *arrM = [[self data] mutableCopy];
    if(!arrM||needCover){
        arrM = [NSMutableArray array];
    }
    [arrM addObject:obj];
    return [arrM writeToFile:[self filePath] atomically:YES];
}

/**
 *  从文件中获取数据，调用此方法从沙盒的Documents/log.txt中读取数据
 */
+ (NSArray *)data {
    NSArray *arr = [NSArray arrayWithContentsOfFile:[self filePath]];
    if(!arr) {
        return nil;
    }
    return arr;
}

/**
 *  获取默认文件的路径
 */
+ (NSString *)filePath {
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [NSString stringWithFormat:@"%@/log.txt",docPath];
}

/**
 *  删除默认文件的所有数据
 */
+ (BOOL)deleteData {
    NSString *filePath = [self filePath];
    NSFileManager *manager = [NSFileManager defaultManager];
    if(![manager fileExistsAtPath:filePath]) {
        NSLog(@"该filePath并不存在 %@",filePath);
        return NO;
    }
    NSArray *array = [NSArray array];
    return [array writeToFile:filePath atomically:YES];
}
@end

@implementation QIFileWriter (filename)

/**
 *  覆盖之前的数据
 *  如果调用，该方法需要在所有方法之前调用！！！！
 */
+ (void)coverPreviousDataWithLogType:(QILogType)type {
    if(QILogType_Crash == type){
        needCoverCrash = YES;
    }else if (QILogType_Debug == type){
        needCoverDebug = YES;
    }else if (QILogType_Error == type){
        needCoverError = YES;
    }else if (QILogType_Release == type){
        needCoverRelease = YES;
    }else if (QILogType_Info == type){
        needCoverInfo = YES;
    }
}

/**
 *  存到Documents下指定的文件下
 */
+ (BOOL)appendToFileWithContent:(id)obj withFilename:(NSString *)filename {
    NSMutableArray *arrM = [[self dataWithFilename:filename] mutableCopy];
    //如果从文件中读取的数据为空
    if(!arrM){
        arrM = [NSMutableArray array];
    }
    //如果以后的数据需要覆盖此文件
    if ([self p_needCoverWithfileName:filename]) {
        arrM = [NSMutableArray array];
    }
    [arrM addObject:obj];
    return [arrM writeToFile:[self filePathWithFilename:filename] atomically:YES];
}

+ (BOOL)p_needCoverWithfileName:(NSString *)filename {
    if(needCoverCrash && [filename isEqualToString:crashFilename]){
        return YES;
    }else if(needCoverDebug && [filename isEqualToString:debugFilename]){
        return YES;
    }else if(needCoverError && [filename isEqualToString:errorFilename]){
        return YES;
    }else if (needCoverRelease && [filename isEqualToString:releaseFilename]){
        return YES;
    }else if (needCoverInfo && [filename isEqualToString:infoFilename]){
        return YES;
    }
    return NO;
}

/**
 *  从特定文件中获取数据
 */
+ (NSArray *)dataWithFilename:(NSString *)filename {
    NSArray *arr = [NSArray arrayWithContentsOfFile:[self filePathWithFilename:filename]];
    if(!arr) {
        return nil;
    }
    return arr;
}

/**
 *  获取特定文件的路径
 */
+ (NSString *)filePathWithFilename:(NSString *)filename {
    return [NSString stringWithFormat:@"%@/%@",[self p_filePath],filename];;
}

/**
 *  删除特定文件的所有数据
 */
+ (BOOL)deleteDataWithFilename:(NSString *)filename {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *filePath = [self filePathWithFilename:filename];
    if(![manager fileExistsAtPath:filePath]){
        NSLog(@"该filePath并不存在 %@",filePath);
        return NO;
    }
    NSArray *array = [NSArray array];
    return [array writeToFile:filePath atomically:YES];
}

//获取Documents,该类扩展的私有方法
+ (NSString *)p_filePath {
    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [arr objectAtIndex:0];
}

@end