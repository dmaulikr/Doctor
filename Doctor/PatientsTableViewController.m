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

@interface PatientsTableViewController () <SWTableViewCellDelegate, UISearchBarDelegate, UISearchDisplayDelegate>{
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
    [self setupLoadingAnimation];
    [self setupPatientsDataSource];
    [self setupSearch];
    self.tableView.tableFooterView = [UIView new];
    isSearching = false;
}

- (void) viewWillAppear:(BOOL)animated{
    self.navigationItem.title = @"Pacientes";
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
    
  //  NSLog(tableViewDataArray[indexPath.row]);
    //cell.patientGenderLabel.text = tableViewDataArray[];
    //cell.patientAgeLabel.text = tableViewDataArray[];
    //cell.patientCameSinceLabel.text = tableViewDataArray[];
    //cell.patientPhotoImageView.image = tableViewDataArray[];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSArray *)rightButtons {
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor: [UIColor colorWithRed:(128/255.0f) green:(128/255.0f) blue:(128/255.0f) alpha:1.0] icon:[UIImage imageNamed:@"icone-favoritarpaciente"]];
    [rightUtilityButtons sw_addUtilityButtonWithColor: [UIColor colorWithRed:(128/255.0f) green:(128/255.0f) blue:(128/255.0f) alpha:1.0f] icon:[UIImage imageNamed:@"icone-excluirpaciente"]];
    
    return rightUtilityButtons;
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
            break;
        }
        default:
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    patientClicked = [[Patient alloc] init];
    patientClicked = tableViewDataArray[indexPath.row];
    [self performSegueWithIdentifier:@"clickedPatientSegueId" sender:self];
}

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    if ([searchText isEqualToString:@""]) {
        tableViewDataArray = self.patientsArray;
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
    }
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString scope:
    [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
    [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    return YES;
}

#pragma mark - Setups

- (void) setupPatientsDataSource {
    
    self.patientsArray = [[NSMutableArray alloc] init];
    tableViewDataArray = [[NSMutableArray alloc] init];

    PFQuery *query = [PFQuery queryWithClassName:@"Patient"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d patients.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                
                Patient* patient = [[Patient alloc]init];
                patient.patientNameString = [object objectForKey:@"name"];
                patient.patientCPFString = [object objectForKey:@"CPF"];
                patient.patientAgeString = [object objectForKey:@"age"];
                patient.patientRGString = [object objectForKey:@"RG"];
                
                [self.patientsArray addObject:patient];
                tableViewDataArray = self.patientsArray;
                [self.tableView reloadData];
                [spinner stopAnimating];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    

}




//- (void) setupPatientsDataSource{
//    self.patientsArray = [[NSMutableArray alloc] init];
//    tableViewDataArray = [[NSMutableArray alloc] init];
//    
//      Envio* envio = [[Envio alloc] init];
//      Patient* patient = [[Patient alloc] init];
////    patient.patientNameString = @"Bruno Muniz";
////    patient.patientAgeString = @"37";
////    patient.patientBirthDateString = @"12/12/2012";
////    patient.patientCPFString = @"123123";
////    patient.patientRGString = @"8883322";
////    patient.patientGenderString = @"Masculino";
////    patient.patientAdressString = @"Av. Boa Viagem, 123 apt 101";
////    [envio newPatient:patient];
//  
//    
//    
//    
////    
////    [envio fetchPatient:@"123123" completeHandler:^(Patient * patientRetornado)  {
////        
////        if(patientRetornado != nil){
////           [self.patientsArray addObject:patientRetornado];
////            
////            NSLog(@"%@", patientRetornado.patientNameString);
////            tableViewDataArray = self.patientsArray;
////        }
////        [self.tableView reloadData];
////        
////        [spinner stopAnimating];
////        
////    }];
//    
//    
////   self.patientsArray = [envio fetchPatient:@"1215"];
//    
////  completion block from fetch query
////    self.patientsArray = [envio fetchPatient:@"1215" withCompletionBlock:^(){
//
////        }
////    ];
//    [self.patientsArray addObject:patient];
//    tableViewDataArray = self.patientsArray;
//    
//   // tableViewDataArray = self.patientsArray;
//}

- (void) setupLoadingAnimation{
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = self.view.center;
    spinner.tag = 12;
    [self.view addSubview:spinner];
    [spinner startAnimating];
}

- (void) setupSearch{ self.filteredPatientsArray = [NSMutableArray arrayWithCapacity:self.patientsArray.count]; }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath { return 110; }

#pragma mark - IBActions
-(IBAction)didTappedMenuBarButton:(UIBarButtonItem *)sender{
   	[self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

-(IBAction)didTappedAddPatientBarButton:(id)sender{
    UIViewController *vc = [[UIStoryboard storyboardWithName:kPatientsStoryboard bundle:nil] instantiateViewControllerWithIdentifier:kPatientsAddModalID];
    [self.menuContainerViewController.centerViewController presentViewController:vc animated:YES completion:^{
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{}];
    }];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"clickedPatientSegueId"]) {
        PatientSelectedTableViewController* patientSelectedTableViewController = segue.destinationViewController;
        [patientSelectedTableViewController setPatient:patientClicked];
    }
}

@end
