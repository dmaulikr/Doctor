#import "PatientSelectedAppointmentsTableViewController.h"
#import "PatientSelectedAppointmentSelectedTableViewController.h"
#import "PatientSelectedNewAppointmentTableViewController.h"
#import "AppointmentSpecialtyGroupTableViewCell.h"
#import "AppointmentTableViewCell.h"
#import "Envio.h"
#import "Appointment.h"
#import "Patient.h"
#import "SVProgressHUD.h"

@interface PatientSelectedAppointmentsTableViewController (){
    NSMutableArray* tableViewDataArray;
    Appointment* appointmentBeingPassed;
    UIActivityIndicatorView* spinner;

    NSMutableArray* arrayOfSections;
    NSMutableArray* arrayOfArraysForEachSection;

}

@property (nonatomic, weak) IBOutlet UILabel* patientNameLabel;
@property (nonatomic, weak) IBOutlet UILabel* patientCameSinceLabel;
@property (nonatomic, weak) IBOutlet UIImageView* patientImageView;

@end

@implementation PatientSelectedAppointmentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrayOfSections = [[NSMutableArray alloc] init];
    arrayOfArraysForEachSection = [[NSMutableArray alloc] init];
    
    appointmentBeingPassed = [[Appointment alloc] init];
    
    self.patientCameSinceLabel.numberOfLines = 0;
    self.patientCameSinceLabel.text = self.patient.patientCameSinceString;
    self.tableView.tableFooterView = [UIView new];
    
    if (self.patient.patientPhotoData) {
        self.patientImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.patientImageView.layer.cornerRadius = self.patientImageView.frame.size.height/2;
        self.patientImageView.layer.masksToBounds = YES;
        self.patientImageView.image = [UIImage imageWithData:self.patient.patientPhotoData];
    }
}

- (void) viewWillAppear:(BOOL)animated{
    [self setupAppointmentsDataSource];
    [self setupLoadingAnimation];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    appointmentBeingPassed = arrayOfArraysForEachSection[indexPath.section][indexPath.row];
    [self performSegueWithIdentifier:@"appointmentSelectedSegueId" sender:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray* teste = [[NSMutableArray alloc] initWithArray:arrayOfArraysForEachSection[section]];
    return teste.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return arrayOfSections.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* cellIdentifier = @"AppointmentsTableViewCellID";
    AppointmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell = [[AppointmentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    Appointment* appointment = [[Appointment alloc] init];
    appointment = arrayOfArraysForEachSection[indexPath.section][indexPath.row];
    cell.appointmentPreDescriptionLabel.text = appointment.appointmentDoctorEnvolvedName;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Setups
- (void) setupAppointmentsDataSource {
    [arrayOfArraysForEachSection removeAllObjects];
    [arrayOfSections removeAllObjects];
    self.patientNameLabel.text = self.patient.patientNameString;
    self.patientCameSinceLabel.text = self.patient.patientCameSinceString;
    //self.patientImageView.image = self.patient.patientImage;
    
    tableViewDataArray = [[NSMutableArray alloc] init];
    Envio* newEnvio = [[Envio alloc]init];
    [newEnvio fetchAppointmentPassingPatient:self.patient withCompletion: ^void (NSMutableArray* appointmentArray){
        if (appointmentArray){
            NSSortDescriptor *firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"appointmentArea" ascending:YES];
            NSArray *sortDescriptors = [NSArray arrayWithObjects:firstDescriptor, nil];
            NSArray *sortedArray = [appointmentArray sortedArrayUsingDescriptors:sortDescriptors];
            for (NSInteger i = sortedArray.count; i > 0; i--) {
                Appointment* appointment = [[Appointment alloc] init];
                appointment = sortedArray[i-1];
                if (![arrayOfSections containsObject:appointment.appointmentArea]) {
                    [arrayOfSections addObject:appointment.appointmentArea];
                    NSMutableArray* array = [[NSMutableArray alloc] init];
                    [arrayOfArraysForEachSection addObject:array];
                }
            }
            for (NSInteger i = arrayOfSections.count; i > 0; i--) {
                NSString* specialty = arrayOfSections[i-1];
                for (NSInteger j = sortedArray.count; j > 0; j--) {
                    Appointment* appointment = [[Appointment alloc] init];
                    appointment = sortedArray[j-1];
                    if ([appointment.appointmentArea isEqualToString:specialty]) {
                        [arrayOfArraysForEachSection[i-1] addObject:appointment];
                    }
                }
            }
            tableViewDataArray = arrayOfSections;
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        }else{
            NSLog(@"Erro - setupAppointmentsDataSource block");
        }
    }];
}

- (void) setupLoadingAnimation{
//    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    spinner.center = self.view.center;
//    spinner.tag = 12;
//    [self.view addSubview:spinner];
//    [spinner startAnimating];
    [SVProgressHUD show];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [arrayOfSections objectAtIndex:section];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"appointmentSelectedSegueId"]) {
        PatientSelectedAppointmentSelectedTableViewController* vc = segue.destinationViewController;
        [vc setPatient:self.patient];
        [vc setAppointment:appointmentBeingPassed];
    }
    else if ([segue.identifier isEqualToString:@"newAppointmentSegue"]){
        PatientSelectedNewAppointmentTableViewController* vc = segue.destinationViewController;
        [vc setPatient:self.patient];
    }
}

- (IBAction)didTappedForNewAppointment:(id)sender{
    [self performSegueWithIdentifier:@"newAppointmentSegue" sender:self];
}

@end
