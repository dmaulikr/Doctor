//
//  Patient.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/17/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Patient : NSObject

@property (weak, nonatomic) NSString* patientNameString;
@property (weak, nonatomic) NSString* patientBirthDateString;
@property (weak, nonatomic) NSString* patientRGString;
@property (weak, nonatomic) NSString* patientCPFString;
@property (weak, nonatomic) NSString* patientAgeString;
@property (weak, nonatomic) NSString* patientGenderString;

@end
