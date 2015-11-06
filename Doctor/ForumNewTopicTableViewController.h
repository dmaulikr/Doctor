//
//  ForumNewTopicTableViewController.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/20/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForumNewTopicTableViewController : UITableViewController

@property (nonatomic, strong) IBOutlet UILabel* ownerLabel;
@property (nonatomic, strong) IBOutlet UITextField* subjectTextField;
@property (nonatomic, strong) IBOutlet UITextView* contentTextView;

@end
