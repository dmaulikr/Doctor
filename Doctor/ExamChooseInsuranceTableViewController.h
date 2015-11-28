//
//  ExamChooseInsuranceTableViewController.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 11/28/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ExamChooseInsuranceTableViewControllerDelegate <NSObject>
- (void)didMakeSelection:(NSString *)insuranceSelected;
@end

@interface ExamChooseInsuranceTableViewController : UITableViewController

@property (nonatomic, weak) id<ExamChooseInsuranceTableViewControllerDelegate> delegate;

@end
