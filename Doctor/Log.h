//
//  Log.h
//  Doctor
//
//  Created by Breno Ramos on 11/3/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LogActivity.h"


@interface Log : NSObject

@property (weak, nonatomic) NSString* logRegisteredBy;
@property (weak, nonatomic) NSString* logActivityType;
@property (weak, nonatomic) NSString* logActivityRegister;
@property (weak, nonatomic) NSArray* logPatientsEnvolved;
@property (weak, nonatomic) NSString* logCreatedAt;

@end
