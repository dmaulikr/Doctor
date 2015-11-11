//
//  MedicationsLabsTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 11/11/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "MedicationsLabsTableViewController.h"
#import "Medication.h"
#import "Envio.h"

@interface MedicationsLabsTableViewController () <UISearchBarDelegate> {
NSMutableArray* tableViewDataArray;
UIActivityIndicatorView* spinner;
BOOL isSearching;
}

@property (strong, nonatomic) IBOutlet UISearchBar *medicationsSearchBar;
@property (strong, nonatomic) NSMutableArray* medicationsArray;
@property (strong, nonatomic) NSMutableArray* filteredMedicationsArray;

@end

@implementation MedicationsLabsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tableViewDataArray = [[NSMutableArray alloc] init];
    self.filteredMedicationsArray = [[NSMutableArray alloc] init];
    self.medicationsArray = [[NSMutableArray alloc] init];
    [self setupLoadingAnimation];
    [self setupDataSource];
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableViewDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* MedicationsTableViewCellID = @"MedicationsLabsTableViewCellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MedicationsTableViewCellID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MedicationsTableViewCellID];
    }
    
    Medication* medication = [[Medication alloc] init];
    medication = tableViewDataArray[indexPath.row];
    cell.textLabel.text = medication.medicationCategoryString;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self performSegueWithIdentifier:@"clickedAtMedicationCategorySegueID" sender:self];
//}

#pragma mark - Setups
- (void)setupDataSource{
    Envio* newEnvio = [[Envio alloc]init];
    [newEnvio fetchAllMedications: ^void (NSMutableArray* medicationArray){
        if (medicationArray){
            self.medicationsArray = medicationArray;
            tableViewDataArray = self.medicationsArray;
            [self.tableView reloadData];
            [spinner stopAnimating];
        }else{
            NSLog(@"Erro - setupMedicationsDatasource block");
        }
    }];
}

//- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if ([segue.identifier isEqualToString:@"clickedAtMedicationCategorySegueID"]) {
//        MedicationSelectedTableViewController* medicationSelected = segue.destinationViewController;
//        [medicationSelected setMedication:medicationClicked];
//    }
//}

- (void) setupLoadingAnimation{
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = self.view.center;
    spinner.tag = 12;
    [self.view addSubview:spinner];
    [spinner startAnimating];
}

#pragma mark - UISearchBarDelegate Methods
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if ([searchText isEqualToString:@""]) {
        tableViewDataArray = self.medicationsArray;
        [self.tableView reloadData];
    }
    else{
        isSearching = true;
        [self.filteredMedicationsArray removeAllObjects];
        for (int i = 0; i < self.medicationsArray.count; i++) {
            Medication* medicationsSearching  = [[Medication alloc] init];
            medicationsSearching = self.medicationsArray[i];
            NSString* toCheck = [medicationsSearching.medicationCategoryString lowercaseString];
            if ([toCheck containsString:[searchText lowercaseString]]) {
                [self.filteredMedicationsArray addObject:medicationsSearching];
            }
        }
        tableViewDataArray = self.filteredMedicationsArray;
        [self.tableView reloadData];
    }
}

#pragma mark - UITouchDelegate Methods
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [[event allTouches] anyObject];
    if ([_medicationsSearchBar isFirstResponder] && [touch view] != _medicationsSearchBar) [_medicationsSearchBar resignFirstResponder];
}

@end
