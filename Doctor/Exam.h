//
//  Exam.h
//  Doctor
//
//  Created by Breno Ramos on 10/19/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Exam : NSObject

@property (weak,nonatomic) NSString* tipo;
@property (weak,nonatomic) NSString* description;
@property (weak,nonatomic) NSData* photo;


@end
