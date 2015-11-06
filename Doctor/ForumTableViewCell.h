//
//  ForumTableViewCell.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/27/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface ForumTableViewCell : SWTableViewCell

@property (nonatomic, strong) IBOutlet UILabel *topicOwner;
@property (nonatomic, strong) IBOutlet UILabel *topicSubject;
@property (nonatomic, strong) IBOutlet UILabel *topicDate;
@property (nonatomic, strong) IBOutlet UITextView *topicSinopse;

@end
