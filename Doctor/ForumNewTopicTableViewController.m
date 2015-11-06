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

@interface ForumNewTopicTableViewController (){
    UIActivityIndicatorView *spinner;
}

@end

@implementation ForumNewTopicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.doctor = [[Doctor alloc] init];
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.doctor = appDelegate.doctor;
    [self setupData];
}

#pragma mark - Setups
- (void) setupData{
    self.ownerLabel.text = self.doctor.doctorNameString;
}

#pragma mark - IBActions
-(IBAction)tappedCreateButton:(UIBarButtonItem *)createButton{
    [self setupLoadingAnimation];
    [self createNewTopic];
}

#pragma mark - Private Methods
- (void) createNewTopic{
    Envio* envio = [[Envio alloc] init];
    ForumTopic* topic = [[ForumTopic alloc] init];
    topic.topicForumOwner = self.ownerLabel.text;
    topic.topicForumSinopse = self.contentTextView.text;
    topic.topicForumSubject = [self.subjectTextField.text isEqualToString:@""] ? @"(Sem assunto)" : self.subjectTextField.text ;
    topic.topicForumUpdatedAt = @"06:00 AM";
    [envio newForumTopic:topic withCompletion:^void(BOOL FINISHED){
        if (FINISHED) {
            [spinner stopAnimating];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void) setupLoadingAnimation{
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = self.view.center;
    spinner.tag = 12;
    [self.view addSubview:spinner];
    [spinner startAnimating];
}

@end
