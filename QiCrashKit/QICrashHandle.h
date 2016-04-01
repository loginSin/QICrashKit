//
//  QICrashHandle.h
//  FileWriterDemo
//
//  Created by Xerses on 16/4/1.
//  Copyright © 2016年 loginSin. All rights reserved.
//


#import <Foundation/Foundation.h>
//崩溃信息的字典包含的所有的key
static NSString *exceptionTimekey = @"exceptionTime";//崩溃时间
static NSString *exceptionInfokey = @"exceptionInfo";//崩溃信息
static NSString *exceptionStackkey = @"exceptionStack";//崩溃时的堆栈情况
static NSString *exceptionDevicekey = @"exceptionDevice";//发生崩溃的设备情况

/**
 *  崩溃检测类,当崩溃发生的时候可以自动检测，崩溃日志写在app的Documents/crash.txt中
 */
@interface QICrashHandle : NSObject

/**
 *  覆盖之前的数据
 *  如果调用，该方法需要在所有方法之前调用！！！！
 */
+ (void)coverPreviousData;

/**
 *  开始监测,必须在appDelegate中调用
 *  @discussion 崩溃日志写在app的Documents/crash.txt中
 */
+ (void)monitor;

/**
 *  删除捕获到的崩溃信息
 *
 *  @return 是否删除成功
 */
+ (BOOL)deleteExceptionInfo;

/**
 *  崩溃信息
 *
 *  @return 奔溃信息的数组，
 */
+ (NSArray *)crashInfo;
@end
