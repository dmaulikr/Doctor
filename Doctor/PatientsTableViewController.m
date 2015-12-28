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
#import "AFDropdownNotification.h"
#import "SVProgressHUD.h"
#import "JCDialPad.h"

@interface PatientsTableViewController () <SWTableViewCellDelegate, UISearchBarDelegate, AFDropdownNotificationDelegate, PatientSelectedTableViewControllerDelegate, JCDialPadDelegate>{
    NSMutableArray* tableViewDataArray;
    UIActivityIndicatorView* spinner;
    BOOL isSearching;
    Patient* patientClicked;
    AFDropdownNotification* notification;
    
}

@property (strong, nonatomic) IBOutlet UISearchBar *patientSearchBar;
@property (strong, nonatomic) NSMutableArray* patientsArray;
@property (strong, nonatomic) NSMutableArray* filteredPatientsArray;

@end

@implementation PatientsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [self setupNotification];
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

#pragma mark - Setups
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

-(void)setupLoadingAnimation{
//    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    spinner.center = self.view.center;
//    spinner.tag = 12;
//    [self.view addSubview:spinner];
//    [spinner startAnimating];
   [SVProgressHUD show];
}

-(void)setupSearch{
    self.filteredPatientsArray = [NSMutableArray arrayWithCapacity:self.patientsArray.count];
}

#pragma mark - IBActions
-(IBAction)didTappedMenuBarButton:(UIBarButtonItem *)sender{
   // [self.view endEditing:YES];
   //	[self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
    
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        self.view.backgroundColor = [UIColor clearColor];
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame = self.view.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.view addSubview:blurEffectView];
    }
    else {
        self.view.backgroundColor = [UIColor blackColor];
    }
    
    JCDialPad *pad = [[JCDialPad alloc] initWithFrame:self.view.bounds];
    pad.buttons = [JCDialPad defaultButtons];
    pad.delegate = self;
    pad.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:.5f];
    [self.view addSubview:pad];
}

-(IBAction)didTappedAddPatientBarButton:(id)sender{
//    UIViewController *vc = [[UIStoryboard storyboardWithName:kPatientsStoryboard bundle:nil] instantiateViewControllerWithIdentifier:kPatientsAddModalID];
//    [self.menuContainerViewController.centerViewController presentViewController:vc animated:YES completion:^{
//        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{}];
//    }];
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

-(NSArray *)rightButtons {
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor: [UIColor colorWithRed:(128/255.0f) green:(128/255.0f) blue:(128/255.0f) alpha:1.0] icon:[UIImage imageNamed:@"icone-favoritarpaciente"]];
//    [rightUtilityButtons sw_addUtilityButtonWithColor: [UIColor colorWithRed:(128/255.0f) green:(128/255.0f) blue:(128/255.0f) alpha:1.0f] icon:[UIImage imageNamed:@"icone-excluirpaciente"]];
    return rightUtilityButtons;
}

#pragma mark test Version
-(void)testVersion{
    
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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [[event allTouches] anyObject];
    if ([_patientSearchBar isFirstResponder] && [touch view] != _patientSearchBar) [_patientSearchBar resignFirstResponder];
}

#pragma mark - Private Methods
-(void)setupNotification{
    notification = [[AFDropdownNotification alloc] init];
    notification.notificationDelegate = self;
    notification.titleText = @"Olá, ";
    notification.subtitleText = @"Seu paciente Breno inseriu uma radiografia recentemente.";
    notification.dismissOnTap = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [notification presentInView:self.view withGravityAnimation:NO];
    });
}

-(void)askedForRefresh{
    [self setupLoadingAnimation];
    [self setupPatientsDataSource];
    [self setupSearch];
    isSearching = false;
}

@end
