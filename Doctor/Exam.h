//
//  Exam.h
//  Doctor
//
//  Created by Breno Ramos on 10/19/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Exam : NSObject

@property (weak,nonatomic) NSString* examType;
@property (weak,nonatomic) NSString* examDescription;
@property (weak,nonatomic) NSData* examPhoto;
@property (strong, nonatomic) NSMutableArray* examVersionHistory;
@property (strong, nonatomic) NSDate* examUpdatedAt;
@property (strong, nonatomic) NSString* examObjectId;





@end
