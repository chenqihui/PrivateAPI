//
//  ViewController.m
//  IntallIPA
//
//  Created by chen on 14-7-22.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "ViewController.h"

#import "AppInstall.h"

#define MYURLSCHEME @"chenapp:"
#define MYCHENAPP @"ForInstallApp"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(10, 40, setS(100), setS(30))];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 6.0;
    btn.layer.borderWidth = 1.0;
    btn.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:MYURLSCHEME]])//urltypes:urlSchemes
    {
        [btn setTitle:@"打开ForInstallApp" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor greenColor]];
    }else
    {
        [btn setTitle:@"安装ForInstallApp" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor orangeColor]];
    }
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(installApp:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)installApp:(UIButton *)btn
{
    if ([[btn titleLabel].text isEqualToString:@"打开ForInstallApp"])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:MYURLSCHEME]];
        return;
    }
    [btn setUserInteractionEnabled:NO];
    [btn setTitle:@"安装中..." forState:UIControlStateNormal];
    __async_opt__, ^
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:MYCHENAPP ofType:@"ipa"];
//        NSLog(@"start install:%@", path);
        int i = -999;
        if (path != nil)
            i = [AppInstall IPAInstall:path];
//        NSLog(@"install result:%d", i);
        __async_main__, ^
        {
            switch (i)
            {
                case 0:
                {
                    [btn setTitle:@"打开ForInstallApp" forState:UIControlStateNormal];
                    [btn setBackgroundColor:[UIColor greenColor]];
                    break;
                }
                case -999:
                {
                    [btn setTitle:@"没有文件，点击重试" forState:UIControlStateNormal];
                    [btn setBackgroundColor:[UIColor redColor]];
                    break;
                }
                default:
                {
                    [btn setTitle:@"安装失败，点击重试" forState:UIControlStateNormal];
                    [btn setBackgroundColor:[UIColor redColor]];
                    break;
                }
            }
            [btn setUserInteractionEnabled:YES];
        });
    });
}

@end
