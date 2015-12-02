//
//  PatientSelectedExamSelectedTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/24/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "PatientSelectedExamSelectedTableViewController.h"

@interface PatientSelectedExamSelectedTableViewController (){
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

@implementation PatientSelectedExamSelectedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadPatientHeaderData];
    [self loadExamData];
    [self loadTapRecognizers];
    self.tableView.tableFooterView = [UIView new];
}

- (void) loadPatientHeaderData{
    self.patientNameLabel.text = self.patient.patientNameString;
    self.patientCameSinceLabel.text = self.patient.patientCameSinceString;
}

- (void) loadExamData{
    self.examDateLabel.text = self.exam.examDateString;
    self.examProtocolLabel.text = self.exam.examProtocolString;
    self.examDoctorAskedLabel.text = self.exam.doctorEnvolvedNameString;
    self.examInsuranceLabel.text = self.exam.examInsuranceString;
    
    if (self.exam.photoOneData) {
        hasFirstExam = true;
        self.firstExamCameraChangeImageView.hidden = NO;
        self.firstExamEmptyCameraImageView.hidden = YES;
        self.firstExamImageView.image = [UIImage imageWithData:self.exam.photoOneData];
    } else {
        hasFirstExam = false;
    }
    
    if (self.exam.photoTwoData){
        hasSecondExam = true;
        self.secondExamCameraChangeImageView.hidden = NO;
        self.secondExamEmptyCameraImageView.hidden = YES;
        self.secondExamImageView.image = [UIImage imageWithData:self.exam.photoTwoData];
    } else {
        hasSecondExam = false;
    }
    
    if (self.exam.photoThirdData){
        hasThirdExam = true;
        self.thirdExamCameraChangeImageView.hidden = NO;
        self.thirdExamEmptyCameraImageView.hidden = YES;
        self.thirdExamImageView.image = [UIImage imageWithData:self.exam.photoThirdData];
    } else {
        hasThirdExam = false;
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
            return 10;
            break;
        case 6:
            return hasFirstExam ? 361 : 50;
            break;
        case 7:
            return 10;
            break;
        case 8:
            return hasSecondExam ? 361 : 50;
            break;
        case 9:
            return 10;
            break;
        case 10:
            return hasThirdExam ? 361 : 50;
            break;
        default:
            return 10;
            break;
    }
}

- (void) didTappedFirstCameraChange{
    UIActionSheet* action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Usar rolo da câmera", @"Tirar uma foto", @"Salvar", nil];
    [action showInView:self.view];
}
- (void) didTappedFirstEmptyCamera{
    UIActionSheet* action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Usar rolo da câmera", @"Tirar uma foto", nil];
    [action showInView:self.view];
}
- (void) didTappedFirstExam{

}
- (void) didTappedSecondCameraChange{
    UIActionSheet* action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Usar rolo da câmera", @"Tirar uma foto", @"Salvar", nil];
    [action showInView:self.view];
}
- (void) didTappedSecondEmptyCamera{
    UIActionSheet* action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Usar rolo da câmera", @"Tirar uma foto", nil];
    [action showInView:self.view];
}
- (void) didTappedSecondExam{

}
- (void) didTappedThirdCameraChange{
    UIActionSheet* action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Usar rolo da câmera", @"Tirar uma foto", @"Salvar", nil];
    [action showInView:self.view];
}
- (void) didTappedThirdEmptyCamera{
    UIActionSheet* action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Usar rolo da câmera", @"Tirar uma foto", nil];
    [action showInView:self.view];
}
- (void) didTappedThirdExam{
    
}


@end