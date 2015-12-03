//
//  PatientSelectedExamsTableViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/24/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "PatientSelectedExamsTableViewController.h"
#import "PatientSelectedExamTableViewCell.h"
#import "PatientSelectedExamSelectedTableViewController.h"
#import "PatientNewExamTableViewController.h"
#import "Envio.h"

@interface PatientSelectedExamsTableViewController () <PatientNewExamTableViewControllerDelegate>{
    NSMutableArray* tableViewDataArray;
    UIActivityIndicatorView* spinner;
    Exam* examSelected;
}

@property (nonatomic, weak) IBOutlet UILabel* patientNameLabel;
@property (nonatomic, weak) IBOutlet UILabel* patientCameSinceLabel;
@property (nonatomic, weak) IBOutlet UIImageView* patientImageView;

@end

@implementation PatientSelectedExamsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLoadingAnimation];
    self.patientCameSinceLabel.numberOfLines = 0;
    [self setupExamsDataSource];
    self.tableView.tableFooterView = [UIView new];
    if (self.patient.patientPhotoData) {
        self.patientImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.patientImageView.layer.cornerRadius = self.patientImageView.frame.size.height/2;
        self.patientImageView.layer.masksToBounds = YES;
        self.patientImageView.image = [UIImage imageWithData:self.patient.patientPhotoData];
    }
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    examSelected = [[Exam alloc] init];
    examSelected = tableViewDataArray[indexPath.row];
    [self performSegueWithIdentifier:@"examSelectedSegueId" sender:self];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableViewDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        NSString* cellIdentifier = @"examsCellID";
        
        PatientSelectedExamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell==nil) {
            cell = [[PatientSelectedExamTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        Exam* exam = [[Exam alloc] init];
        exam = tableViewDataArray[indexPath.row];
        cell.examTypeLabel.text = exam.examTypeString;
        cell.examDescriptionLabel.text = exam.examDescriptionString;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 61;
}

#pragma mark - Setups
- (void) setupExamsDataSource {
    self.patientNameLabel.text = self.patient.patientNameString;
    self.patientCameSinceLabel.text = self.patient.patientCameSinceString;
    //self.patientImageView.image = self.patient.patientImage;
    
    tableViewDataArray = [[NSMutableArray alloc] init];
    Envio* newEnvio = [[Envio alloc]init];
    [newEnvio fetchExamsPassingPatient:self.patient withCompletion: ^void (NSMutableArray* examsArray){
        if (examsArray){
            tableViewDataArray = examsArray;
            [self.tableView reloadData];
            [spinner stopAnimating];
        }else{
            NSLog(@"Erro - setupExamsDataSource block");
        }
        if (tableViewDataArray.count == 0) {
            UIAlertView* empty = [[UIAlertView alloc] initWithTitle:@"Atenção" message:@"Ainda não há exames para este paciente." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [empty show];
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

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"examSelectedSegueId"]) {
        PatientSelectedExamSelectedTableViewController* vc = segue.destinationViewController;
        [vc setPatient:self.patient];
        [vc setExam:examSelected];
    }
    else if ([segue.identifier isEqualToString:@"newExamSegueId"]){
        PatientNewExamTableViewController* vc = [[PatientNewExamTableViewController alloc] init];
        vc = segue.destinationViewController;
        vc.delegate = self;
        [vc setPatient:self.patient];
    }
}
- (IBAction)didTappedForCreateExam:(id)sender{
    [self performSegueWithIdentifier:@"newExamSegueId" sender:self];
}

- (void)newExamWasCreated{
    [self setupLoadingAnimation];
    self.patientCameSinceLabel.numberOfLines = 0;
    [self setupExamsDataSource];
    self.tableView.tableFooterView = [UIView new];
    if (self.patient.patientPhotoData) {
        self.patientImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.patientImageView.layer.cornerRadius = self.patientImageView.frame.size.height/2;
        self.patientImageView.layer.masksToBounds = YES;
        self.patientImageView.image = [UIImage imageWithData:self.patient.patientPhotoData];
    }
}

@end