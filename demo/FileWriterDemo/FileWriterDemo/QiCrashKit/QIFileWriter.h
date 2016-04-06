//
//  QIFileWriter.h
//  FileWriterDemo
//
//  Created by Xerses on 16/4/1.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import <Foundation/Foundation.h>

//下列的文件名是预设好的，可以直接使用

//crash信息的文件名，路径为Documents/crash.txt
static NSString *crashFilename = @"crash.txt";

//debug信息的文件名，路径为Documents/debug.txt
static NSString *debugFilename = @"debug.txt";

//error信息的文件名，路径为Documents/error.txt
static NSString *errorFilename = @"error.txt";

//release信息的文件名，路径为Documents/release.txt
static NSString *releaseFilename = @"release.txt";

//info信息的文件名，路径为Documents/info.txt
static NSString *infoFilename = @"info.txt";



typedef enum : NSUInteger {
    QILogType_Crash,
    QILogType_Debug,
    QILogType_Error,
    QILogType_Release,
    QILogType_Info,
} QILogType;


//一般用户不需要直接使用，该类是对其他的Handle进行支持

//*************支持线程安全***************

/**
 *  文件写入数据的管理类，默认写在沙盒的Documents/log.txt中
 *  @discussion 如果需要使用带filename的方法，之后的请都使用带filename的方法
 *              因为带参数filename的方法与不带的存储数据文件的路径不一样
 */
//目前支持NSString，NSDictionary，NSData的写入
//建议同一个文件只保存一种类型的数据，比如说只保存string或者只保存dictionary，否则当拿到数据来解析的时候就会很麻烦
@interface QIFileWriter : NSObject

/**
 *  调用此方法，之后的数据就会覆盖，数据默认保存在沙盒的Documents/log.txt中
 */
+ (void)coverPreviousData;

/**
 *  往文件中追加数据，调用此方法数据默认保存在沙盒的Documents/log.txt中
 *
 *  @param obj  数据，目前支持NSString和NSDictionary、NSData
 *  @param type 传入的数据类型
 *
 *  @return 追加是否成功
 */
+ (BOOL)appendToFileWithContent:(id)obj;

/**
 *  从文件中获取数据，调用此方法从沙盒的Documents/log.txt中读取数据
 *
 *  @param type 文件的数据类型
 *
 *  @return 数据所在的数组
 */
+ (NSArray *)data;

/**
 *  获取默认文件的路径
 *
 *  @return 文件路径
 */
+ (NSString *)filePath;

/**
 *  删除默认文件的所有数据
 *
 *  @return 是否删除成功
 */
+ (BOOL)deleteData;

@end

/**
 *  文件写入数据的管理类的类扩展，扩展用户自定义文件名，写在Documents/filename中
 */
@interface QIFileWriter (filename)

/**
 *  覆盖之前的数据
 *  如果调用，该方法需要在所有方法之前调用！！！！
 */
+ (void)coverPreviousDataWithLogType:(QILogType)type ;

/**
 *  往文件中追加数据，存到Documents下指定的文件下
 *
 *  @param obj      数据
 *  @param filename 用户指定的文件名，eg:debug.txt
 *
 *  @return 是否写入数据成功
 */
+ (BOOL)appendToFileWithContent:(id)obj withFilename:(NSString *)filename;

/**
 *  从特定文件中获取数据
 *
 *  @param filepath 文件名,eg:debug.txt
 *
 *  @return 数据所在的数组
 */
+ (NSArray *)dataWithFilename:(NSString *)filename;

/**
 *  获取特定文件的路径
 *
 *  @param filename 特定的文件名
 *
 *  @return 特定的文件路径
 */
+ (NSString *)filePathWithFilename:(NSString *)filename;

/**
 *  删除特定文件的所有数据
 *
 *  @param filename 文件名
 *
 *  @return 是否删除成功
 */
+ (BOOL)deleteDataWithFilename:(NSString *)filename;
@end
