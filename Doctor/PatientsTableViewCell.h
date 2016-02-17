#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface PatientsTableViewCell : SWTableViewCell

@property (weak, nonatomic) IBOutlet UIView* patientInitialsView;
@property (weak, nonatomic) IBOutlet UILabel* patientInitialsLabel;

@property (weak, nonatomic) IBOutlet UILabel* patientNameLabel;
@property (weak, nonatomic) IBOutlet UILabel* patientGenderLabel;
@property (weak, nonatomic) IBOutlet UILabel* patientCameSinceLabel;
@property (weak, nonatomic) IBOutlet UILabel* patientAgeLabel;

@property (weak, nonatomic) IBOutlet UIImageView* patientPhotoImageView;

@end
