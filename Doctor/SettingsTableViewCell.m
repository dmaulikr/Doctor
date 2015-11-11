//
//  SettingsTableViewCell.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 11/11/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "SettingsTableViewCell.h"

@implementation SettingsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.seeAsAPatientButton.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
