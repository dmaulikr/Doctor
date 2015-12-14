//
//  PatientCPFInsertViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 12/14/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "PatientCPFInsertViewController.h"
#import "JCDialPad.h"

@interface PatientCPFInsertViewController () <JCDialPadDelegate>

@end

@implementation PatientCPFInsertViewController

- (void) viewDidLoad{
    JCDialPad *pad = [[JCDialPad alloc] initWithFrame:self.view.bounds];
    pad.buttons = [JCDialPad defaultButtons];
    pad.delegate = self;
    [self.view addSubview:pad];
}

@end
