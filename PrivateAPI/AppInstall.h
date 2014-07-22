//
//  appInstall.h
//  PrivateAPI
//
//  Created by chen on 14-7-22.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  ???只能安装一次，安装包不见了，猜测是放在项目的原因，未证明
 */
@interface AppInstall : NSObject

+ (int)IPAInstall:(NSString *)path;

@end
