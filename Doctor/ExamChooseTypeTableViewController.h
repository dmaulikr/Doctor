//
//  ExamChooseTypeTableViewController.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 12/3/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ExamChooseTypeTableViewControllerDelegate <NSObject>
- (void) didMakeSelectionExamType:(NSString *)typeSelected;
@end

@interface ExamChooseTypeTableViewController : UITableViewController
@property (nonatomic, weak) id <ExamChooseTypeTableViewControllerDelegate> delegate;
@end
