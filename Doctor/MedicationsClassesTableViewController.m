#import "MedicationsClassesTableViewController.h"
#import "Medication.h"
#import "Envio.h"
#import "MedicationSelectedViewController.h"
#import "SVProgressHUD.h"

@interface MedicationsClassesTableViewController () <UISearchBarDelegate> {
    NSMutableArray* tableViewDataArray;
    BOOL isSearching;
    NSString* toLook;
}

@property (strong, nonatomic) IBOutlet UISearchBar *medicationsSearchBar;
@property (strong, nonatomic) NSMutableArray* medicationsArray;
@property (strong, nonatomic) NSMutableArray* filteredMedicationsArray;

@end

@implementation MedicationsClassesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tableViewDataArray = [[NSMutableArray alloc] init];
    self.filteredMedicationsArray = [[NSMutableArray alloc] init];
    self.medicationsArray = [[NSMutableArray alloc] init];
    [SVProgressHUD showWithStatus:@"Carregando 80+ classes de fármacos"];
    [self setupDataSource];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [SVProgressHUD dismiss];
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableViewDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* MedicationsTableViewCellID = @"MedicationsClassesTableViewCellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MedicationsTableViewCellID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MedicationsTableViewCellID];
    }
    Medication* medication = [[Medication alloc] init];
    medication = tableViewDataArray[indexPath.row];
    cell.textLabel.text = medication.medicationCategoryString;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([medication isEqual:[tableViewDataArray lastObject]]) {
//        [self didReachedLastRow];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Medication* med = [[Medication alloc] init];
    med = tableViewDataArray[indexPath.row];
    toLook = med.medicationCategoryString;
    [self performSegueWithIdentifier:@"medChoosedSegueId" sender:self];
}

#pragma mark - Private methods
- (void)setupDataSource{
    Envio* newEnvio = [[Envio alloc]init];
    [newEnvio fetchAllMedications: ^void (NSMutableArray* medicationArray){
        if (medicationArray){
            self.medicationsArray = medicationArray;
            NSSortDescriptor *firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"medicationCategoryString" ascending:YES];
            NSArray *sortDescriptors = [NSArray arrayWithObjects:firstDescriptor, nil];
            NSArray *sortedArray = [self.medicationsArray sortedArrayUsingDescriptors:sortDescriptors];
            self.medicationsArray = sortedArray;
            tableViewDataArray = self.medicationsArray;
            [self.tableView reloadData];
            
            [SVProgressHUD dismiss];
        }else{
            NSLog(@"Erro - setupMedicationsDatasource block");
        }
    }];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"medChoosedSegueId"]) {
        MedicationSelectedViewController * medicationSelected = segue.destinationViewController;
        [medicationSelected setWordToSearchString:toLook];
    }
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

@end




