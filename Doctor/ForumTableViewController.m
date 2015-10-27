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

@interface ForumTableViewController (){
    NSMutableArray* tableViewDataArray;
}

@end

@implementation ForumTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tableViewDataArray = [[NSMutableArray alloc] init];
    [self setupDataSource];
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
    //query fetch all forum topics from parse
    NSMutableArray* arrayOriundoDoParse = [[NSMutableArray alloc] init];
    tableViewDataArray = arrayOriundoDoParse;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegates
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* ForumCellID = @"ForumTableViewCellID";
    
    ForumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ForumCellID];
    if (cell==nil) {
        cell = [[ForumTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ForumCellID];
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
