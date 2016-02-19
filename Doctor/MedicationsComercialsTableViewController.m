#import "MedicationsComercialsTableViewController.h"
#import "MedicationSelectedViewController.h"
#import "Medication.h"
#import "Envio.h"
#import "SVProgressHUD.h"

@interface MedicationsComercialsTableViewController () <UISearchBarDelegate> {
    NSMutableArray* tableViewDataArray;
    NSString* wordToSearch;
    BOOL isSearching;
}

@property (strong, nonatomic) IBOutlet UISearchBar *medicationsSearchBar;
@property (strong, nonatomic) NSMutableArray* medicationsArray;
@property (strong, nonatomic) NSMutableArray* filteredMedicationsArray;

@end

@implementation MedicationsComercialsTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    tableViewDataArray = [[NSMutableArray alloc] init];
    self.filteredMedicationsArray = [[NSMutableArray alloc] init];
    self.medicationsArray = [[NSMutableArray alloc] init];
    [SVProgressHUD showWithStatus:@"Carregando 1000+ nomes comerciais"];
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
    NSString* MedicationsTableViewCellID = @"MedicationsComercialsTableViewCellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MedicationsTableViewCellID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MedicationsTableViewCellID];
    }
    
    cell.textLabel.text = tableViewDataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    wordToSearch = tableViewDataArray[indexPath.row];
    [self performSegueWithIdentifier:@"medChoosedSegueId" sender:self];
}

#pragma mark - Setups
- (void)setupDataSource{
    Envio* newEnvio = [[Envio alloc]init];
    [newEnvio fetchAllComercialNames: ^void (NSMutableArray* medicationArray){
        if (medicationArray){
            self.medicationsArray = medicationArray;
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
        [medicationSelected setWordToSearchString:wordToSearch];
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
            NSString* medicationsSearching = self.medicationsArray[i];
            NSString* toCheck = [medicationsSearching lowercaseString];
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
