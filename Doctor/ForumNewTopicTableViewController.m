//
//  ForumNewTopicTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/20/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "ForumNewTopicTableViewController.h"
#import "AppDelegate.h"
#import "Doctor.h"
#import "Envio.h"

@interface ForumNewTopicTableViewController ()

@end

@implementation ForumNewTopicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
}

#pragma mark - Setups
- (void) setupData{
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    Doctor *doctor = [[Doctor alloc] init];
    doctor = appDelegate.doctor;
    self.ownerLabel.text = doctor.doctorNameString;
}

#pragma mark - IBActions
-(IBAction)tappedCreateButton:(UIBarButtonItem *)createButton{
    [self createNewTopic];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private Methods
- (void) createNewTopic{
    Envio* envio = [[Envio alloc] init];
    ForumTopic* topic = [[ForumTopic alloc] init];
    topic.topicForumOwner = self.ownerLabel.text;
    topic.topicForumSinopse = self.contentTextView.text;
    topic.topicForumSubject = [self.subjectTextField.text isEqualToString:@""] ? @"(Sem assunto)" : self.subjectTextField.text ;
    topic.topicForumUpdatedAt = @"06:00 AM";
    [envio newForumTopic:topic];
}

@end
