//
//  ForumMessageTableViewCell.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/27/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForumMessageTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *messageOwner;
@property (nonatomic, strong) IBOutlet UILabel *messageDate;
@property (nonatomic, strong) IBOutlet UITextView *messageContent;

@end
