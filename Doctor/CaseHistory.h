//
//  CaseHistory.h
//  Doctor
//
//  Created by Breno Ramos on 10/19/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaseHistory : NSObject

@property (weak,nonatomic) NSString* caseHistoryDescription;
@property (weak,nonatomic) NSDate* caseHistoryPhoto;
@property (strong, nonatomic) NSMutableArray* caseHistoryVersionHistory;
@property (strong, nonatomic) NSMutableArray* caseHistoryUpdatedAt;


@end
