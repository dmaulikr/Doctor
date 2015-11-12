//
//  ForumSeeTopicTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/20/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "ForumSeeTopicTableViewController.h"
#import "ForumMessageTableViewCell.h"
#import "ForumTopicMessage.h"
#import "Envio.h"
#import "ForumMessageSendTableViewCell.h"

@interface ForumSeeTopicTableViewController () <ForumMessageSendTableViewCellDelegate>{
    NSMutableArray* tableViewDataArray;
    UIActivityIndicatorView* spinner;
    Envio* envio;

}
@property (nonatomic, strong) NSMutableArray *messageArray;

@end

@implementation ForumSeeTopicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    envio = [[Envio alloc] init];
    tableViewDataArray = [[NSMutableArray alloc] init];
    [self setupLoadingAnimation];
    [self setupDataSource];
    self.tableView.tableFooterView = [UIView new];
   
    [envio setTopicAsSaw:self.forumTopic.topicObjectId :self.doctor withCompletion:^void(BOOL* finished){}];
}

#pragma mark - Setups
- (void) setupDataSource{
    self.messageArray = [[NSMutableArray alloc] init];
    [envio fetchMessagesFromTopic:self.forumTopic.topicObjectId withCompletion:^(NSMutableArray* messagesArray){
        self.messageArray = messagesArray;
        tableViewDataArray = self.messageArray;
        [self.tableView reloadData];
        [spinner stopAnimating];
    }];
}

#pragma mark - UITableViewDelegates
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row == tableViewDataArray.count){
        NSString *ForumMessageSendCellID = @"ForumSendCellID";
        
        ForumMessageSendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ForumMessageSendCellID];
        if (cell==nil) {
            cell = [[ForumMessageSendTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ForumMessageSendCellID];
        }
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
        NSString* ForumMessageCellID = @"ForumMessageCellID";
        
        ForumMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ForumMessageCellID];
        if (cell==nil) {
            cell = [[ForumMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ForumMessageCellID];
        }
        
        ForumTopicMessage* message = [[ForumTopicMessage alloc] init];
        message = tableViewDataArray[indexPath.row];
        cell.messageContent.text = message.messageForumContent;
        cell.messageDate.text = message.messageForumCreatedAt;
        cell.messageOwner.text = message.messageForumOwner;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableViewDataArray.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == tableViewDataArray.count) {
        return 53;
    }
    else{
        return 100;
    }
}

- (void) setupLoadingAnimation{
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = self.view.center;
    spinner.tag = 12;
    [self.view addSubview:spinner];
    [spinner startAnimating];
}
- (void) didTappedSendButtom:(NSString *)text{
    ForumTopicMessage* topicMessage = [[ForumTopicMessage alloc] init];
    topicMessage.messageForumContent = text;
    topicMessage.messageForumCreatedAt = [self currentHour];
    topicMessage.messageForumOwner = self.doctor.doctorNameString;
    topicMessage.messageForumRelatedId = self.forumTopic.topicObjectId;
    
    [envio newMessage:topicMessage whenComplete:^void(BOOL finished){
        if (finished) {
            [self setupDataSource];
            [self setupLoadingAnimation];
        }
        else{
            [self.tableView reloadData];
        }
    }];
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

