//
//  appInstall.h
//  PrivateAPI
//
//  Created by chen on 14-7-22.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  ???只能安装一次，安装包不见了，
 
 20140722:猜测是放在项目的原因，未证明？
 
 20140723:实验证明，它确确实实会删除安装包，如何解决？
 
 20140723:解决方案：copyItemAtPath，用copy的安装包进行安装，保护原始安装包
 */
@interface AppInstall : NSObject

+ (int)IPAInstall:(NSString *)path;

@end
