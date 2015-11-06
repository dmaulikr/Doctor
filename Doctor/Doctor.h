//
//  Doctor.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/17/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Doctor : NSObject

@property (strong, nonatomic) NSString* doctorNameString;
@property (strong, nonatomic) NSString* doctorUsernameString;
@property (strong, nonatomic) NSString* doctorPasswordString;
@property (strong, nonatomic) NSString* doctorCRMString;
@property (strong, nonatomic) NSString* doctorEmailString;
@property (strong, nonatomic) NSString* doctorCelularString;

//In test
@property (strong, nonatomic) NSMutableArray* doctorPatientsArray;
@property (strong, nonatomic) NSString* doctorObjectId;
@property (strong,nonatomic) NSData* doctorPhotoData;

@end
