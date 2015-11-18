//
//  PatientSelectedTreatmentTableViewCell.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 11/17/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatientSelectedTreatmentTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel* treatmentNameLabel;
@property (nonatomic, weak) IBOutlet UILabel* treatmentApplierLabel;

@end
