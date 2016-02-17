#import "PatientsTableViewController.h"
#import "PatientsTableViewCell.h"
#import "MFSideMenu.h"
#import "Storyboards.h"
#import "Envio.h"
#import "Patient.h"
#import "PatientSelectedTableViewController.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"

@interface PatientsTableViewController () <SWTableViewCellDelegate, UISearchBarDelegate, PatientSelectedTableViewControllerDelegate>{
    NSMutableArray* tableViewDataArray;
    UIActivityIndicatorView* spinner;
    BOOL isSearching;
    Patient* patientClicked;
}

@property (strong, nonatomic) IBOutlet UISearchBar *patientSearchBar;
@property (strong, nonatomic) NSMutableArray* patientsArray;
@property (strong, nonatomic) NSMutableArray* filteredPatientsArray;

@end

@implementation PatientsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    self.navigationItem.title = @"Pacientes";
    [self setupPatientsDataSource];
    self.filteredPatientsArray = [NSMutableArray arrayWithCapacity:self.patientsArray.count];
    self.tableView.tableFooterView = [UIView new];
    isSearching = false;
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableViewDataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* PatientsCellID = @"PatientsTableViewCellID";
    
    PatientsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PatientsCellID];
    if (cell==nil) {
        cell = [[PatientsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PatientsCellID];
    }
    cell.rightUtilityButtons = [self rightButtons];
    cell.delegate = self;
    
    Patient* patient = [[Patient alloc] init];
    patient = tableViewDataArray[indexPath.row];
    cell.patientNameLabel.text = patient.patientNameString;
    cell.patientAgeLabel.text = patient.patientAgeString;
    cell.patientGenderLabel.text = patient.patientGenderString;
    cell.patientInitialsLabel.text = [patient.patientNameString substringToIndex:1];
    if (patient.patientPhotoData) {
        cell.patientPhotoImageView.hidden = NO;
        cell.patientPhotoImageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.patientPhotoImageView.layer.cornerRadius = cell.patientPhotoImageView.frame.size.height/2;
        cell.patientPhotoImageView.layer.masksToBounds = YES;
        cell.patientPhotoImageView.image = [UIImage imageWithData:patient.patientPhotoData];
    }
    else{
        cell.patientPhotoImageView.hidden = YES;
    }
    //cell.patientCameSinceLabel.text = tableViewDataArray[];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    patientClicked = [[Patient alloc] init];
    patientClicked = tableViewDataArray[indexPath.row];
    [self performSegueWithIdentifier:@"clickedPatientSegueId" sender:self];
}

#pragma mark - SWTableViewCell Delegate
-(void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    [cell hideUtilityButtonsAnimated:YES];
}

-(NSArray *)rightButtons {
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor: [UIColor colorWithRed:(128/255.0f) green:(128/255.0f) blue:(128/255.0f) alpha:1.0] icon:[UIImage imageNamed:@"icone-favoritarpaciente"]];
    return rightUtilityButtons;
}

#pragma mark - UISearchBarDelegate Methods
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if ([searchText isEqualToString:@""]) {
        tableViewDataArray = self.patientsArray;
        [self.tableView reloadData];
    }
    else{
        isSearching = true;
        [self.filteredPatientsArray removeAllObjects];
        for (int i = 0; i < self.patientsArray.count; i++) {
            Patient* patientSearching = [[Patient alloc] init];
            patientSearching = self.patientsArray[i];
            NSString* toCheck = [patientSearching.patientNameString lowercaseString];
            if ([toCheck containsString:[searchText lowercaseString]]) {
                [self.filteredPatientsArray addObject:patientSearching];
            }
        }
        tableViewDataArray = self.filteredPatientsArray;
        [self.tableView reloadData];
    }
}

#pragma mark - Private Methods
-(void)askedForRefresh{
    [SVProgressHUD show];
    [self setupPatientsDataSource];
    self.filteredPatientsArray = [NSMutableArray arrayWithCapacity:self.patientsArray.count];
    isSearching = false;
}

-(void)setupPatientsDataSource {
    self.patientsArray = [[NSMutableArray alloc] init];
    tableViewDataArray = [[NSMutableArray alloc] init];
    Envio* newEnvio = [[Envio alloc]init];
    
    [newEnvio fetchAllPatients: ^void (NSMutableArray* patientArray){
        if (patientArray){
            self.patientsArray = patientArray;
            NSSortDescriptor *firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"patientCreatedAtString" ascending:NO];
            NSArray *sortDescriptors = [NSArray arrayWithObjects:firstDescriptor, nil];
            NSArray *sortedArray = [self.patientsArray sortedArrayUsingDescriptors:sortDescriptors];
            self.patientsArray = sortedArray;
            tableViewDataArray = self.patientsArray;
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        }else{
            NSLog(@"Erro - setupPatientsDataSource block");
        }
    }];
}

#pragma mark - IBActions
-(IBAction)didTappedMenuBarButton:(UIBarButtonItem *)sender{
    [self.view endEditing:YES];
   	[self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

-(IBAction)didTappedAddPatientBarButton:(id)sender{
    [self.view endEditing:YES];
    [self performSegueWithIdentifier:@"addSegueId" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"clickedPatientSegueId"]) {
        PatientSelectedTableViewController* vc = [[PatientSelectedTableViewController alloc] init];
        vc = segue.destinationViewController;
        vc.delegate = self;
        [vc setPatient:patientClicked];
    }
}

@end
