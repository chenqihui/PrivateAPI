//
//  appInstall.m
//  PrivateAPI
//
//  Created by chen on 14-7-22.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "AppInstall.h"

#import "dlfcn.h"

@implementation AppInstall

typedef int (*MobileInstallationInstall)(NSString *path, NSDictionary *dict, void *na, NSString *path2_equal_path_maybe_no_use);

/**
 *  安装ipa，针对越狱的iOS
 *  需要配置环境文件plist，把下面xml直接加入到plist上就可以
 
 <?xml version="1.0" encoding="UTF-8"?>
 <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
 <plist version="1.0">
 <dict>
 <key>com.apple.private.mobileinstall.allowedSPI</key>
 <array>
 <string>Install</string>
 <string>Browse</string>
 <string>Uninstall</string>
 <string>Archive</string>
 <string>RemoveArchive</string>
 </array>
 </dict>
 </plist>
 
 *
 *  @param path 需要安装的ipa路径
 *
 *  @return -1为安装失败，0为安装成功
 */
+ (int)IPAInstall:(NSString *)path
{
    //私有库
    void *lib = dlopen("/System/Library/PrivateFrameworks/MobileInstallation.framework/MobileInstallation", RTLD_LAZY);
    if (lib)
    {
        MobileInstallationInstall pMobileInstallationInstall = (MobileInstallationInstall)dlsym(lib, "MobileInstallationInstall");
        if (pMobileInstallationInstall)
        {
            //复制一个，解决原始安装包不会被删除
            NSString *name = [@"Install_" stringByAppendingString:path.lastPathComponent];
            NSString* tempPath = [NSTemporaryDirectory() stringByAppendingPathComponent:name];
            if (![[NSFileManager defaultManager] copyItemAtPath:path toPath:tempPath error:nil])
                return -1;
            
            int ret = pMobileInstallationInstall(tempPath, [NSDictionary dictionaryWithObject:@"User" forKey:@"ApplicationType"], nil, path);
            dlclose(lib);
            
            return ret;
        }
    }
    return -1;
}

@end
