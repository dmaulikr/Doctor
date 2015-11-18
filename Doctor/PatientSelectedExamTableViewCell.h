//
//  PatientSelectedExamTableViewCell.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 11/17/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatientSelectedExamTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel* examTypeLabel;
@property (nonatomic, weak) IBOutlet UILabel* examDescriptionLabel;

@end
