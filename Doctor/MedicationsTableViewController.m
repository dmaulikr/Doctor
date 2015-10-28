//
//  MedicationsTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/17/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "MedicationsTableViewController.h"
#import "MFSideMenu.h"
#import "Medication.h"
#import "Envio.h"

@interface MedicationsTableViewController () <UISearchBarDelegate> {
    NSMutableArray* tableViewDataArray;
    UIActivityIndicatorView* spinner;
    BOOL isSearching;
}

@property (strong, nonatomic) IBOutlet UISearchBar *medicationsSearchBar;
@property (strong, nonatomic) NSMutableArray* medicationsArray;
@property (strong, nonatomic) NSMutableArray* filteredMedicationsArray;

@end

@implementation MedicationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLoadingAnimation];
    [self setupDataSource];
}

-(IBAction)didTappedMenuBarButton:(UIBarButtonItem *)sender{
   	[self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableViewDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* MedicationsTableViewCellID = @"MedicationsCategoryTableViewCellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MedicationsTableViewCellID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MedicationsTableViewCellID];
    }
    
    Medication* medication = [[Medication alloc] init];
    medication = tableViewDataArray[indexPath.row];
    cell.textLabel.text = medication.medicationCategoryString;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"clickedAtMedicationCategorySegueID" sender:self];
}

#pragma mark - Setups
- (void)setupDataSource{
    self.medicationsArray = [[NSMutableArray alloc] init];
    tableViewDataArray = [[NSMutableArray alloc] init];
    self.filteredMedicationsArray = [[NSMutableArray alloc] init];
    Envio* newEnvio = [[Envio alloc]init];
    [newEnvio fetchAllMedications: ^void (Medication* medication){
            if (medication){
                [self.medicationsArray addObject:medication];
                tableViewDataArray = self.medicationsArray;
                [self.tableView reloadData];
                [spinner stopAnimating];
            }else{
                NSLog(@"Erro - setupMedicationsDatasource block");
            }
        }];
    tableViewDataArray = self.medicationsArray;
}


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
