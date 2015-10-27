//
//  VersionHistory.h
//  Doctor
//
//  Created by Breno Ramos on 10/27/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Patient.h"
#import "Register.h"
#import "Appointment.h"
#import "Treatment.h"
#import "Diagnosis.h"
#import "Doctor.h"
#import "Exam.h"
#import "CaseHistory.h"
#import "Envio.h"

@interface VersionHistory : NSObject

- (void) updateVersion: (id)oldVersion
        withNewVersion: (id)newVersion;

@end
