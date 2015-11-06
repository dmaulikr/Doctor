//
//  ForumTableViewController.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/20/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForumHeader.h"
#import "Doctor.h"

@interface ForumTableViewController : UITableViewController
@property (nonatomic, strong) Doctor* doctor;
@end
