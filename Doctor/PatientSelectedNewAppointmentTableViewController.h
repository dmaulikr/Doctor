//
//  PatientSelectedNewAppointmentTableViewController.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 11/26/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"

@interface PatientSelectedNewAppointmentTableViewController : UITableViewController

@property (nonatomic, strong) Patient* patient;

@end
