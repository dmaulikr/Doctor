//
//  PatientSelectedDataTableViewController.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/24/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"

@protocol PatientSelectedDataTableViewControllerDelegate <NSObject>

- (void) askedForRefresh:(Patient *)patientUpdated;

@end

@interface PatientSelectedDataTableViewController : UITableViewController

@property (strong, nonatomic) Patient* patient;
@property (nonatomic, strong) id <PatientSelectedDataTableViewControllerDelegate> delegate;

@end
