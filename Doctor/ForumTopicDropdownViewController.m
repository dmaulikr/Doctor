//
//  ForumTopicDropdownViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 11/21/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "ForumTopicDropdownViewController.h"
#import "AppDelegate.h"

@interface ForumTopicDropdownViewController ()

@end

@implementation ForumTopicDropdownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateForumTopicData];
}

- (void) updateForumTopicData{
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.topicHourLabel.text = appDelegate.forumTopic.topicForumUpdatedAt;
    self.topicOwnerLabel.text = appDelegate.forumTopic.topicForumOwner;
    self.topicSubjectLabel.text = appDelegate.forumTopic.topicForumSubject;
    self.topicTextView.text = appDelegate.forumTopic.topicForumSinopse;
}

- (IBAction)dismissDropdownTapped:(id)sender{
    [_delegate didTappedDropdownCloseButton];
}

@end
