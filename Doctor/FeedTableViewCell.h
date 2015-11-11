//
//  FeedTableViewCell.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 11/10/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView* sectionImageView;
@property (nonatomic, strong) IBOutlet UILabel* sectionLabel;

@end
