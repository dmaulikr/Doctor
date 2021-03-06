#import "PatientSelectedDataTableViewController.h"
#import "PatientSelectedEditTableViewController.h"

@interface PatientSelectedDataTableViewController () <PatientSelectedEditTableViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UITextView* birthDateTextView;
@property (nonatomic, weak) IBOutlet UITextView* sexTextView;
@property (nonatomic, weak) IBOutlet UITextView* bloodTypeTextView;
@property (nonatomic, weak) IBOutlet UITextView* clinicalConditionsTextView;
@property (nonatomic, weak) IBOutlet UITextView* medicationsTextView;
@property (nonatomic, weak) IBOutlet UITextView* alergiesTextView;
@property (nonatomic, weak) IBOutlet UITextView* observationsTextView;
@property (nonatomic, weak) IBOutlet UITextView* weightTextView;
@property (nonatomic, weak) IBOutlet UITextView* heightTextView;
@property (nonatomic, weak) IBOutlet UITextView* emergencyContactTextView;
@property (nonatomic, weak) IBOutlet UITextView* addressTextView;
@property (nonatomic, weak) IBOutlet UITextView* cpfTextView;

@property (nonatomic, weak) IBOutlet UILabel* patientNameLabel;
@property (nonatomic, weak) IBOutlet UILabel* patientCameSinceLabel;
@property (nonatomic, weak) IBOutlet UIImageView* patientImageView;

@end

@implementation PatientSelectedDataTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadPatientData];
    self.patientCameSinceLabel.numberOfLines = 0;
    self.tableView.tableFooterView = [UIView new];
}

- (void) loadPatientData{
    
    if (self.patient.patientPhotoData) {
        self.patientImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.patientImageView.layer.cornerRadius = self.patientImageView.frame.size.height/2;
        self.patientImageView.layer.masksToBounds = YES;
        self.patientImageView.image = [UIImage imageWithData:self.patient.patientPhotoData];
    }
    
    self.patientNameLabel.text = self.patient.patientNameString;
    self.patientCameSinceLabel.text = self.patient.patientCameSinceString;
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    
    //self.patientImageView.image = self.patient.patientImage;
    
    NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
                                       components:NSYearCalendarUnit
                                       fromDate:self.patient.patientBirthDate
                                       toDate:[NSDate date]
                                       options:0];
    
    
    self.birthDateTextView.text = [NSString stringWithFormat:@"%@ - (%li anos)", [dateFormatter stringFromDate:self.patient.patientBirthDate], ageComponents.year];

    
    self.sexTextView.text = self.patient.patientGenderString;
    self.bloodTypeTextView.text = self.patient.patientBloodTypeString;
    self.clinicalConditionsTextView.text = self.patient.patientClinicalConditionsString;
    self.medicationsTextView.text = self.patient.patientMedicationsString;
    self.alergiesTextView.text = self.patient.patientAlergiesString;
    self.observationsTextView.text = self.patient.patientObservationsString;
    self.weightTextView.text = self.patient.patientWeightString;
    self.heightTextView.text = self.patient.patientHeightString;
    self.emergencyContactTextView.text = self.patient.patientEmergencyContactString;
    self.addressTextView.text = self.patient.patientAdressString;
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setDecimalSeparator:@"."];
    [formatter setGroupingSeparator:@"."];
    self.cpfTextView.text = [formatter stringFromNumber:[NSNumber numberWithInteger:[self.patient.patientCPFString integerValue]]];
    
}

- (IBAction)didTappedEdit:(id)sender{
    [self performSegueWithIdentifier:@"clickedInEditSegueId" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"clickedInEditSegueId"]) {
        PatientSelectedEditTableViewController* edit = [[PatientSelectedEditTableViewController alloc] init];
        edit = segue.destinationViewController;
        edit.delegate = self;
        edit.patient = self.patient;
    }
}

- (void) askedForRefresh:(Patient *)updatedPatient{
    self.patient = updatedPatient;
    [self loadPatientData];
    if ([_delegate respondsToSelector:@selector(askedForRefresh:)]) {
        [_delegate askedForRefresh:updatedPatient];
    }
}

@end