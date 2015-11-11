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

@interface ForumNewTopicTableViewController () <UITextViewDelegate> {
    UIActivityIndicatorView *spinner;
}

@end

@implementation ForumNewTopicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.subjectTextView.delegate = self;
    self.contentTextView.delegate = self;
    self.subjectTextView.tag = 1;
    self.contentTextView.tag = 2;
    self.doctor = [[Doctor alloc] init];
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.doctor = appDelegate.doctor;
    self.ownerImageView.image = [UIImage imageNamed:@"registrar-nome"];
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
    topic.topicForumOwner = self.doctor.doctorNameString;
    topic.topicForumOwnerCRM = self.doctor.doctorCRMString;
    topic.topicForumSinopse = self.contentTextView.text;
    topic.topicForumSubject = [self.subjectTextView.text isEqualToString:@""] ? @"(Sem assunto)" : self.subjectTextView.text ;
    topic.topicForumUpdatedAt = [self currentHour];
    [envio newForumTopic:topic withCompletion:^void(BOOL FINISHED){
        if (FINISHED) {
            [spinner stopAnimating];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

#pragma mark - UITextView Delegates
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.tag == 1) {
        self.subjectImageView.image = [UIImage imageNamed:@"assunto-laranja"];
    }
    if (textView.tag == 2) {
        self.contentImageView.image = [UIImage imageNamed:@"mensagem-laranja"];
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (textView.tag == 1 && [textView.text isEqualToString:@"(Sem Assunto)"]) {
        textView.text = @"";
    }
    if (textView.tag == 2 && [textView.text isEqualToString:@""]) {
        textView.text = @"";
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.tag == 1) {
        if ([textView.text isEqualToString:@""]) {
            textView.text = @"(Sem assunto)";
        }
    }
}

- (void) setupLoadingAnimation{
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = self.view.center;
    spinner.tag = 12;
    [self.view addSubview:spinner];
    [spinner startAnimating];
}

- (NSString *)currentHour
{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    
    NSString* amPm;
    NSString* hourInString;
    NSString* minuteInString;
    
    if (hour < 12) {
        amPm = @"AM";
    }
    else{
        hour = hour - 12;
        amPm = @"PM";
    }
    
    if (hour < 10) {
        hourInString = [NSString stringWithFormat:@"0%li", hour];
    }
    else{
        hourInString = [NSString stringWithFormat:@"%li", hour];
    }
    
    if (minute < 10) {
        minuteInString = [NSString stringWithFormat:@"0%li", minute];
    }
    else{
        minuteInString = [NSString stringWithFormat:@"%li", minute];
    }
    
    
    NSString* hourCompleted = [NSString stringWithFormat:@"%@:%@ %@", hourInString, minuteInString, amPm];
    return hourCompleted;
}

@end
