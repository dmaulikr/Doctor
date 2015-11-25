//
//  SettingsTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/17/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "MFSideMenu.h"
#import "AppDelegate.h"
#import "SettingsHealthCareTableViewController.h"
#import "SettingsSpecialtiesTableViewController.h"
#import "SettingsChangePasswordTableViewController.h"
#import "Envio.h"

@interface SettingsTableViewController () <UIImagePickerControllerDelegate, UIActionSheetDelegate>{
    UIImagePickerController* imagePickerController;
}

@property (nonatomic, strong) Doctor* doctor;
@property (nonatomic, weak) IBOutlet UILabel* settingsNameLabel;
@property (nonatomic, weak) IBOutlet UILabel* settingsCellphoneLabel;
@property (nonatomic, weak) IBOutlet UILabel* settingsCRMLabel;
@property (nonatomic, weak) IBOutlet UILabel* settingsEmailLabel;
@property (nonatomic, weak) IBOutlet UILabel* settingsUserLabel;
@property (nonatomic, weak) IBOutlet UILabel* settingsPasswordLabel;
@property (nonatomic, weak) IBOutlet UILabel* settingsSpecialtiesLabel;
@property (nonatomic, weak) IBOutlet UILabel* settingsHealthCareLabel;
@property (nonatomic, weak) IBOutlet UITextView* settingsAddressTextView;
@property (nonatomic, weak) IBOutlet UITextView* settingsContactTextView;
@property (nonatomic, weak) IBOutlet UIImageView* settingsCameraImageView;

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDoctor];
    [self setupCamera];
    self.tableView.tableFooterView = [UIView new];
    self.settingsCameraImageView.layer.cornerRadius = self.settingsCameraImageView.frame.size.height/2;
    self.settingsCameraImageView.layer.masksToBounds = YES;
}

-(IBAction)didTappedMenuBarButton:(UIBarButtonItem *)sender{
   	[self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

- (void) setupDoctor{
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.doctor = appDelegate.doctor;
    self.settingsAddressTextView.text = self.doctor.doctorAddressString;
    self.settingsContactTextView.text = self.doctor.doctorContactString;
    self.settingsCRMLabel.text = self.doctor.doctorCRMString;
    self.settingsEmailLabel.text = self.doctor.doctorEmailString;
    self.settingsHealthCareLabel.text = @"Plano de saúde";
    self.settingsPasswordLabel.text = @"*********";
    self.settingsSpecialtiesLabel.text = @"Especialidades";
    self.settingsUserLabel.text = self.doctor.doctorUsernameString;
    self.settingsNameLabel.text = self.doctor.doctorNameString;
    self.settingsCellphoneLabel.text = self.doctor.doctorContactString;
    if (self.doctor.doctorPhotoData) self.settingsCameraImageView.image = [UIImage imageWithData:self.doctor.doctorPhotoData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 4:
            [self performSegueWithIdentifier:@"settingsChangePasswordSegue" sender:self];
            break;
        case 5:
            [self performSegueWithIdentifier:@"settingsSpecialtiesSegue" sender:self];
            break;
        case 6:
            [self performSegueWithIdentifier:@"settingsHealthCareSegue" sender:self];
            break;
        default:
            break;
    }
}

- (void) setupCamera{
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedCamera)];
    self.settingsCameraImageView.userInteractionEnabled = YES;
    [self.settingsCameraImageView addGestureRecognizer:tap];
    imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
}

- (void) didTappedCamera{
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Rolo da câmera", @"Tirar uma foto", nil];
    actionSheet.tag = 1;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(actionSheet.tag == 1) {
        switch (buttonIndex) {
            case 0:
                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentModalViewController:imagePickerController animated:YES];
                break;
            case 1:
                @try{
                    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                    [self presentModalViewController:imagePickerController animated:YES];
                }
                @catch (NSException *exception){
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sem câmera!" message:@"Algo ocorreu, e a câmera não está disponível." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
                break;
            default:
                break;
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    // UIImage* smallImage = [image scaleToSize:CGSizeMake(180,640)];
    // NSData* photoData = UIImagePNGRepresentation(smallImage);
    
    //  if (tookFromCamera) self.cameraImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    //  [self.cameraImageView setImage:smallImage];
    [self.settingsCameraImageView setImage:image];
    [self.settingsCameraImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"settingsChangePasswordSegue"]) {
        SettingsChangePasswordTableViewController* vc = segue.destinationViewController;
        AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
        [vc setDoctor:appDelegate.doctor];
    }
    else if ([segue.identifier isEqualToString:@"settingsSpecialtiesSegue"]){
        SettingsSpecialtiesTableViewController *vc = segue.destinationViewController;
        AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
        [vc setSpecialtiesArray:appDelegate.doctor.doctorSpecialtiesArray];
    }
    else if ([segue.identifier isEqualToString:@"settingsHealthCareSegue"]){
        SettingsHealthCareTableViewController* vc = segue.destinationViewController;
        AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
        [vc setHealthCareArray:appDelegate.doctor.doctorHealthCareArray];
    }
}

- (IBAction)didTappedToSaveButton:(id)sender{
    Envio* envio = [[Envio alloc] init];
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    Doctor* updatedDoc = [[Doctor alloc] init];
    updatedDoc.doctorContactString = self.settingsContactTextView.text;
    updatedDoc.doctorAddressString = self.settingsAddressTextView.text;
    updatedDoc.doctorUsernameString = appDelegate.doctor.doctorUsernameString;
    [envio updateDoctor:appDelegate.doctor.doctorObjectId withDoctor:updatedDoc withCompletion:^void(BOOL finished){
        NSString* message;
        if (finished) {
            message = @"As atualizações foram salvas com sucesso!";
            [self setupDoctor];
        }else{
            message = @"Algo deu errado, e suas atualizações não foram salvas";
        }
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Atenção" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

- (IBAction)didTappedToSeeTutorialButton:(id)sender{
    NSLog(@"Clicked to see tutorial");
}

- (IBAction)didTappedToSAAPButton:(id)sender{
    [self performSegueWithIdentifier:@"seeAsAPatientSegue" sender:self];
}

@end
