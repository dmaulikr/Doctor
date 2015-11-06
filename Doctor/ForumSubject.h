//
//  ForumSubject.h
//  Doctor
//
//  Created by Breno Ramos on 11/4/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ForumHeader.h"

@interface ForumSubject : NSObject

@property (strong, nonatomic) NSString* forumSubjectObjectId;
@property (strong, nonatomic) NSString* forumSubjectTitle;
@property (strong, nonatomic) NSDate* forumSubjectCreatedAt;
@property (strong, nonatomic) NSDate* forumSubjectUpdatedAt;

@end
