//
//  QIDebugHandle.h
//  FileWriterDemo
//
//  Created by Xerses on 16/4/1.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import <Foundation/Foundation.h>

//debug信息字典所有的key
static NSString *debugSelecotrNameKey   = @"debugSelecotrName";//debug信息出现的方法名
static NSString *debugMessageKey        = @"debugMessage";//debug信息
static NSString *debugAdditionKey       = @"debugAddition";//debug信息的附加信息
static NSString *debugTimeKey           = @"debugTime";//debug信息的时间
static NSString *debugDeviceKey         = @"debugDevice";//debug信息的设备信息

/**
 *  debug信息收集类，主要来记录用户自己的调试信息
 *  debug信息没办法自动获取，只能用户在必要的时候添加，这样才能正常的记录debug信息,数据写在Documents/debug.txt
 */
@interface QIDebugHandler : NSObject

/**
 *  覆盖之前的数据
 *  如果调用，该方法需要在所有方法之前调用！！！！
 */
+ (void)coverPreviousData;

/**
 *  将debug信息写入文件，文件路径为Documents/debug.txt
 *
 *  @param selName  方法名
 *  @param message  debug信息，可以是字符串、字典、NSData
 *  @param addition 一些用户自定义的附加信息，可以是字符串、字典、NSData
 *
 *  @return 写入数据是否成功
 */
+ (BOOL)debugInfoForWriteToFileWithSelectorName:(NSString *)selName debugMessage:(id)message debugAddition:(id)addition;

/**
 *  清空之前的debug信息
 *
 *  @return 是否清空成功
 */
+ (BOOL)deleteDebugInfo;

/**
 *  获取debug信息
 *
 *  @return debug数据所在的数组
 */
+ (NSArray *)debugInfo;
@end
