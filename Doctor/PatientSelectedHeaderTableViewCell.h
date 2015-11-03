//
//  PatientSelectedHeaderTableViewCell.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 11/2/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatientSelectedHeaderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView* headerSectionSelectedImageView;
@property (weak, nonatomic) IBOutlet UILabel* patientNameLabel;
@property (weak, nonatomic) IBOutlet UILabel* lastSeenLabel;

@end
