//
//  QIDeviceInfo.m
//  FileWriterDemo
//
//  Created by Xerses on 16/4/1.
//  Copyright © 2016年 loginSin. All rights reserved.
//

#import "QIDeviceInfo.h"
#import <sys/sysctl.h>

@implementation QIDeviceInfo
//获取当前时间
NSString * deviceToGetCurrentTime(){
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd_HH:mm:ss"];
    NSString *time = [format stringFromDate:[NSDate date]];
    return time;
}

//获取设备信息，此方法copy自YYKit
NSString * deviceToGetDeviceInfo(){
    NSString *deviceInfo = p_machineModelName();
    double system = [[[UIDevice currentDevice] systemVersion] doubleValue];
    deviceInfo = [NSString stringWithFormat:@"%@_iOS%.1f",deviceInfo,system];
    return deviceInfo;
}
//获取设备信息，私有的子方法，此方法copy自YYKit
NSString *p_machineModelName() {
    static dispatch_once_t one;
    static NSString *name;
    dispatch_once(&one, ^{
        NSString *model = p_machineModel();
        if (!model) return;
        NSDictionary *dic = @{
                              @"Watch1,1" : @"AppleWatch",
                              @"Watch1,2" : @"AppleWatch",
                              
                              @"iPod1,1" : @"iPodtouch1",
                              @"iPod2,1" : @"iPodtouch2",
                              @"iPod3,1" : @"iPodtouch3",
                              @"iPod4,1" : @"iPodtouch4",
                              @"iPod5,1" : @"iPodtouch5",
                              @"iPod7,1" : @"iPodtouch6",
                              
                              @"iPhone1,1" : @"iPhone1G",
                              @"iPhone1,2" : @"iPhone3G",
                              @"iPhone2,1" : @"iPhone3GS",
                              @"iPhone3,1" : @"iPhone4(GSM)",
                              @"iPhone3,2" : @"iPhone4",
                              @"iPhone3,3" : @"iPhone4(CDMA)",
                              @"iPhone4,1" : @"iPhone4S",
                              @"iPhone5,1" : @"iPhone5",
                              @"iPhone5,2" : @"iPhone5",
                              @"iPhone5,3" : @"iPhone5c",
                              @"iPhone5,4" : @"iPhone5c",
                              @"iPhone6,1" : @"iPhone5s",
                              @"iPhone6,2" : @"iPhone5s",
                              @"iPhone7,1" : @"iPhone6Plus",
                              @"iPhone7,2" : @"iPhone6",
                              @"iPhone8,1" : @"iPhone6s",
                              @"iPhone8,2" : @"iPhone6sPlus",
                              @"iPhone8,4" : @"iPhoneSe",
                              
                              @"iPad1,1" : @"iPad1",
                              @"iPad2,1" : @"iPad2(WiFi)",
                              @"iPad2,2" : @"iPad2(GSM)",
                              @"iPad2,3" : @"iPad2(CDMA)",
                              @"iPad2,4" : @"iPad2",
                              @"iPad2,5" : @"iPadmini1",
                              @"iPad2,6" : @"iPadmini1",
                              @"iPad2,7" : @"iPadmini1",
                              @"iPad3,1" : @"iPad3(WiFi)",
                              @"iPad3,2" : @"iPad3(4G)",
                              @"iPad3,3" : @"iPad3(4G)",
                              @"iPad3,4" : @"iPad4",
                              @"iPad3,5" : @"iPad4",
                              @"iPad3,6" : @"iPad4",
                              @"iPad4,1" : @"iPadAir",
                              @"iPad4,2" : @"iPadAir",
                              @"iPad4,3" : @"iPadAir",
                              @"iPad4,4" : @"iPadmini2",
                              @"iPad4,5" : @"iPadmini2",
                              @"iPad4,6" : @"iPadmini2",
                              @"iPad4,7" : @"iPadmini3",
                              @"iPad4,8" : @"iPadmini3",
                              @"iPad4,9" : @"iPadmini3",
                              @"iPad5,1" : @"iPadmini4",
                              @"iPad5,2" : @"iPadmini4",
                              @"iPad5,3" : @"iPadAir2",
                              @"iPad5,4" : @"iPadAir2",
                              
                              @"i386" : @"Simulatorx86",
                              @"x86_64" : @"Simulatorx64",
                              };
        name = dic[model];
        if (!name) name = model;
    });
    return name;
}
//获取设备信息，私有的子方法，此方法copy自YYKit
NSString *p_machineModel() {
    static dispatch_once_t one;
    static NSString *model;
    dispatch_once(&one, ^{
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        model = [NSString stringWithUTF8String:machine];
        free(machine);
    });
    return model;
}
@end
