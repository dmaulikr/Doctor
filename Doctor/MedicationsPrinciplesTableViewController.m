#import "MedicationsPrinciplesTableViewController.h"
#import "MedicationSelectedViewController.h"
#import "Envio.h"
#import "PA.h"
#import "SVProgressHUD.h"

@interface MedicationsPrinciplesTableViewController () <UISearchBarDelegate> {
NSMutableArray* tableViewDataArray;
UIActivityIndicatorView* spinner;
    NSString* wordToSearch;
BOOL isSearching;
}

@property (strong, nonatomic) IBOutlet UISearchBar *medicationsSearchBar;
@property (strong, nonatomic) NSMutableArray* pasArray;
@property (strong, nonatomic) NSMutableArray* filteredPasArray;

@end

@implementation MedicationsPrinciplesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tableViewDataArray = [[NSMutableArray alloc] init];
    self.filteredPasArray = [[NSMutableArray alloc] init];
    self.pasArray = [[NSMutableArray alloc] init];
    [self setupLoadingAnimation];
    [self setupDataSource];
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableViewDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* MedicationsPATableViewCellID = @"MedicationsPrinciplesTableViewCellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MedicationsPATableViewCellID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MedicationsPATableViewCellID];
    }
    PA* pa = [[PA alloc] init];
    pa = tableViewDataArray[indexPath.row];
    cell.textLabel.text = pa.paString;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PA* pa = [[PA alloc] init];
    pa = tableViewDataArray[indexPath.row];
    wordToSearch = pa.paString;
    [self performSegueWithIdentifier:@"medChoosedSegueId" sender:self];
}

#pragma mark - Setups
- (void)setupDataSource{
    Envio* newEnvio = [[Envio alloc]init];
    [newEnvio fetchAllPas: ^void (NSMutableArray* pasArray){
        if (pasArray){
            self.pasArray = pasArray;
            tableViewDataArray = self.pasArray;
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

- (void) setupLoadingAnimation{
//    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    spinner.center = self.view.center;
//    spinner.tag = 12;
//    [self.view addSubview:spinner];
//    [spinner startAnimating];
   [SVProgressHUD show];
}

#pragma mark - UISearchBarDelegate Methods
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if ([searchText isEqualToString:@""]) {
        tableViewDataArray = self.pasArray;
        [self.tableView reloadData];
    }
    else{
        isSearching = true;
        [self.filteredPasArray removeAllObjects];
        for (int i = 0; i < self.pasArray.count; i++) {
            PA* paSearching  = [[PA alloc] init];
            paSearching = self.pasArray[i];
            NSString* toCheck = [paSearching.paString lowercaseString];
            if ([toCheck containsString:[searchText lowercaseString]]) {
                [self.filteredPasArray addObject:paSearching];
            }
        }
        tableViewDataArray = self.filteredPasArray;
        [self.tableView reloadData];
    }
}

#pragma mark - UITouchDelegate Methods
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [[event allTouches] anyObject];
    if ([_medicationsSearchBar isFirstResponder] && [touch view] != _medicationsSearchBar) [_medicationsSearchBar resignFirstResponder];
}


@end
