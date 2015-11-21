//
//  ForumSeeTopicTableViewController.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/20/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForumTopic.h"
#import "Doctor.h"

@interface ForumSeeTopicTableViewController : UITableViewController

@property (nonatomic, strong) ForumTopic* forumTopic;
@property (nonatomic, strong) Doctor* doctor;
@property (nonatomic, strong) IBOutlet UIView* dropdowButtonView;

@end
