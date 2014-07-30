//
//  ViewTag.h
//  KGKit
//
//  Created by chen on 14-5-29.
//  Copyright (c) 2014年 14zynr. All rights reserved.
//

#ifndef KGKit_ViewTag_h
#define KGKit_ViewTag_h

/************************************ 宏定义 ************************************/
/* { 设备类型 } */
#define isIpad      ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define isIphone5   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640.f, 1136.f), [[UIScreen mainScreen] currentMode].size) : NO)
#define isIos7      ([[[UIDevice currentDevice] systemVersion] floatValue])
#define StatusbarSize ((isIos7 >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)?20.f:0.f)

#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]

/* { thread } */
#define __async_opt__  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define __async_main__ dispatch_async(dispatch_get_main_queue()

/* { 设备类型 } */
#define isIpad      ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

/* { 倍数 } */
#define _20bei(f) (f*2.f)
#define setS(b) isIpad?(b*2.f):b

#define __iphone_width__     (320.f)
/* { iPhone5 lenght+78.f } */
#define __iphone_height__    (isIphone5?568.f:480.f)

/* { webview hide shadow } */
#define HideShadow(_view) \
for (UIView *subView in [_view subviews]) \
{ \
if ([subView isKindOfClass:[UIScrollView class]]) \
{ \
for (UIView *shadowView in [subView subviews]) \
{ \
if ([shadowView isKindOfClass:[UIImageView class]]) \
{ \
shadowView.hidden = YES; \
} \
} \
} \
}

#endif
