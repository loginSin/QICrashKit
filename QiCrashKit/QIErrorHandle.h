//
//  QIErrorHandle.h
//  FileWriterDemo
//
//  Created by Xerses on 16/4/1.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import <Foundation/Foundation.h>

//error信息字典所有的key
static NSString *errorSelecotrNameKey = @"errorSelecotrName";//error信息出现的方法名
static NSString *errorMessageKey = @"errorMessage";//error信息
static NSString *errorAdditionKey = @"errorAddition";//error信息的附加信息

/**
 *  error信息收集类，主要针对服务器返回给客户端的错误码
 *  error信息没办法自动获取，只能用户在必要的时候添加，这样才能正常的记录error信息
 */
@interface QIErrorHandle : NSObject

/**
 *  覆盖之前的数据
 *  如果调用，该方法需要在所有方法之前调用！！！！
 */
+ (void)coverPreviousData;

/**
 *  将error信息写入文件，文件路径为Documents/error.txt
 *
 *  @param selName  方法名
 *  @param message  error信息
 *  @param addition 一些用户自定义的附加信息
 *
 *  @return 写入数据是否成功
 */
+ (BOOL)errorInfoForWriteToFileWithSelectorName:(NSString *)selName errorMessage:(id)message errorAddition:(id)addition;

/**
 *  清空之前的error信息
 *
 *  @return 是否清空成功
 */
+ (BOOL)deleteErrorInfo;

/**
 *  获取error信息
 *
 *  @return error数据所在的数组
 */
+ (NSArray *)errorInfo;
@end
