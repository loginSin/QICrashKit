//
//  QIInfoHandle.h
//  FileWriterDemo
//
//  Created by Xerses on 16/4/1.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import <Foundation/Foundation.h>

//info信息字典所有的key
static NSString *infoSelecotrNameKey = @"infoSelecotrName";//info信息出现的方法名
static NSString *infoMessageKey = @"infoMessage";//info信息
static NSString *infoAdditionKey = @"infoAddition";//info信息的附加信息

/**
 *  info信息收集类，主要针对服务器返回给客户端的错误码
 *  info信息没办法自动获取，只能用户在必要的时候添加，这样才能正常的记录info信息
 */
@interface QIInfoHandle : NSObject

/**
 *  覆盖之前的数据
 *  如果调用，该方法需要在所有方法之前调用！！！！
 */
+ (void)coverPreviousData;

/**
 *  将info信息写入文件，文件路径为Documents/info.txt
 *
 *  @param selName  方法名
 *  @param message  info信息
 *  @param addition 一些用户自定义的附加信息
 *
 *  @return 写入数据是否成功
 */
+ (BOOL)infoInfoForWriteToFileWithSelectorName:(NSString *)selName infoMessage:(id)message infoAddition:(id)addition;

/**
 *  清空之前的info信息
 *
 *  @return 是否清空成功
 */
+ (BOOL)deleteinfoInfo;

/**
 *  获取info信息
 *
 *  @return info数据所在的数组
 */
+ (NSArray *)infoInfo;


@end
