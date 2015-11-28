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
#import "Envio.h"
#import "Patient.h"
#import "PatientSelectedTableViewController.h"
#import "VersionHistory.h"
#import "AppDelegate.h"

@interface PatientsTableViewController () <SWTableViewCellDelegate, UISearchBarDelegate>{
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
}

- (void) viewWillAppear:(BOOL)animated{
    self.navigationItem.title = @"Pacientes";
    [self setupLoadingAnimation];
    [self setupPatientsDataSource];
    [self setupSearch];
    self.tableView.tableFooterView = [UIView new];
    isSearching = false;
    
    //Test version History
    //[self testVersion];
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableViewDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    patientClicked = [[Patient alloc] init];
    patientClicked = tableViewDataArray[indexPath.row];
    [self performSegueWithIdentifier:@"clickedPatientSegueId" sender:self];
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
            
            //delete patient id from the doctor's patient's array
            Envio* envio = [[Envio alloc]init];
            Patient* patient = [[Patient alloc]init];
            Doctor* doctor = [PFUser currentUser];
            patient = _patientsArray[cellIndexPath.row];
            
            [envio deletePatient:patient fromDoctor:doctor]; //This doctor must be the current user
            
            break;
        }
        default:
            break;
    }
}

#pragma mark - UISearchBarDelegate Methods
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
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

#pragma mark - Setups
- (void) setupPatientsDataSource {
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
            [spinner stopAnimating];
        }else{
            NSLog(@"Erro - setupPatientsDataSource block");
        }
    }];
}

- (void) setupLoadingAnimation{
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = self.view.center;
    spinner.tag = 12;
    [self.view addSubview:spinner];
    [spinner startAnimating];
}

- (void) setupSearch{
    self.filteredPatientsArray = [NSMutableArray arrayWithCapacity:self.patientsArray.count];
}

#pragma mark - IBActions
-(IBAction)didTappedMenuBarButton:(UIBarButtonItem *)sender{
   	[self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

-(IBAction)didTappedAddPatientBarButton:(id)sender{
//    UIViewController *vc = [[UIStoryboard storyboardWithName:kPatientsStoryboard bundle:nil] instantiateViewControllerWithIdentifier:kPatientsAddModalID];
//    [self.menuContainerViewController.centerViewController presentViewController:vc animated:YES completion:^{
//        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{}];
//    }];
    [self performSegueWithIdentifier:@"addSegueId" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"clickedPatientSegueId"]) {
        PatientSelectedTableViewController* patientSelectedTableViewController = segue.destinationViewController;
        [patientSelectedTableViewController setPatient:patientClicked];
    }
}

- (NSArray *)rightButtons {
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor: [UIColor colorWithRed:(128/255.0f) green:(128/255.0f) blue:(128/255.0f) alpha:1.0] icon:[UIImage imageNamed:@"icone-favoritarpaciente"]];
    [rightUtilityButtons sw_addUtilityButtonWithColor: [UIColor colorWithRed:(128/255.0f) green:(128/255.0f) blue:(128/255.0f) alpha:1.0f] icon:[UIImage imageNamed:@"icone-excluirpaciente"]];
    return rightUtilityButtons;
}

#pragma mark test Version

- (void) testVersion{
    
    NSLog(@"versionUpdated test");

    
    Treatment* oldTreatment = [[Treatment alloc]init];
    Treatment* newTreatment = [[Treatment alloc]init];
    
    oldTreatment.treatmentDuration = [NSNumber numberWithInt:150];
    oldTreatment.treatmentDescription = @"Old";
    oldTreatment.treatmentStatus = [NSNumber numberWithBool:FALSE];
    
    
    newTreatment.treatmentDuration = [NSNumber numberWithInt:150];
    newTreatment.treatmentDescription = @"New";
    newTreatment.treatmentStatus = [NSNumber numberWithBool:FALSE];
    
    VersionHistory* versionUpdate = [[VersionHistory alloc]init];
    
    [versionUpdate updateVersion:oldTreatment withNewVersion:newTreatment];

}


#pragma mark - UITouchDelegate Methods
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [[event allTouches] anyObject];
    if ([_patientSearchBar isFirstResponder] && [touch view] != _patientSearchBar) [_patientSearchBar resignFirstResponder];
}

@end
