//
//  ModelTopicForum.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/27/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelTopicForum : NSObject

@property (strong, nonatomic) NSString* topicForumTheme;
@property (strong, nonatomic) NSString* topicForumDescription;
@property (strong, nonatomic) NSString* topicForumCreatedBy;
@property (strong, nonatomic) NSString* topicForumUpdatedAt;
@property (strong, nonatomic) NSString* topicForumContentPreview;

@end
