//
//  PatientsTableViewCell.m
//  Doctor
//
//  Created by Breno Ramos on 10/15/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "PatientsTableViewCell.h"

@implementation PatientsTableViewCell

- (void)awakeFromNib {
    self.patientPhotoImageView.layer.cornerRadius = self.patientPhotoImageView.frame.size.height /3;
    self.patientPhotoImageView.layer.masksToBounds = YES;
    self.patientPhotoImageView.layer.borderWidth = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
    UIView * selectedBackgroundView = [[UIView alloc] init];
    [selectedBackgroundView setBackgroundColor:[UIColor orangeColor]]; // set color here
    [self setSelectedBackgroundView:selectedBackgroundView];

}

@end
