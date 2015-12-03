//
//  PatientNewExamTableViewController.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 11/28/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"
#import "Exam.h"

@protocol PatientNewExamTableViewControllerDelegate <NSObject>
- (void) newExamWasCreated;
@end

@interface PatientNewExamTableViewController : UITableViewController

@property (strong, nonatomic) Patient* patient;
@property (nonatomic, strong) id <PatientNewExamTableViewControllerDelegate> delegate;

@end
