//
//  FeedTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/16/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "FeedTableViewController.h"
#import "MFSideMenu.h"
#import "AFDropdownNotification.h"

@interface FeedTableViewController (){
    AFDropdownNotification* notification;
    BOOL openedNotification;
}

@end

@implementation FeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNotification];
    self.menuContainerViewController.panMode = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [notification presentInView:self.view withGravityAnimation:NO];
        openedNotification = true;

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (openedNotification) {
                openedNotification = false;
                [notification dismissWithGravityAnimation:NO];
            }
        });
    });
}

#pragma mark - IBActions
-(IBAction)didTappedMenuBarButton:(UIBarButtonItem *)sender{
   	[self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

#pragma mark - Private Methods
-(void) setupNotification{
    notification = [[AFDropdownNotification alloc] init];
    notification.notificationDelegate = self;
    notification.titleText = @"Olá, ";
    notification.subtitleText = @"Seu tópico sobre cardiologia foi atualizado, quer dar uma olhada?";
    notification.dismissOnTap = YES;
    [notification listenEventsWithBlock:^(AFDropdownNotificationEvent event) {
        switch (event) {
            case AFDropdownNotificationEventTopButton:
                [notification dismissWithGravityAnimation:NO];
                openedNotification = false;
                break;
                
            case AFDropdownNotificationEventBottomButton:
                [notification dismissWithGravityAnimation:NO];
                 openedNotification = false;
                break;
                
            case AFDropdownNotificationEventTap:
//                self.menuContainerViewController.centerViewController = [[UIStoryboard storyboardWithName:@"Forum" bundle:nil] instantiateViewControllerWithIdentifier:@"ForumNavigationControllerID"];
                NSLog(@"tapped");
                
                break;
            default:
                break;
        }
    }];
}

@end
