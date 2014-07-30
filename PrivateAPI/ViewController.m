//
//  ViewController.m
//  IntallIPA
//
//  Created by chen on 14-7-22.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "ViewController.h"

#import "AppInstall.h"
#import "QHFIleHelper.h"

#import "QHWebViewController.h"

#define MYURLSCHEME @"chenapp://"
#define MYCHENAPPNAME @"ForInstallApp"
#define MYCHENAPPTYPE @"ipa"
#define MYCHENAPP @"ForInstallApp.ipa"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    int yy = 40;
    for (int i = 1 ; i <= 3; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(10, yy, setS(250), setS(30))];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = setS(6.0);
        btn.layer.borderWidth = 1.0;
        btn.layer.borderColor = [[UIColor whiteColor] CGColor];
        btn.tag = i;
        
        switch (i)
        {
            case 1:
            {
                [btn setTitle:@"移动ForInstallApp到document" forState:UIControlStateNormal];
                [btn setBackgroundColor:[UIColor orangeColor]];
                [btn addTarget:self action:@selector(moveFileToDocument:) forControlEvents:UIControlEventTouchUpInside];
                break;
            }
            case 2:
            {
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:MYURLSCHEME]])//urltypes:urlSchemes
                {
                    [btn setTitle:@"打开ForInstallApp" forState:UIControlStateNormal];
                    [btn setBackgroundColor:[UIColor greenColor]];
                }else
                {
                    [btn setTitle:@"安装ForInstallApp" forState:UIControlStateNormal];
                    [btn setBackgroundColor:[UIColor orangeColor]];
                }
                [btn addTarget:self action:@selector(installApp:) forControlEvents:UIControlEventTouchUpInside];
                break;
            }
            case 3:
            {
                [btn setTitle:@"进入php" forState:UIControlStateNormal];
                [btn setBackgroundColor:[UIColor greenColor]];
                [btn addTarget:self action:@selector(enterWeb:) forControlEvents:UIControlEventTouchUpInside];
                break;
            }
            default:
            {
                [btn setTitle:@"未知" forState:UIControlStateNormal];
                [btn setBackgroundColor:[UIColor redColor]];
                break;
            }
        }
        [self.view addSubview:btn];
        
        yy += btn.frame.size.height + 5;
    }
}

- (void)installApp:(UIButton *)btn
{
    if ([[btn titleLabel].text isEqualToString:@"打开ForInstallApp"])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[MYURLSCHEME stringByAppendingString:@"?token=29140723"]]];
        return;
    }
    [btn setUserInteractionEnabled:NO];
    [btn setTitle:@"安装中..." forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor orangeColor]];
    __async_opt__, ^
    {
//        NSString *path = [[NSBundle mainBundle] pathForResource:MYCHENAPP ofType:@"ipa"];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:MYCHENAPP];
        
//        NSLog(@"start install:%@", path);
        int i = -999;
        if (path != nil && [QHFIleHelper isEixtFile:path])
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

- (void)moveFileToDocument:(UIButton *)btn
{
    int i = [QHFIleHelper moveFileToDocument:MYCHENAPPNAME type:MYCHENAPPTYPE];
    if (i == 1)
    {
        [btn setTitle:@"移动成功" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor greenColor]];
    }else
    {
        [btn setTitle:@"移动失败" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor redColor]];
    }
}

- (void)enterWeb:(UIButton *)btn
{
    QHWebViewController *webVC = [[QHWebViewController alloc] init];
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:webVC];
    [self presentViewController:navC animated:YES completion:nil];
}

@end
