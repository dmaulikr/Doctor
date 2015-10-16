//
//  MainViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/15/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "MainViewController.h"
#import "Storyboards.h"

@implementation MainViewController

-(void) viewDidLoad{
    [super viewDidLoad];
    [self setupCenterContainer];
    [self setupMenu];
}

- (void)setupCenterContainer{
    self.centerViewController = [[UIStoryboard storyboardWithName:kOutsideStoryboard bundle:nil] instantiateViewControllerWithIdentifier:kOutsideNavID];
}

- (void)setupMenu{
    self.leftMenuViewController = [[UIStoryboard storyboardWithName:kMainStoryboard bundle:nil] instantiateViewControllerWithIdentifier:kMainMenuID];
    self.leftMenuWidth = 280;
}

@end
