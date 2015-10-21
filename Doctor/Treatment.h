//
//  Treatment.h
//  Doctor
//
//  Created by Breno Ramos on 10/19/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Treatment : NSObject

@property (weak,nonatomic) NSString* description;
@property (weak,nonatomic) NSNumber* duration;
@property (weak,nonatomic) NSNumber* status;
@property (weak,nonatomic) NSDate* finishedAt;

@end
