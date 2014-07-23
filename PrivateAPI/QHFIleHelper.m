//
//  QHFIleHelper.m
//  PrivateAPI
//
//  Created by chen on 14-7-23.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "QHFIleHelper.h"

@implementation QHFIleHelper

/*
 在<info.plist>里面配置
 Application supports iTunes file sharing = YES
 这样app就会出现“文稿”系统
 */
+ (int)moveFileToDocument:(NSString *)fileName type:(NSString *)fileType
{
    int nResult = 1;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath2 = [documentsDirectory stringByAppendingPathComponent:[fileName stringByAppendingPathExtension:fileType]];
    
    //创建文件夹
    //    [[NSFileManager defaultManager] createDirectoryAtPath:filePath2 withIntermediateDirectories:YES attributes:nil error:nil];
    NSFileManager* manager = [NSFileManager defaultManager];
    //判断是否有此文件
    if (![manager fileExistsAtPath:filePath2])
    {
        //没有就创建文件，这样才能操作
        //        [manager createFileAtPath:filePath2 contents:nil attributes:nil];
    }else
    {
        [manager removeItemAtPath:filePath2 error:nil];
    }
    
    //判断是否移动成功，这里文件不能是存在的
    NSError *thiserror = nil;
    if ([[NSFileManager defaultManager] copyItemAtPath:filePath toPath:filePath2 error:&thiserror] != YES)
    {
        NSLog(@"move fail...");
        NSLog(@"Unable to move file: %@", [thiserror localizedDescription]);
        nResult = 0;
    }
    
    return nResult;
}

+ (int)isEixtFile:(NSString *)path
{
    int nResult = 1;
    
    NSFileManager* manager = [NSFileManager defaultManager];
    //判断是否有此文件
    if (![manager fileExistsAtPath:path])
    {
        //没有就创建文件，这样才能操作
        //        [manager createFileAtPath:filePath2 contents:nil attributes:nil];
        nResult = 0;
    }
    
    return nResult;
}

@end
