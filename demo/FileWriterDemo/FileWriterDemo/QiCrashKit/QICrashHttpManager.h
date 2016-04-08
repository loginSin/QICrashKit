//
//  QICrashHttpManager.h
//  FileWriterDemo
//
//  Created by Xerses on 16/4/8.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QIFileWriter.h"

/**
 *  日志http管理者，负责将日志信息上传到服务器，或将日志信息从服务器下载
 */
@interface QICrashHttpManager : NSObject
/**
 *  此类是单例类，创建单例的方法
 *
 *  @return 返回实例对象
 */
+ (id)sharedInstance;

/**
 *  单例类，禁止用户使用init方法来创建实例
 */
- (instancetype)init NS_UNAVAILABLE;
/**
 *  单例类，禁止用户使用new方法来创建实例
 */
+ (instancetype)new NS_UNAVAILABLE;

/**
 *  上传日志
 *
 *  @param url           url
 *  @param param         日志数据
 *  @param type          日志类型：crash、debug、error、info、release
 *  @param aSuccessBlock 上传成功的block，包含从服务器获取的信息
 *  @param aFailBlock    上传失败的block，包含错误信息
 */
- (void)uploadLogWithUrl:(NSString *)url
               paramters:(id)param
                 logType:(QILogType)type
            successBlock:(void(^)(NSData *data))aSuccessBlock
               failBlock:(void(^)(NSError *error))aFailBlock;
/**
 *  下载日志
 *
 *  @param url           url
 *  @param param         向服务器传的参数
 *  @param type          日志类型：crash、debug、error、info、release
 *  @param aSuccessBlock 上传成功的block，包含从服务器获取的信息
 *  @param aFailBlock    上传失败的block，包含错误信息
 */
- (void)downloadLogWithUrl:(NSString *)url
                 paramters:(id)param
                   logType:(QILogType)type
              successBlock:(void(^)(NSData *data))aSuccessBlock
                 failBlock:(void(^)(NSError *error))aFailBlock;
@end
