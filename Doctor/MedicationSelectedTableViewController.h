//
//  MedicationSelectedTableViewController.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/24/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Medication.h"

@interface MedicationSelectedTableViewController : UITableViewController

@property (nonatomic, strong) Medication* medication;

@end
