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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)okButton:(UIButton *)sender {
    
    self.pickedDate = self.birthDatePicker.date;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"datePicked!" object: self.pickedDate];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
