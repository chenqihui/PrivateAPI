//
//  JSWebViewController.m
//  PrivateAPI
//
//  Created by chen on 14-10-20.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "JSWebViewController.h"
#import <StoreKit/StoreKit.h>

@interface JSWebViewController () <UIWebViewDelegate, SKStoreProductViewControllerDelegate>
{
    UIActivityIndicatorView *bbsIndicatorView;
    UIWebView *bbsWebView;
}

@end

@implementation JSWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/%@", MyLocationPth, @"JSWeb.php"]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [bbsWebView loadRequest:request];
}

#pragma mark - action

- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)openItunesStore:(NSString *)url
{
    SKStoreProductViewController *storeProductViewController = [[SKStoreProductViewController alloc] init];
    [storeProductViewController setDelegate:self];
    [storeProductViewController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier :url} completionBlock:nil];
    [self presentViewController:storeProductViewController animated:YES completion:nil];
}

- (void)openApp:(NSString *)url
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[url stringByAppendingString:@"://?token=20140730"]]];
}

#pragma mark - UIWebViewDelegate

//js加载url触发的回调
- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requestString = [[request URL] absoluteString];
    NSArray *components = [requestString componentsSeparatedByString:@"::"];
    //识别回调参数触发相应的方法
    if ([components count] > 1 && [(NSString *)[components objectAtIndex:0] isEqualToString:@"install"])
    {
        NSURL *url = [NSURL URLWithString:[components objectAtIndex:1]];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [bbsWebView loadRequest:request];
        return NO;
    }else if ([components count] > 1 && [(NSString *)[components objectAtIndex:0] isEqualToString:@"itunesapp"])
    {
        [self openItunesStore:[components objectAtIndex:1]];
        return NO;
    }else if ([components count] > 1 && [(NSString *)[components objectAtIndex:0] isEqualToString:@"openapp"])
    {
        [self openApp:[components objectAtIndex:1]];
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
    [bbsIndicatorView stopAnimating];
}

#pragma mark - store

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
