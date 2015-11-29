//
//  PatientSelectedEditTableViewController.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/24/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"

@protocol PatientSelectedEditTableViewControllerDelegate <NSObject>

- (void) askedForRefresh:(Patient *)patientUpdated;

@end
@interface PatientSelectedEditTableViewController : UITableViewController

@property (strong, nonatomic) Patient* patient;
@property (strong, nonatomic) id <PatientSelectedEditTableViewControllerDelegate> delegate;

@end
