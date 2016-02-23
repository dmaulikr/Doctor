#import "PatientsTableViewController.h"
#import "PatientsTableViewCell.h"
#import "MFSideMenu.h"
#import "Storyboards.h"
#import "Envio.h"
#import "Patient.h"
#import "PatientSelectedTableViewController.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"

@import VerifyIosSdk;
@interface PatientsTableViewController () <UIAlertViewDelegate, SWTableViewCellDelegate, UISearchBarDelegate, PatientSelectedTableViewControllerDelegate>{
    NSMutableArray* tableViewDataArray;
    UIActivityIndicatorView* spinner;
    BOOL isSearching;
    Patient* patientClicked;
    UILabel *emptyLabel;
    NSString *patientToPermit;
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
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icone-adicionar"] style:UIBarButtonItemStylePlain target:self action:@selector(didTappedAddPatientBarButton)];
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"magnifier"] style:UIBarButtonItemStylePlain target:self action:@selector(didTappedSearchBarButton)];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:addButton, searchButton, nil]];
    
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
    
    NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
                                       components:NSYearCalendarUnit
                                       fromDate:patient.patientBirthDate
                                       toDate:[NSDate date]
                                       options:0];
    
    cell.patientAgeLabel.text =[NSString stringWithFormat:@"%li", ageComponents.year];

    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    patientClicked = [[Patient alloc] init];
    patientClicked = tableViewDataArray[indexPath.row];
    [self performSegueWithIdentifier:@"clickedPatientSegueId" sender:self];
}

#pragma mark - SWTableViewCell Delegate
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    [cell hideUtilityButtonsAnimated:YES];
}

- (NSArray *)rightButtons {
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor: [UIColor colorWithRed:(128/255.0f) green:(128/255.0f) blue:(128/255.0f) alpha:1.0] icon:[UIImage imageNamed:@"icone-favoritarpaciente"]];
    return rightUtilityButtons;
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

#pragma mark - Private Methods
- (void)askedForRefresh{
    [SVProgressHUD show];
    [self setupPatientsDataSource];
    self.filteredPatientsArray = [NSMutableArray arrayWithCapacity:self.patientsArray.count];
    isSearching = false;
}

- (void)setupPatientsDataSource {
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
            if (emptyLabel) {
                emptyLabel = nil;
            }
            [SVProgressHUD dismiss];
        }else{
            if (emptyLabel) {
                emptyLabel = nil;
            }
            [SVProgressHUD dismiss];
            NSLog(@"Erro - setupPatientsDataSource block");
        }
        if (tableViewDataArray.count == 0) {
            if (!emptyLabel) {
                emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-200, [UIScreen mainScreen].bounds.size.height/2-25, 400, 50)];
                emptyLabel.text = @"Você ainda não tem nenhum paciente.";
                emptyLabel.numberOfLines = 0;
                emptyLabel.backgroundColor = [UIColor clearColor];
                emptyLabel.textColor = [UIColor blackColor];
                emptyLabel.textAlignment = NSTextAlignmentCenter;
                [self.view addSubview:emptyLabel];
            }
        }
    }];
}

- (void) didTappedSearchBarButton{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Atenção" message:@"Insira o CPF do paciente, e se ele estiver no nosso banco de dados será enviado um código de liberação para o mesmo." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* confirmButton = [UIAlertAction actionWithTitle:@"Confirmar" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        [self askedForPatient:alert.textFields[0].text];
        [SVProgressHUD show];
                                    }];
    
    
    UIAlertAction* cancelButton = [UIAlertAction actionWithTitle:@"Cancelar" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
                                        [alert dismissViewControllerAnimated:YES completion:nil];
                                    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"CPF";
        [textField setKeyboardType:UIKeyboardTypeNumberPad];
    }];
    
    [alert addAction:cancelButton];
    [alert addAction:confirmButton];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"clickedPatientSegueId"]) {
        PatientSelectedTableViewController* vc = [[PatientSelectedTableViewController alloc] init];
        vc = segue.destinationViewController;
        vc.delegate = self;
        [vc setPatient:patientClicked];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (alertView.tag) {
        case 1:
            if (buttonIndex == 1) {

            }
            break;
        case 2:
            if (buttonIndex == 1) {
                [VerifyClient checkPinCode:[alertView textFieldAtIndex:0].text];
                [SVProgressHUD show];
            }
            break;
        default:
            break;
    }
}

- (void) askedForPatient:(NSString *)cpf{
    if (cpf) {
        PFQuery *query = [PFQuery queryWithClassName:@"Patient"];
        [query whereKey:@"CPF" equalTo:cpf];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
            if (!error && objects.count == 1) {
                for (PFObject* object in objects){
                    patientToPermit = object.objectId;
                    [VerifyClient getVerifiedUserWithCountryCode:@"BR" phoneNumber:object[@"telefone"] verifyInProgressBlock:^{
                        [SVProgressHUD dismiss];
                        UIAlertView* alertView2 = [[UIAlertView alloc] initWithTitle:@"Atenção" message:@"Insira o código de 4 números fornecido para o seu paciente" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Confirmar", nil];
                        alertView2.alertViewStyle = UIAlertViewStylePlainTextInput;
                        alertView2.tag = 2;
                        [[alertView2 textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
                        alertView2.delegate = self;
                        [alertView2 show];
                        
                    }
                                               userVerifiedBlock:^{
                                                   [self patientConfirmationWentFine];
                                               }
                                                      errorBlock:^(VerifyError error) {
                                                          [VerifyClient cancelVerificationWithBlock:^(NSError *error){
                                                              [self patientConfirmationWentWrong];
                                                          }];
                                                      }];
        
                }
            }
            else{
                [SVProgressHUD dismiss];
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Atenção" message:@"Não encontramos ninguém com esse CPF no nosso banco de dados.\nCrie este paciente clicando no simbolo de '+ ' logo acima, leva só 1 minuto!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
                
            }
        }];
    }
}

#pragma mark - IBActions
- (IBAction)didTappedMenuBarButton:(UIBarButtonItem *)sender{
    [self.view endEditing:YES];
   	[self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

- (void)didTappedAddPatientBarButton{
    [self.view endEditing:YES];
    [self performSegueWithIdentifier:@"addSegueId" sender:self];
}

- (void) patientConfirmationWentFine{
    PFQuery *query = [PFQuery queryWithClassName:@"Users"];
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [query whereKey:@"username" equalTo:appDelegate.doctor.doctorUsernameString];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (!error && objects.count == 1) {
            PFObject* object = objects[0];
            NSMutableArray *array = [[NSMutableArray alloc] init];
            array = object[@"permitedPatients"];
            if (![array containsObject:patientToPermit] || !array) {
                [array addObject:patientToPermit];
                object[@"permitedPatients"] = array;
                [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
                    appDelegate.doctor.doctorPatientsArray = array;
                    [self setupPatientsDataSource];
                }];
            }
        }
    }];
}

- (void) patientConfirmationWentWrong{
    [SVProgressHUD dismiss];
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Atenção" message:@"O código inserido não confere com o enviado, é necessário que o paciente o informe." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];

}
@end
