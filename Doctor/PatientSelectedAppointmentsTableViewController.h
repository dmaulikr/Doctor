//
//  PatientSelectedAppointmentsTableViewController.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/24/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"

@interface PatientSelectedAppointmentsTableViewController : UITableViewController

@property (strong, nonatomic) Patient* patient;

@end
