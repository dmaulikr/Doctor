//
//  Diagnosis.h
//  Doctor
//
//  Created by Breno Ramos on 10/19/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Diagnosis : NSObject

@property (weak,nonatomic) NSDate* confirmedAt;
@property (weak,nonatomic) NSNumber* status;
@property (weak,nonatomic) NSString* description;
@property (weak,nonatomic) NSDate* createdAt;

@end
