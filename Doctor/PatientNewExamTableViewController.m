//
//  PatientNewExamTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 11/28/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "PatientNewExamTableViewController.h"
#import "ExamChooseInsuranceTableViewController.h"
#import "AppDelegate.h"

@interface PatientNewExamTableViewController () <ExamChooseInsuranceTableViewControllerDelegate> {
    BOOL hasFirstExam;
    BOOL hasSecondExam;
    BOOL hasThirdExam;
}

@property (nonatomic, weak) IBOutlet UILabel* patientNameLabel;
@property (nonatomic, weak) IBOutlet UILabel* patientCameSinceLabel;
@property (nonatomic, weak) IBOutlet UIImageView* patientImageView;

@property (nonatomic, weak) IBOutlet UILabel* examDateLabel;
@property (nonatomic, weak) IBOutlet UILabel* examProtocolLabel;
@property (nonatomic, weak) IBOutlet UILabel* examDoctorAskedLabel;
@property (nonatomic, weak) IBOutlet UILabel* examInsuranceLabel;

//First Exam
@property (nonatomic, weak) IBOutlet UIImageView* firstExamEmptyCameraImageView;
@property (nonatomic, weak) IBOutlet UIImageView* firstExamImageView;
@property (nonatomic, weak) IBOutlet UIImageView* firstExamCameraChangeImageView;

//Second Exam
@property (nonatomic, weak) IBOutlet UIImageView* secondExamEmptyCameraImageView;
@property (nonatomic, weak) IBOutlet UIImageView* secondExamImageView;
@property (nonatomic, weak) IBOutlet UIImageView* secondExamCameraChangeImageView;

//Third Exam
@property (nonatomic, weak) IBOutlet UIImageView* thirdExamEmptyCameraImageView;
@property (nonatomic, weak) IBOutlet UIImageView* thirdExamImageView;
@property (nonatomic, weak) IBOutlet UIImageView* thirdExamCameraChangeImageView;

@end

@implementation PatientNewExamTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    [self loadPatientHeaderData];
    [self loadTapRecognizers];
    [self loadExamAutoData];
}

- (void) loadPatientHeaderData{
    self.patientNameLabel.text = self.patient.patientNameString;
    self.patientCameSinceLabel.text = self.patient.patientCameSinceString;
}

- (void) loadExamAutoData{
    self.examDateLabel.text = [self getCurrentTimeAndDate];
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.examDoctorAskedLabel.text = appDelegate.doctor.doctorNameString;
    self.examProtocolLabel.text = @"DAS-F31RF#123";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return 156;
        case 1:
            return 50;
            break;
        case 2:
            return 50;
            break;
        case 3:
            return 50;
            break;
        case 4:
            return 50;
            break;
        case 5:
            return 50;
            break;
        case 6:
            return 50;
            break;
        case 7:
            return 10;
            break;
        case 8:
            return hasFirstExam ? 361 : 50;
            break;
        case 9:
            return 10;
            break;
        case 10:
            return hasSecondExam ? 361 : 50;
            break;
        case 11:
            return 10;
            break;
        case 12:
            return hasThirdExam ? 361 : 50;
            break;
        default:
            return 10;
            break;
    }
}
- (void) loadTapRecognizers{
    self.firstExamCameraChangeImageView.userInteractionEnabled = YES;
    self.firstExamEmptyCameraImageView.userInteractionEnabled = YES;
    self.firstExamImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* tapFirstCameraChange = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedFirstCameraChange)];
    [self.firstExamCameraChangeImageView addGestureRecognizer:tapFirstCameraChange];
    
    UITapGestureRecognizer* tapFirstCameraEmpty = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedFirstEmptyCamera)];
    [self.firstExamEmptyCameraImageView addGestureRecognizer:tapFirstCameraEmpty];
    
    UITapGestureRecognizer* tapFirstExam = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedFirstExam)];
    [self.firstExamImageView addGestureRecognizer:tapFirstExam];
    
    self.secondExamImageView.userInteractionEnabled = YES;
    self.secondExamEmptyCameraImageView.userInteractionEnabled = YES;
    self.secondExamCameraChangeImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* tapSecondCameraChange = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedSecondCameraChange)];
    [self.secondExamCameraChangeImageView addGestureRecognizer:tapSecondCameraChange];
    
    UITapGestureRecognizer* tapSecondCameraEmpty = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedSecondEmptyCamera)];
    [self.secondExamEmptyCameraImageView addGestureRecognizer:tapSecondCameraEmpty];
    
    UITapGestureRecognizer* tapSecondExam = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedSecondExam)];
    [self.secondExamImageView addGestureRecognizer:tapSecondExam];
    
    self.thirdExamImageView.userInteractionEnabled = YES;
    self.thirdExamEmptyCameraImageView.userInteractionEnabled = YES;
    self.thirdExamCameraChangeImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* tapThirdCameraChange = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedThirdCameraChange)];
    [self.thirdExamCameraChangeImageView addGestureRecognizer:tapThirdCameraChange];
    
    UITapGestureRecognizer* tapThirdCameraEmpty = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedThirdEmptyCamera)];
    [self.thirdExamEmptyCameraImageView addGestureRecognizer:tapThirdCameraEmpty];
    
    UITapGestureRecognizer* tapThirdExam = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedThirdExam)];
    [self.thirdExamImageView addGestureRecognizer:tapThirdExam];
}

- (void) didTappedFirstCameraChange{
    NSLog(@"first change");
}
- (void) didTappedFirstEmptyCamera{
    NSLog(@"first empty");
}
- (void) didTappedFirstExam{
    NSLog(@"first EXAM");
}
- (void) didTappedSecondCameraChange{
    NSLog(@"second change");
}
- (void) didTappedSecondEmptyCamera{
    NSLog(@"SECOND EMPTY");
}
- (void) didTappedSecondExam{
    NSLog(@"SECOND EXAM");
}
- (void) didTappedThirdCameraChange{
    NSLog(@"THIRD change");
}
- (void) didTappedThirdEmptyCamera{
    NSLog(@"THIRD EMPTY");
}
- (void) didTappedThirdExam{
    NSLog(@"THIRD EXAM");
}

- (NSString *) getCurrentTimeAndDate{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy hh:mm"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

- (IBAction)didTappedToSaveExam:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 4:
            [self performSegueWithIdentifier:@"chooseInsuranceSegueId" sender:self];
            break;
        default:
            break;
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"chooseInsuranceSegueId"]) {
        ExamChooseInsuranceTableViewController* vc = [[ExamChooseInsuranceTableViewController alloc] init];
        vc = segue.destinationViewController;
        vc.delegate = self;
    }
}

- (void)didMakeSelection:(NSString *)insuranceSelected{
    self.examInsuranceLabel.text = insuranceSelected;
    NSLog(insuranceSelected);
}
@end