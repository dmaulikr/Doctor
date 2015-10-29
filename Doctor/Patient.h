//
//  Patient.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/17/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Patient : NSObject

@property (strong, nonatomic) NSString* patientNameString;
@property (strong, nonatomic) NSString* patientBirthDateString;
@property (strong, nonatomic) NSString* patientRGString;
@property (strong, nonatomic) NSString* patientCPFString;
@property (strong, nonatomic) NSString* patientAgeString;
@property (strong, nonatomic) NSString* patientGenderString;
@property (strong, nonatomic) NSString* patientAdressString;
@property (strong, nonatomic) NSString* patientObjectId;
@property (strong, nonatomic) NSMutableArray* patientDoctors;

@end
