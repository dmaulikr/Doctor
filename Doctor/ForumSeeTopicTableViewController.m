//
//  ForumSeeTopicTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/20/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "ForumSeeTopicTableViewController.h"
#import "ForumMessageTableViewCell.h"

@interface ForumSeeTopicTableViewController (){
    NSMutableArray* tableViewDataArray;

}

@end

@implementation ForumSeeTopicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tableViewDataArray = [[NSMutableArray alloc] init];
    [self setupDataSource];

}
//
//#pragma mark - IBActions
//-(IBAction)didTappedMenuBarButton:(UIBarButtonItem *)sender{
//   	[self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
//}
//
//-(IBAction)didTappedCreateTopicBarButton:(UIBarButtonItem *)sender{
//    [self performSegueWithIdentifier:@"clickedToCreateTopicSegueId" sender:self];
//}


#pragma mark - Setups
- (void) setupDataSource{
    //query fetch all forum topics from parse
    NSMutableArray* arrayOriundoDoParse = [[NSMutableArray alloc] init];
    tableViewDataArray = arrayOriundoDoParse;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegates
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* ForumMessageCellID = @"ForumMessageCellID";
    
    ForumMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ForumMessageCellID];
    if (cell==nil) {
        cell = [[ForumMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ForumMessageCellID];
    }
    //    cell.rightUtilityButtons = [self rightButtons];
    //    cell.delegate = self;
    //
    //    Patient* patient = [[Patient alloc] init];
    //    patient = tableViewDataArray[indexPath.row];
    //
    //    cell.patientNameLabel.text = patient.patientNameString;
    //    cell.patientAgeLabel.text = patient.patientAgeString;
    //    cell.patientGenderLabel.text = patient.patientGenderString;
    //    cell.patientInitialsLabel.text = [patient.patientNameString substringToIndex:1];
    //    //cell.patientCameSinceLabel.text = tableViewDataArray[];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


@end

