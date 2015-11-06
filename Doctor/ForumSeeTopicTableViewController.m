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

@interface ForumSeeTopicTableViewController (){
    NSMutableArray* tableViewDataArray;
    UIActivityIndicatorView* spinner;
}
@property (nonatomic, strong) NSMutableArray *messageArray;

@end

@implementation ForumSeeTopicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tableViewDataArray = [[NSMutableArray alloc] init];
    [self setupLoadingAnimation];
    [self setupDataSource];
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - Setups
- (void) setupDataSource{
    self.messageArray = [[NSMutableArray alloc] init];
    Envio* envio = [[Envio alloc] init];
    [envio fetchMessagesFromTopic:self.forumTopic.topicObjectId withCompletion:^(NSMutableArray* messagesArray){
        self.messageArray = messagesArray;
        tableViewDataArray = self.messageArray;
        [self.tableView reloadData];
        [spinner stopAnimating];
    }];
}

#pragma mark - UITableViewDelegates
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableViewDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void) setupLoadingAnimation{
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = self.view.center;
    spinner.tag = 12;
    [self.view addSubview:spinner];
    [spinner startAnimating];
}

@end

