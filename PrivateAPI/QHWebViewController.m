//
//  QHWebViewController.m
//  PrivateAPI
//
//  Created by chen on 14-7-30.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "QHWebViewController.h"

@interface QHWebViewController ()<UIWebViewDelegate>
{
    UIActivityIndicatorView *bbsIndicatorView;
    UIWebView *bbsWebView;
}

@end

@implementation QHWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor grayColor]];
    
    UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    bbsWebView=[[UIWebView alloc] initWithFrame:CGRectMake(0.f, 0.f, __iphone_width__, __iphone_height__)];
    bbsWebView.backgroundColor = [UIColor clearColor];
    bbsWebView.delegate = self;
    [self.view addSubview:bbsWebView];
    
    HideShadow(bbsWebView);
    // 菊花
    if ( nil == bbsIndicatorView )
    {
        bbsIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:isIpad?CGRectMake(0, 0, _20bei(48), _20bei(48)):CGRectMake(0, 0, 48, 48)];
        bbsIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        bbsIndicatorView.backgroundColor = [UIColor clearColor];
        bbsIndicatorView.layer.cornerRadius = 6;
        bbsIndicatorView.layer.masksToBounds = YES;
        [bbsIndicatorView setCenter:bbsWebView.center];
        [bbsIndicatorView startAnimating];
        [self.view addSubview:bbsIndicatorView];
    }
    
    [self setup];
}

- (void)setup
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://chenhello.sinaapp.com/loginReturn.php"]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [bbsWebView loadRequest:request];
}

/* { GET·方式 } */
- (NSString *)noneheader_get:(NSString *)_url
{
    NSURL *url = [NSURL URLWithString:_url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    return [[NSString alloc] initWithData:received encoding:NSUTF8StringEncoding];
}

#pragma mark - action

- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)openApp
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"chenapp://" stringByAppendingString:@"?token=20140730"]]];
}

#pragma mark - UIWebViewDelegate

//js加载url触发的回调
- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requestString = [[request URL] absoluteString];
    NSArray *components = [requestString componentsSeparatedByString:@":"];
    //识别回调参数触发相应的方法
    if ([components count] > 1 && [(NSString *)[components objectAtIndex:0] isEqualToString:@"testapp"])
    {
        if([(NSString *)[components objectAtIndex:1] isEqualToString:@"alert"])
        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert from Cocoa Touch" message:[components objectAtIndex:2] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//                                  [alert show];
//            NSLog(@"%@", requestString);
//            [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"function getCurrentUser(){'%@'}", @"var t1=3;t1 = t1+2;alert(t1);"]];
            
            //此为调用js里面的函数的方法
            [webView stringByEvaluatingJavaScriptFromString:@"getCurrentUser('5201314')"];
            
            //此为js添加函数的方法
            [webView stringByEvaluatingJavaScriptFromString:@"var script = document.createElement('script');"
             "script.type = 'text/javascript';"
             "script.text = \"function myFunction() { "
             "alert('hello myFunction');"
             "}\";"
             "document.getElementsByTagName('head')[0].appendChild(script);"];
            
//            [webView stringByEvaluatingJavaScriptFromString:@"myFunction();"];
        }
        return NO;
    }else if ([components count] > 1 && [(NSString *)[components objectAtIndex:0] isEqualToString:@"chenapp"])
    {
        [self openApp];
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [bbsIndicatorView startAnimating] ;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
    [bbsIndicatorView stopAnimating];
//    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"getCurrentUser(){'%@'}", @"var t1=3;t1 = t1+2;alert(t1);"]];
}

@end
