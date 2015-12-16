//
//  MedicationSelectedViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 12/3/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "MedicationSelectedViewController.h"
#import <WebKit/WebKit.h>
#import "SVProgressHUD.h"

@interface MedicationSelectedViewController () <UIWebViewDelegate>

@property (nonatomic, strong) IBOutlet UIWebView* webView;

@end

@implementation MedicationSelectedViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    [self setupWebView];
}

- (void) setupWebView{
    NSString* toSearch = [NSString stringWithFormat:@"https://consultaremedios.com.br/busca?termo=%@", self.wordToSearchString];
    NSURL* url = [[NSURL alloc] initWithString:[toSearch stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD dismiss];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD show];
}

@end
