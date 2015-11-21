//
//  PatientsTableViewCell.h
//  Doctor
//
//  Created by Breno Ramos on 10/15/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

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
