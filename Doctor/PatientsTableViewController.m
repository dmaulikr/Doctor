//
//  PatientsTableViewController.m
//  Doctor
//
//  Created by Breno Ramos on 10/15/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "PatientsTableViewController.h"
#import "PatientsTableViewCell.h"
#import "MFSideMenu.h"
#import "Storyboards.h"

@interface PatientsTableViewController () <SWTableViewCellDelegate, UISearchBarDelegate, UISearchDisplayDelegate>{
    NSMutableArray* tableViewDataArray;
    BOOL isSearching;
}
@property (strong, nonatomic) NSMutableArray* patientsArray;
@property (strong, nonatomic) NSMutableArray* filteredPatientsArray;

@end

@implementation PatientsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSearch];
    [self setupPatientsDataSource];
    self.tableView.tableFooterView = [UIView new];
    isSearching = false;
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableViewDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* PatientsCellID = @"patientCell";
    
    PatientsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PatientsCellID];
    if (cell==nil) {
        cell = [[PatientsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PatientsCellID];
    }
    cell.rightUtilityButtons = [self rightButtons];
    cell.delegate = self;
    cell.textLabel.text = tableViewDataArray[indexPath.row];
    return cell;
}

- (NSArray *)rightButtons {
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor: [UIColor colorWithRed:(128/255.0f) green:(128/255.0f) blue:(128/255.0f) alpha:1.0] title:@"Del"];
    [rightUtilityButtons sw_addUtilityButtonWithColor: [UIColor colorWithRed:(128/255.0f) green:(128/255.0f) blue:(128/255.0f) alpha:1.0f] title:@"Fav"];
    
    return rightUtilityButtons;
}

#pragma mark - SWTableViewCell Delegate
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
            break;
        case 1:
        {
            NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
            
            [_patientsArray removeObjectAtIndex:cellIndexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        }
        default:
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"clickedPatientSegueId" sender:self];
}

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    if ([searchText isEqualToString:@""]) {
        tableViewDataArray = self.patientsArray;
    }
    else{
        isSearching = true;
        [self.filteredPatientsArray removeAllObjects];
        for (int i = 0; i < self.patientsArray.count; i++) {
            NSString* toCheck = [self.patientsArray[i] lowercaseString];
            if ([toCheck containsString:[searchText lowercaseString]]) {
                [self.filteredPatientsArray addObject:self.patientsArray[i]];
            }
        }
        tableViewDataArray = self.filteredPatientsArray;
    }
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString scope:
    [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
    [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    return YES;
}

#pragma mark - Setups
- (void) setupPatientsDataSource{
    self.patientsArray = [[NSMutableArray alloc] initWithObjects: @"Maria", @"José", @"João", nil];
    tableViewDataArray = [[NSMutableArray alloc] initWithArray:self.patientsArray];
}

- (void) setupSearch{ self.filteredPatientsArray = [NSMutableArray arrayWithCapacity:[_patientsArray count]]; }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath { return 100; }

#pragma mark - IBActions
- (IBAction)menuButtonTapped:(id)sender { [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}]; }

-(IBAction)addPatientButtonTapped:(id)sender{
    UIViewController *vc = [[UIStoryboard storyboardWithName:kPatientsStoryboard bundle:nil] instantiateViewControllerWithIdentifier:kPatientsAddModalID];
    [self.menuContainerViewController.centerViewController presentViewController:vc animated:YES completion:^{
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{}];
    }];
}

@end
