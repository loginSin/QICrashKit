//
//  QIDeviceInfo.h
//  FileWriterDemo
//
//  Created by Xerses on 16/4/1.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  用来获取手机的信息和当前的时间
 */
@interface QIDeviceInfo : NSObject

/**
 *  获取当前时间,此方法copy自YYKit
 *
 *  @return 当前时间，格式为：2016-04-01_18:02:45
 */
NSString * deviceToGetCurrentTime();

/**
 *  获取设备信息,此方法copy自YYKit
 *  详情参考YYKit的UIDevice+YYAdd.h
 *  github地址：https://github.com/ibireme/YYKit
 *
 *  @return 设备信息，格式为：iPhone5s_iOS9.1
 */
NSString * deviceToGetDeviceInfo();
@end
