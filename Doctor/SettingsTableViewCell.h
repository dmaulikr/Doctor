//
//  SettingsTableViewCell.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 11/11/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton* seeAsAPatientButton;
@property (weak, nonatomic) IBOutlet UIButton* seeTutoButton;

@end
