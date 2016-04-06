//
//  QIFileWriter.m
//  FileWriterDemo
//
//  Created by Xerses on 16/4/1.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import "QIFileWriter.h"

static BOOL needCover = NO;

static BOOL needCoverCrash = NO;//是否覆盖崩溃日志
static BOOL needCoverDebug = NO;//是否覆盖debug日志
static BOOL needCoverError = NO;//是否覆盖error日志
static BOOL needCoverRelease = NO;//是否覆盖release日志
static BOOL needCoverInfo = NO;//是否覆盖info日志

//GCD信号量，用来控制线程安全，详情见YYKit的UIButton+YYWebImage.m
//github:https://github.com/ibireme/YYKit
static dispatch_semaphore_t _preloadedLock;


//另外一种线程安全方式，详情见YYKit的YYMemoryCache.m
//github:https://github.com/ibireme/YYKit

//pthread_mutex_t _lock;                //声明互斥量
//pthread_mutex_init(&_lock, NULL)      //初始化互斥量，在适当时候初始化，一般是类的全能初始化方法中

//pthread_mutex_lock(&_lock);           //使用互斥量锁住线程，在可能会被多线程同时访问的地方加上
//pthread_mutex_unlock(&_lock);         //解锁线程，二者为一组

//pthread_mutex_trylock(&_lock) == 0    //尝试锁住线程，在可能会被多线程同时访问的地方加上
//pthread_mutex_unlock(&_lock)          //解锁线程，二者为一组

//pthread_mutex_destroy(&_lock)         //销毁信号量，在不再需要锁进程的时候销毁，一般在dealloc调用

@implementation QIFileWriter

//该方法在类加载的时候被调用
+ (void)load {
    //正常应该在初始化方法中初始化该信号量，但是这个工具类并不是单例类，写初始化方法并不会起任何作用，所以在此处初始化
    _preloadedLock = dispatch_semaphore_create(1);
}

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
    dispatch_semaphore_wait(_preloadedLock, DISPATCH_TIME_FOREVER);
    NSMutableArray *arrM = [[self data] mutableCopy];
    if(!arrM||needCover){
        arrM = [NSMutableArray array];
    }
    [arrM addObject:obj];
    BOOL result = [arrM writeToFile:[self filePath] atomically:YES];
    dispatch_semaphore_signal(_preloadedLock);
    return result;
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
    dispatch_semaphore_wait(_preloadedLock, DISPATCH_TIME_FOREVER);
    NSString *filePath = [self filePath];
    NSFileManager *manager = [NSFileManager defaultManager];
    if(![manager fileExistsAtPath:filePath]) {
        NSLog(@"该filePath并不存在 %@",filePath);
        return NO;
    }
    NSArray *array = [NSArray array];
    BOOL result = [array writeToFile:filePath atomically:YES];
    dispatch_semaphore_signal(_preloadedLock);
    return result;
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
    dispatch_semaphore_wait(_preloadedLock, DISPATCH_TIME_FOREVER);
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
    BOOL result = [arrM writeToFile:[self filePathWithFilename:filename] atomically:YES];
    dispatch_semaphore_signal(_preloadedLock);
    return result;
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
    dispatch_semaphore_wait(_preloadedLock, DISPATCH_TIME_FOREVER);
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *filePath = [self filePathWithFilename:filename];
    if(![manager fileExistsAtPath:filePath]){
        NSLog(@"该filePath并不存在 %@",filePath);
        return NO;
    }
    NSArray *array = [NSArray array];
    BOOL result = [array writeToFile:filePath atomically:YES];
    dispatch_semaphore_signal(_preloadedLock);
    return result;
}

//获取Documents,该类扩展的私有方法
+ (NSString *)p_filePath {
    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [arr objectAtIndex:0];
}

@end