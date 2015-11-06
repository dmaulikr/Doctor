//
//  ForumTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/20/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "ForumTableViewController.h"
#import "MFSideMenu.h"
#import "ForumTableViewCell.h"
#import "Envio.h"
#import "SWTableViewCell.h"

@interface ForumTableViewController (){
    NSMutableArray* tableViewDataArray;
    UIActivityIndicatorView *spinner;
}
@property (nonatomic, strong) NSMutableArray* forumTopicsArray;

@end

@implementation ForumTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tableViewDataArray = [[NSMutableArray alloc] init];
    self.tableView.tableFooterView = [UIView new];
}

- (void) viewWillAppear:(BOOL)animated{
    [self setupDataSource];
    [self.tableView reloadData];
}

#pragma mark - IBActions
-(IBAction)didTappedMenuBarButton:(UIBarButtonItem *)sender{
   	[self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

-(IBAction)didTappedCreateTopicBarButton:(UIBarButtonItem *)sender{
    [self performSegueWithIdentifier:@"clickedToCreateTopicSegueId" sender:self];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"clickedToSeeTopicSegueId" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"clickedToSeeTopicSegueId"]) {
    }
    else if ([segue.identifier isEqualToString:@"clickedToCreateTopicSegueId"]){
    }
}

#pragma mark - Setups
- (void) setupDataSource{
    [self setupLoadingAnimation];
    Envio *envio = [[Envio alloc] init];
    self.forumTopicsArray = [[NSMutableArray alloc] init];
    
    [envio fetchAllForumTopics:^void(NSMutableArray* forumTopicsArray){
        if (forumTopicsArray){
            self.forumTopicsArray = forumTopicsArray;
            tableViewDataArray = self.forumTopicsArray;
            [spinner stopAnimating];
        }else{
            NSLog(@"Erro - setupForumTopics block");
        }
        [self.tableView reloadData];
    }];
}

#pragma mark - UITableViewDelegates
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* ForumCellID = @"ForumTableViewCellID";
    
    ForumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ForumCellID];
    if (cell==nil) {
        cell = [[ForumTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ForumCellID];
    }
    
    ForumTopic* forumTopic = [[ForumTopic alloc] init];
    forumTopic = tableViewDataArray[indexPath.row];
    
    cell.rightUtilityButtons = [self rightButtons];
    cell.delegate = self;
    
    cell.topicDate.text = forumTopic.topicForumUpdatedAt;
    cell.topicOwner.text = forumTopic.topicForumOwner;
    cell.topicSubject.text = forumTopic.topicForumSubject;
    cell.topicSinopse.text = forumTopic.topicForumSinopse;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSArray *)rightButtons {
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor: [UIColor colorWithRed:(247/255.0f) green:(146/255.0f) blue:(30/255.0f) alpha:1.0] icon:[UIImage imageNamed:@"icone-favoritarpaciente"]];
    return rightUtilityButtons;
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    NSLog(@"did tapped to fav");
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableViewDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (void) setupLoadingAnimation{
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = self.view.center;
    spinner.tag = 12;
    [self.view addSubview:spinner];
    [spinner startAnimating];
}


@end
