//
//  ViewController.m
//  WebViewAuthDemo
//
//  Created by Filiz Kurban on 12/13/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import "ViewController.h"
@import WebKit;

NSString *kBaseURL = @"https://stackexchange.com/oauth/dialog";
NSString *kRedirectURI = @"https://stackexchange.com/oauth/login_success";
NSString *kClientID = @"8611";

@interface ViewController ()<WKNavigationDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    WKWebView *webView = [[WKWebView alloc]init];
    webView.frame = self.view.frame;
    [self.view addSubview:webView];

    NSURL *authURL = [self createStackOverflowAuthURL];

    webView.navigationDelegate = self;

    [webView loadRequest:[NSURLRequest requestWithURL:authURL]];


    


}

-(NSURL *)createStackOverflowAuthURL {
    // ? means enf of the URL. Next comers are parameters.
    // We could use URL components
    NSString *urlString = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@", kBaseURL, kClientID, kRedirectURI];
    NSLog(@"****%@", urlString);

    return [[NSURL alloc]initWithString:urlString];

}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {

    if ([navigationAction.request.URL.path isEqualToString:@"oauth/login_success"]) {
        NSLog(@"***IS Token in String %@", navigationAction.request.URL.absoluteString);
    }

    NSLog(@"Request URL: %@", navigationAction.request.URL);
    decisionHandler(WKNavigationActionPolicyAllow);
}


@end
