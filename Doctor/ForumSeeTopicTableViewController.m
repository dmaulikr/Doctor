#import "Storyboards.h"
#import "ForumSeeTopicTableViewController.h"
#import "ForumMessageTableViewCell.h"
#import "ForumTopicMessage.h"
#import "Envio.h"
#import "AppDelegate.h"
#import "ForumMessageSendTableViewCell.h"
#import <UIViewController+KBDropdownController/UIViewController+KBDropdownController.h>
#import "ForumTopicDropdownViewController.h"
#import "SVProgressHUD.h"

@interface ForumSeeTopicTableViewController () <ForumTopicDropdownViewControllerDelegate, ForumMessageSendTableViewCellDelegate>{
    NSMutableArray* tableViewDataArray;
    Envio* envio;
    BOOL isPresentingDropdown;

}
@property (nonatomic, strong) NSMutableArray *messageArray;
@property (nonatomic, strong) ForumTopicDropdownViewController* vc;

@end

@implementation ForumSeeTopicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    envio = [[Envio alloc] init];
    tableViewDataArray = [[NSMutableArray alloc] init];
    [SVProgressHUD show];
    [self setupDataSource];
    [self loadGestureRecognizers];
    self.tableView.tableFooterView = [UIView new];
    if (![self.doctor.sawTopicsArray containsObject:self.forumTopic.topicObjectId]) {
        [self didTappedViewTopicDropdownButton];
    }
    [envio setTopicAsSaw:self.forumTopic.topicObjectId :self.doctor withCompletion:^void(BOOL* finished){}];
}

- (void) loadGestureRecognizers{
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self  action:@selector(didSwipe:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUp];
    
    UITapGestureRecognizer* tapToSee = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedViewTopicDropdownButton)];
    [self.dropdowButtonView addGestureRecognizer:tapToSee];
}

#pragma mark - Setups
- (void) setupDataSource{
    self.messageArray = [[NSMutableArray alloc] init];
    [envio fetchMessagesFromTopic:self.forumTopic.topicObjectId withCompletion:^(NSMutableArray* messagesArray){
        self.messageArray = messagesArray;
        tableViewDataArray = self.messageArray;
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == tableViewDataArray.count) {
        return 53;
    }
    else{
        return 100;
    }
}

- (void) didTappedSendButtom:(NSString *)text{
    ForumTopicMessage* topicMessage = [[ForumTopicMessage alloc] init];
    topicMessage.messageForumContent = text;
    topicMessage.messageForumCreatedAt = [self currentHour];
    topicMessage.messageForumOwner = self.doctor.doctorNameString;
    topicMessage.messageForumRelatedId = self.forumTopic.topicObjectId;
    
    [envio newMessage:topicMessage whenComplete:^void(BOOL finished){
        if (finished) {
            [SVProgressHUD show];
            [self setupDataSource];
        }
        else{
            [self.tableView reloadData];
        }
    }];
}

- (NSString *) currentHour{
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

- (void) didTappedViewTopicDropdownButton{
    self.vc = [[UIStoryboard storyboardWithName:kForumStoryboard bundle:nil] instantiateViewControllerWithIdentifier:kForumSeeTopicNavID];
    
    self.vc.delegate = self;
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    appDelegate.forumTopic = self.forumTopic;
    
    [self presentDropdownController:self.vc dropdownHeight:306 foldButton:nil springAnimation:NO];
    isPresentingDropdown = YES;
}

- (void) didTappedDropdownCloseButton{
    [self dismissDropdownController:self.vc dropdownHeight:300 foldButton:nil];
    isPresentingDropdown = NO;
}

- (void)didSwipe:(UISwipeGestureRecognizer*)swipe{
    if (swipe.direction == UISwipeGestureRecognizerDirectionUp) {
        if (isPresentingDropdown) {
            [self didTappedDropdownCloseButton];
        }
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionDown) {
        if (!isPresentingDropdown) {
            [self didTappedViewTopicDropdownButton];
        }
    }
}

@end

