//
//  PatientsTableViewController.m
//  Doctor
//
//  Created by Breno Ramos on 10/15/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "PatientsTableViewController.h"
#import "PatientsTableViewCell.h"

@interface PatientsTableViewController () <SWTableViewCellDelegate, UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) NSMutableArray* patientsArray;
@property (strong, nonatomic) NSMutableArray* filteredPatientsArray;

@end

@implementation PatientsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSearch];
    [self setupPatientsDataSource];
}

#pragma mark - UITableViewDataSource and UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.filteredPatientsArray count];
    } else {
        return [self.patientsArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//        static NSString *cellIdentifier = @"patientCell";
//        
//        SWTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
//    
//        if (cell==nil) {
//        cell = [[SWTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//        }
//        // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
//        if (tableView == self.searchDisplayController.searchResultsTableView) {
//            cell = [self.filteredPatientsArray objectAtIndex:indexPath.row];
//        } else {
//            cell = [self.patientsArray objectAtIndex:indexPath.row];
//        }
//        //cell.customLabel.text = @"Some Text";
//        //cell.customImageView.image = [UIImage imageNamed:@"MyAwesomeTableCellImage"];
//        //[cell setCellHeight:cell.frame.size.height];
//        cell.textLabel.text = @"TESTE";
//    return cell;

    NSString* PatientsCellID = @"patientCell";
    
    PatientsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PatientsCellID forIndexPath:indexPath];
    if (cell==nil) {
        cell = [[PatientsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PatientsCellID];
    }
    
    cell.rightUtilityButtons = [self rightButtons];
    cell.delegate = self;
    return cell;
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                title:@"More"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"Delete"];
    
    return rightUtilityButtons;
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            NSLog(@"More button was pressed");
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

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.filteredPatientsArray removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    self.filteredPatientsArray = [NSMutableArray arrayWithArray:[self.patientsArray filteredArrayUsingPredicate:predicate]];
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

#pragma mark - Setups
- (void) setupPatientsDataSource{
    if (!_patientsArray) {
        _patientsArray = [[NSMutableArray alloc]initWithObjects: @"Maria", @"José", @"João", nil];
    }
}

- (void) setupSearch{
    self.filteredPatientsArray = [NSMutableArray arrayWithCapacity:[_patientsArray count]];
}

@end
