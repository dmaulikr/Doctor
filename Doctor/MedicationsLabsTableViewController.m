#import "MedicationsLabsTableViewController.h"
#import "MedicationsLabsTableViewCell.h"
#import "MedicationSelectedViewController.h"
#import "Lab.h"
#import "Envio.h"
#import "SVProgressHUD.h"

@interface MedicationsLabsTableViewController () <UISearchBarDelegate> {
    NSMutableArray* tableViewDataArray;
    NSString* wordToSearch;
    BOOL isSearching;
}

@property (strong, nonatomic) IBOutlet UISearchBar *medicationsSearchBar;
@property (strong, nonatomic) NSMutableArray* labsArray;
@property (strong, nonatomic) NSMutableArray* filteredLabsArray;

@end

@implementation MedicationsLabsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tableViewDataArray = [[NSMutableArray alloc] init];
    self.filteredLabsArray = [[NSMutableArray alloc] init];
    self.labsArray = [[NSMutableArray alloc] init];
    [SVProgressHUD showWithStatus:@"Carregando 180+ laboratórios farmacêuticos"];
    [self setupDataSource];
    self.tableView.tableFooterView = [UIView new];
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
    NSString* MedicationsTableViewCellID = @"MedicationsLabsTableViewCellID";
    
    MedicationsLabsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MedicationsTableViewCellID];
    if (cell==nil) {
        cell = [[MedicationsLabsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MedicationsTableViewCellID];
    }
    
    Lab* lab = [[Lab alloc] init];
    lab = tableViewDataArray[indexPath.row];
    cell.labSiglaLabel.text = lab.labSigla;
    cell.labExtensoLabel.text = lab.labExtenso;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Lab* lab = [[Lab alloc] init];
    lab = tableViewDataArray[indexPath.row];
    wordToSearch = lab.labSigla;
    [self performSegueWithIdentifier:@"medChoosedSegueId" sender:self];
}

#pragma mark - Setups
- (void)setupDataSource{
    Envio* newEnvio = [[Envio alloc]init];
    [newEnvio fetchAllLabs: ^void (NSMutableArray* labsArray){
        if (labsArray){
            self.labsArray = labsArray;
            tableViewDataArray = self.labsArray;
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
        tableViewDataArray = self.labsArray;
        [self.tableView reloadData];
    }
    else{
        isSearching = true;
        [self.filteredLabsArray removeAllObjects];
        for (int i = 0; i < self.labsArray.count; i++) {
            Lab* labSearching  = [[Lab alloc] init];
            labSearching = self.labsArray[i];
            NSString* toCheck = [labSearching.labSigla lowercaseString];
            if ([toCheck containsString:[searchText lowercaseString]]) {
                [self.filteredLabsArray addObject:labSearching];
            }
        }
        tableViewDataArray = self.filteredLabsArray;
        [self.tableView reloadData];
    }
}

#pragma mark - UITouchDelegate Methods
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [[event allTouches] anyObject];
    if ([_medicationsSearchBar isFirstResponder] && [touch view] != _medicationsSearchBar) [_medicationsSearchBar resignFirstResponder];
}

@end
