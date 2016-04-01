//
//  QIReleaseHandle.h
//  FileWriterDemo
//
//  Created by Xerses on 16/4/1.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import <Foundation/Foundation.h>
//release信息字典所有的key
static NSString *releaseSelecotrNameKey = @"releaseSelecotrName";//release信息出现的方法名
static NSString *releaseMessageKey = @"releaseMessage";//release信息
static NSString *releaseAdditionKey = @"releaseAddition";//release信息的附加信息

/**
 *  release信息收集类，主要针对服务器返回给客户端的错误码
 *  release信息没办法自动获取，只能用户在必要的时候添加，这样才能正常的记录release信息
 */
@interface QIReleaseHandle : NSObject

/**
 *  覆盖之前的数据
 *  如果调用，该方法需要在所有方法之前调用！！！！
 */
+ (void)coverPreviousData;

/**
 *  将release信息写入文件，文件路径为Documents/release.txt
 *
 *  @param selName  方法名
 *  @param message  release信息
 *  @param addition 一些用户自定义的附加信息
 *
 *  @return 写入数据是否成功
 */
+ (BOOL)releaseInfoForWriteToFileWithSelectorName:(NSString *)selName releaseMessage:(id)message releaseAddition:(id)addition;

/**
 *  清空之前的release信息
 *
 *  @return 是否清空成功
 */
+ (BOOL)deletereleaseInfo;

/**
 *  获取release信息
 *
 *  @return release数据所在的数组
 */
+ (NSArray *)releaseInfo;
@end
