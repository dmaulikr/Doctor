//
//  PatientSelectedAppointmentsTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/24/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "PatientSelectedAppointmentsTableViewController.h"
#import "PatientSelectedAppointmentSelectedTableViewController.h"
#import "PatientSelectedNewAppointmentTableViewController.h"
#import "AppointmentSpecialtyGroupTableViewCell.h"
#import "AppointmentTableViewCell.h"
#import "Envio.h"
#import "Appointment.h"
#import "Patient.h"

@interface PatientSelectedAppointmentsTableViewController (){
    NSMutableArray* tableViewDataArray;
    UIActivityIndicatorView* spinner;
    int numberOfSections;
    NSMutableArray* arrayOfSections;
}

@property (nonatomic, weak) IBOutlet UILabel* patientNameLabel;
@property (nonatomic, weak) IBOutlet UILabel* patientCameSinceLabel;
@property (nonatomic, weak) IBOutlet UIImageView* patientImageView;

@end

@implementation PatientSelectedAppointmentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    numberOfSections = 0;
    arrayOfSections = [[NSMutableArray alloc] init];
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
-(void) viewWillAppear:(BOOL)animated{
    [self setupAppointmentsDataSource];
    [self setupLoadingAnimation];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"appointmentSelectedSegueId" sender:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableViewDataArray.count+1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return numberOfSections;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* AppointmentCellID = @"AppointmentsTableViewCellID";
    NSString* AppointmentAreaCellID = @"AppointmentsAreaTableViewCellID";
    NSString* cellIdentifier = indexPath.row == 0 ? AppointmentAreaCellID : AppointmentCellID;
    
    if ([cellIdentifier isEqualToString:AppointmentAreaCellID]) {
        AppointmentSpecialtyGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[AppointmentSpecialtyGroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.appointmentSpecialtyLabel.text = arrayOfSections[indexPath.section];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
        AppointmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell==nil) {
            cell = [[AppointmentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        Appointment* appointment = [[Appointment alloc] init];
        appointment = tableViewDataArray[indexPath.row-1];
        cell.appointmentPreDescriptionLabel.text = appointment.appointmentDoctorEnvolvedName;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

#pragma mark - Setups
- (void) setupAppointmentsDataSource {
    self.patientNameLabel.text = self.patient.patientNameString;
    self.patientCameSinceLabel.text = self.patient.patientCameSinceString;
    //self.patientImageView.image = self.patient.patientImage;
    
    tableViewDataArray = [[NSMutableArray alloc] init];
    Envio* newEnvio = [[Envio alloc]init];
    [newEnvio fetchAppointmentPassingPatient:self.patient withCompletion: ^void (NSMutableArray* appointmentArray){
        if (appointmentArray){
            int sectionCounter = 0;
            arrayOfSections = [[NSMutableArray alloc] init];
            for (int i = appointmentArray.count; i > 0; i--) {
                Appointment* seeingAppointment = [[Appointment alloc] init];
                seeingAppointment = appointmentArray[i-1];
                if (![arrayOfSections containsObject:seeingAppointment.appointmentArea]) {
                    [arrayOfSections addObject:seeingAppointment.appointmentArea];
                    sectionCounter++;
                }
            }
            numberOfSections = sectionCounter;
            tableViewDataArray = appointmentArray;
            [self.tableView reloadData];
            [spinner stopAnimating];
        }else{
            NSLog(@"Erro - setupAppointmentsDataSource block");
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"appointmentSelectedSegueId"]) {
        PatientSelectedAppointmentSelectedTableViewController* vc = segue.destinationViewController;
        [vc setPatient:self.patient];
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
