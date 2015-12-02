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
#import "Envio.h"

@interface PatientNewExamTableViewController () <ExamChooseInsuranceTableViewControllerDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate> {
    BOOL hasFirstExam;
    BOOL hasSecondExam;
    BOOL hasThirdExam;
    UIImagePickerController* imagePickerController;
}

@property (nonatomic, weak) IBOutlet UILabel* patientNameLabel;
@property (nonatomic, weak) IBOutlet UILabel* patientCameSinceLabel;
@property (nonatomic, weak) IBOutlet UIImageView* patientImageView;

@property (nonatomic, weak) IBOutlet UILabel* examDateLabel;
@property (nonatomic, weak) IBOutlet UILabel* examProtocolLabel;
@property (nonatomic, weak) IBOutlet UILabel* examDoctorAskedLabel;
@property (nonatomic, weak) IBOutlet UILabel* examInsuranceLabel;

@property (nonatomic, weak) IBOutlet UITextField* examType;
@property (nonatomic, weak) IBOutlet UITextField* examDescription;

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
    imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
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
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    actionSheet.tag = 11;
    [actionSheet addButtonWithTitle:@"Apagar registro"];
    [actionSheet addButtonWithTitle:@"Usar rolo da câmera"];
    [actionSheet addButtonWithTitle:@"Tirar uma foto"];
    [actionSheet showInView:self.view];
}
- (void) didTappedFirstEmptyCamera{
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    actionSheet.tag = 12;
    [actionSheet addButtonWithTitle:@"Usar rolo da câmera"];
    [actionSheet addButtonWithTitle:@"Tirar uma foto"];
    [actionSheet showInView:self.view];
}
- (void) didTappedFirstExam{
//    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
//    actionSheet.tag = 13;
//    [actionSheet showInView:self.view];
}
- (void) didTappedSecondCameraChange{
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    actionSheet.tag =21;
    [actionSheet addButtonWithTitle:@"Apagar registro"];
    [actionSheet addButtonWithTitle:@"Usar rolo da câmera"];
    [actionSheet addButtonWithTitle:@"Tirar uma foto"];
    [actionSheet showInView:self.view];
}
- (void) didTappedSecondEmptyCamera{
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    actionSheet.tag = 22;
    [actionSheet addButtonWithTitle:@"Usar rolo da câmera"];
    [actionSheet addButtonWithTitle:@"Tirar uma foto"];
    [actionSheet showInView:self.view];
}
- (void) didTappedSecondExam{
//    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
//    actionSheet.tag = 23;
//    [actionSheet showInView:self.view];
}
- (void) didTappedThirdCameraChange{
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    actionSheet.tag = 31;
    [actionSheet addButtonWithTitle:@"Apagar registro"];
    [actionSheet addButtonWithTitle:@"Usar rolo da câmera"];
    [actionSheet addButtonWithTitle:@"Tirar uma foto"];
    [actionSheet showInView:self.view];
}
- (void) didTappedThirdEmptyCamera{
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    actionSheet.tag = 32;
    [actionSheet addButtonWithTitle:@"Usar rolo da câmera"];
    [actionSheet addButtonWithTitle:@"Tirar uma foto"];
    [actionSheet showInView:self.view];
}
- (void) didTappedThirdExam{
//    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
//    actionSheet.tag = 33;
//    [actionSheet showInView:self.view];
}

