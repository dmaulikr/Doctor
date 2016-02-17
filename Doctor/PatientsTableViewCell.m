#import "PatientsTableViewCell.h"

@implementation PatientsTableViewCell

- (void)awakeFromNib {
    self.patientInitialsView.layer.cornerRadius = self.patientInitialsView.frame.size.height/2;
    self.patientInitialsView.layer.masksToBounds = YES;
    self.patientInitialsView.layer.borderWidth = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
