//
//  QHFIleHelper.h
//  PrivateAPI
//
//  Created by chen on 14-7-23.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QHFIleHelper : NSObject

//移动文件
+ (int)moveFileToDocument:(NSString *)fileName type:(NSString *)fileType;

//判断文件是否存在
+ (int)isEixtFile:(NSString *)path;

@end
