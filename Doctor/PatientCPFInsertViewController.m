//
//  PatientCPFInsertViewController.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 12/14/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "PatientCPFInsertViewController.h"
#import "JCDialPad.h"
#import "MFSideMenu.h"

@interface PatientCPFInsertViewController () <JCDialPadDelegate>

@property (nonatomic) IBOutlet UIView* viewTeste;

@end

@implementation PatientCPFInsertViewController

- (void) viewDidLoad{
    JCDialPad *pad = [[JCDialPad alloc] initWithFrame:self.viewTeste.bounds];
    pad.buttons = [JCDialPad defaultButtons];
    pad.delegate = self;
    [self.viewTeste addSubview:pad];
}

-(IBAction)didTappedMenuBarButton:(UIBarButtonItem *)sender{
    [self.view endEditing:YES];
   	[self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

@end
