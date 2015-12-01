//
//  ExamChooseSpecialtyTableViewController.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 12/1/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ExamChooseSpecialtyTableViewControllerDelegate <NSObject>
- (void)didMakeSelectionSpecialty:(NSString *)specialtySelected;
@end

@interface ExamChooseSpecialtyTableViewController : UITableViewController
@property (nonatomic, weak) id<ExamChooseSpecialtyTableViewControllerDelegate> delegate;

@end