- (NSString *) getCurrentTimeAndDate{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy hh:mm"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

- (IBAction)didTappedToSaveExam:(id)sender{
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    Envio* envio = [[Envio alloc] init];
    Exam* exam = [[Exam alloc] init];
    exam.examApplicant = appDelegate.doctor;
    exam.examProtocolString = self.examProtocolLabel.text;
    exam.examPatient = self.patient;
    exam.examTypeString = self.examType.text;
    exam.examDescriptionString = self.examDescription.text;
    exam.examInsuranceString = self.examInsuranceLabel.text;
    exam.examDateString = self.examDateLabel.text;
    if (hasFirstExam) {
        NSData* photoData = UIImagePNGRepresentation(self.firstExamImageView.image);
        exam.photoOneData = photoData;
    }
    if (hasSecondExam) {
        NSData* photoData = UIImagePNGRepresentation(self.secondExamImageView.image);
        exam.photoTwoData = photoData;
    }
    if (hasThirdExam) {
        NSData* photoData = UIImagePNGRepresentation(self.thirdExamImageView.image);
        exam.photoThirdData = photoData;
    }
    
    [envio newExam:exam withCompletion:^void(BOOL * succeeded){
        if (succeeded) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Atenção" message:@"O exame foi salvo com sucesso" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Atenção" message:@"Ocorreu algum problema e o exame não foi salvo" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
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
}

- (void)actionSheet:(UIActionSheet *)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (actionSheet.tag) {
        case 11:
            switch (buttonIndex) {
                case 1:
                    break;
                case 2:
                    [self openCameraBasedOnExamNumber:1];
                    break;
                case 3:
                    [self openPhotosBasedOnExamNumber:1];
                    break;
                default:
                    break;
            }
            break;
        case 12:
            switch (buttonIndex) {
                case 1:
                    [self openCameraBasedOnExamNumber:1];
                    break;
                case 2:
                    [self openPhotosBasedOnExamNumber:1];
                    break;
                default:
                    break;
            }
            
            break;
        case 13:
            switch (buttonIndex) {
                case 1:
                    
                    break;
                case 2:
                    break;
                default:
                    break;
            }
            
            break;
        case 21:
            switch (buttonIndex) {
                case 1:
                    
                    break;
                case 2:
                    
                    [self openCameraBasedOnExamNumber:2];
                    break;
                case 3:
                    [self openPhotosBasedOnExamNumber:2];
                    break;
                    
                default:
                    break;
            }
            
            break;
        case 22:
            switch (buttonIndex) {
                case 1:
                    
                    [self openCameraBasedOnExamNumber:2];
                    break;
                case 2:
                    [self openPhotosBasedOnExamNumber:2];
                    break;
                default:
                    break;
            }
            
            break;
        case 23:
            switch (buttonIndex) {
                case 1:
                    
                    break;
                case 2:
                    break;
                default:
                    break;
            }
            
            break;
        case 31:
            switch (buttonIndex) {
                case 1:
                    
                    break;
                case 2:
                    [self openCameraBasedOnExamNumber:3];
                    break;
                case 3:
                    [self openPhotosBasedOnExamNumber:3];
                    break;
                    
                default:
                    break;
            }
            
            break;
        case 32:
            switch (buttonIndex) {
                case 1:
                    
                    [self openCameraBasedOnExamNumber:3];
                    break;
                case 2:
                    [self openPhotosBasedOnExamNumber:3];
                    break;
                default:
                    break;
            }
            
            break;
        case 33:
            switch (buttonIndex) {
                case 1:
                    
                    break;
                case 2:
                    break;
                default:
                    break;
            }
            
            break;
            
        default:
            break;
    }
}

- (void) openCameraBasedOnExamNumber:(NSInteger *)examNumber{
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentModalViewController:imagePickerController animated:YES];
    
}

- (void) openPhotosBasedOnExamNumber:(NSInteger *)examNumber{
    @try{
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentModalViewController:imagePickerController animated:YES];
    }
    @catch (NSException *exception){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sem câmera!" message:@"Algo ocorreu, e a câmera não está disponível." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    // UIImage* smallImage = [image scaleToSize:CGSizeMake(180,640)];
    // NSData* photoData = UIImagePNGRepresentation(smallImage);
    
    //self.cameraImageView.layer.cornerRadius = self.cameraImageView.frame.size.height/2;
   // self.cameraImageView.layer.masksToBounds = YES;
    
    //  if (tookFromCamera) self.cameraImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    //  [self.cameraImageView setImage:smallImage];
   // [self.cameraImageView setImage:image];
   // [self.cameraImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end