//
//  BirthDateViewController.h
//  Doctor
//
//  Created by Breno Ramos on 11/19/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BirthDateViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIDatePicker *birthDatePicker;

- (IBAction)okButton:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIView *datePickerView;

@property (strong, nonatomic) NSDate* pickedDate;

@end
