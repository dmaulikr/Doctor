//
//  ModelMessageForum.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/27/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelTopicForum.h"

@interface ModelMessageForum : NSObject

@property (strong, nonatomic) NSString* messageForumCreatedBy;
@property (strong, nonatomic) NSString* messageForumContent;
@property (strong, nonatomic) ModelTopicForum* messageForumTopic;
@property (strong, nonatomic) NSString* messageForumCreatedAt;

@end
