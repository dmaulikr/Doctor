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
    self.patientInitialsView.layer.cornerRadius = self.patientInitialsView.frame.size.height/2;
    self.patientInitialsView.layer.masksToBounds = YES;
    self.patientInitialsView.layer.borderWidth = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];    
//    UIView * selectedBackgroundView = [[UIView alloc] init];
//    [selectedBackgroundView setBackgroundColor:[UIColor orangeColor]]; // set color here
//    [self setSelectedBackgroundView:selectedBackgroundView];

}

@end
