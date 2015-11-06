//
//  ForumMessageSendTableViewCell.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 11/6/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ForumMessageSendTableViewCellDelegate <NSObject>

- (void) didTappedSendButtom:(NSString *)text;

@end

@interface ForumMessageSendTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UITextField* sendMessageTextField;
@property (nonatomic, strong) id <ForumMessageSendTableViewCellDelegate> delegate;

@end
