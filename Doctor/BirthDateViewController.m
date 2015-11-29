//
//  BirthDateViewController.m
//  Doctor
//
//  Created by Breno Ramos on 11/19/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "BirthDateViewController.h"

@interface BirthDateViewController ()

@end

@implementation BirthDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.birthDatePicker.datePickerMode = UIDatePickerModeDate;
    
   // self.view.layer.cornerRadius = 10.0;
   // self.view.layer.borderColor = self.mainColor.CGColor;
   // self.view.layer.borderWidth = 1.0;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    return self;
}

- (IBAction)okButton:(UIButton *)sender {
    
    self.pickedDate = self.birthDatePicker.date;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"datePicked!" object: self.pickedDate];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
