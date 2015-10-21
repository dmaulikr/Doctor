//
//  PatientSelectedTableViewController.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/20/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"

@interface PatientSelectedTableViewController : UITableViewController

@property (nonatomic, strong) Patient* patient;

@end
