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


NSString *const kHugeMessage = @"Ex: Caso suspeito de dengue com sinais de alarme.  A infecção por dengue pode ser assintomática ou causar doença cujo espectro inclui desde formas oligossintomáticas até quadros graves com choque com ou sem hemorragia, podendo evoluir para o óbito. Normalmente, a primeira manifestação da dengue é a febre alta (39° a 40°C) de início abrupto que geralmente dura de 2 a 7 dias, acompanhada de dor de cabeça, dores no corpo e articulações, prostração, fraqueza, dor atrás dos olhos, erupção e prurido cutâneo. Perda de peso, náuseas e vômitos são comuns. Nessa fase febril inicial da doença pode ser difícil diferenciá-la de outras doenças febris, por isso uma prova do laço positiva aumenta a probabilidade de dengue.";

@interface ForumNewTopicTableViewController () <UITextViewDelegate> {
    UIActivityIndicatorView *spinner;
    int subjectLimit;
    int contextLimit;
}

@property (nonatomic, weak) IBOutlet UIBarButtonItem* createButton;

@end

@implementation ForumNewTopicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    subjectLimit = 65;
    contextLimit = 900;
    self.letterCounter.text = [NSString stringWithFormat:@"%i", subjectLimit];
    self.letterContextCounter.text = [NSString stringWithFormat:@"%i", contextLimit];
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
    [self textViewDidEndEditing:self.contentTextView];
    [self textViewDidEndEditing:self.subjectTextView];
    [self.createButton setEnabled:NO];
    [self createNewTopic];
}

#pragma mark - Private Methods
- (void) createNewTopic{
    Envio* envio = [[Envio alloc] init];
    ForumTopic* topic = [[ForumTopic alloc] init];
    topic.topicForumOwner = self.doctor.doctorNameString;
    topic.topicForumOwnerCRM = self.doctor.doctorCRMString;
    topic.topicForumSinopse = [self.contentTextView.text isEqualToString:kHugeMessage] ? @"(Corpo do tópico vazio)" : self.contentTextView.text;
    topic.topicForumSubject = [self.subjectTextView.text isEqualToString:@"Ex: Suspeita de um novo surto"] ? @"(Sem assunto)" : self.subjectTextView.text ;
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
        
        if (self.subjectTextView.text.length <= subjectLimit) {
            self.letterCounter.text = [NSString stringWithFormat:@"%i", 65-self.subjectTextView.text.length];
        }
        NSLog([NSString stringWithFormat:@"texto:%@", textView.text]);
    }
    if (textView.tag == 2) {
        self.contentImageView.image = [UIImage imageNamed:@"mensagem-laranja"];
        if (self.contentTextView.text.length <= contextLimit) {
            self.letterContextCounter.text = [NSString stringWithFormat:@"%i", 900-self.contentTextView.text.length];
        }
        NSLog([NSString stringWithFormat:@"texto:%@", textView.text]);
        
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSUInteger newLength = [textView.text length] + [text length] - range.length;
    BOOL aproval;
    switch (textView.tag) {
        case 1:
            if(range.length + range.location > textView.text.length)
            {
                return NO;
            }
            
            aproval = newLength <= 65;
            break;
            case 2:
            if(range.length + range.location > textView.text.length)
            {
                return NO;
            }
            
            NSUInteger newLength2 = [textView.text length] + [text length] - range.length;
            aproval = newLength2 <= 900;
            break;
            
        default:
            break;
    }
    return aproval;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (textView.tag == 1 && [textView.text isEqualToString:@"Ex: Suspeita de um novo surto"]) {
        textView.textColor = [UIColor blackColor];
        textView.text = @"";
    }
    if (textView.tag == 2 && [textView.text isEqualToString:kHugeMessage]) {
        textView.textColor = [UIColor blackColor];
        textView.text = @"";
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.tag == 1) {
        if ([textView.text isEqualToString:@""]) {
            textView.textColor = [UIColor grayColor];
            textView.text = @"Ex: Suspeita de um novo surto";
        }
    }
    if (textView.tag == 2) {
        if ([textView.text isEqualToString:@""]) {
            textView.textColor = [UIColor grayColor];
            textView.text = kHugeMessage;
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
