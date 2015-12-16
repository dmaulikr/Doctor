//
//  MedicationSelectedViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 12/3/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "MedicationSelectedViewController.h"
#import <WebKit/WebKit.h>

@interface MedicationSelectedViewController () <UIWebViewDelegate>

@property (nonatomic, strong) IBOutlet UIWebView* webView;

@end

@implementation MedicationSelectedViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    [self setupWebView];
}

- (void) setupWebView{
    NSURL* url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://consultaremedios.com.br/busca?termo=%@", self.wordToSearchString]];
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
}

@end
