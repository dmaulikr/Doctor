//
//  Envio.m
//  Doctor
//
//  Created by Breno Ramos on 10/19/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "Envio.h"

@implementation Envio

#pragma mark newDoctor

- (void) newDoctor: (Doctor*)doctor;
{
    PFUser *user = [PFUser user];
    user.username = doctor.doctorUsernameString;
    user.password = doctor.doctorPasswordString;
    user.email = doctor.doctorEmailString;
    user[@"CRM"] = doctor.doctorCRMString;
    user[@"celular"] = doctor.doctorCelularString;
    user[@"patients"] = doctor.doctorPatientsArray;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        //Show error message somewhere and let the user try again
        if (!error) {
            NSLog(@"Signed UP - OK!");
            //Deal with it on a new method;
        } else {
            NSString *errorString = [error userInfo][@"error"];// Show the errorString somewhere and let the user try again.
            NSLog(@"%@", errorString);
            //Deal with it on a new method;
        }
    }];
    
    
}

#pragma mark newPatient

- (void) newPatient:(Patient*)patient {
    
    PFObject* newPatient = [PFObject objectWithClassName:@"Patient"];
    newPatient[@"name"] = patient.patientNameString;
    newPatient[@"CPF"] = patient.patientCPFString;
    newPatient[@"RG"] = patient.patientRGString;
    newPatient[@"age"] = patient.patientAgeString;
    newPatient[@"address"] = patient.patientAdressString;
    newPatient[@"gender"] = patient.patientGenderString;
    
    
    
    [newPatient saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            
        } else {
            // There was a problem, check error.description
        }
    }];
    
    
}

#pragma mark Registers

#pragma mark newDiagnosis
- (void) newDiagnosis: (Diagnosis*)diagnosis
{
    PFObject* newDiagnosis  = [PFObject objectWithClassName:@"Register"];
    newDiagnosis[@"confirmedAt"] = diagnosis.diagnosisConfirmedAt;
    newDiagnosis[@"status"] = diagnosis.diagnosisStatus;
    newDiagnosis[@"description"] = diagnosis.diagnosisDescription;
    newDiagnosis[@"versionHistory"] = diagnosis.diagnosisVersionHistory;
    
    
    [newDiagnosis saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            
        } else {
            // There was a problem, check error.description
        }
    }];

}

#pragma mark newTreatment
- (void) newTreatment: (Treatment*)treatment
{
    PFObject* newTreatment  = [PFObject objectWithClassName:@"Treatment"];
    newTreatment[@"description"] = treatment.treatmentDescription;
    newTreatment[@"duration"] = treatment.treatmentDuration;
    newTreatment[@"status"] = treatment.treatmentStatus; //NSNumber numberWithBool: method, with YES or NO
    newTreatment[@"finishedAt"] = treatment.treatementFinishedAt;
    
    
    [newTreatment saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            
        } else {
            // There was a problem, check error.description
        }
    }];

}

#pragma mark newExam
- (void) newExam: (Exam*)exam
{
    PFObject* newExam  = [PFObject objectWithClassName:@"Exam"];
    newExam[@"type"] = exam.examType;
    newExam[@"description"] = exam.examDescription;
    //Create a PFFile to store a photo
    newExam[@"photo"] = exam.examPhoto;
    
    
    [newExam saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            
        } else {
            // There was a problem, check error.description
        }
    }];

}

#pragma mark newCaseHistory
- (void) newCaseHistory: (CaseHistory*)caseHistory
{
    PFObject* newCaseHistory  = [PFObject objectWithClassName:@"Register"];
    newCaseHistory[@"description"] = caseHistory.caseHistoryDescription;
    //Create PFFile
    newCaseHistory[@"photo"] = caseHistory.caseHistoryPhoto;
    
    
    
    [newCaseHistory saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            
        } else {
            // There was a problem, check error.description
        }
    }];
}

#pragma mark newAppointment

- (void) newAppointment: (Doctor*)doctor;
{
    PFObject* newAppointment = [PFObject objectWithClassName:@"Patient"];
    newAppointment[@"doctor"] = doctor;
    
    [newAppointment saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            
        } else {
            // There was a problem, check error.description
        }
    }];
    
}

#pragma mark Queries
#pragma mark Sign In
- (void)signIn: (NSString*)username
  withPassword: (NSString*)password
{
//    PFUser* user = [[PFUser alloc]init];
//    user.password = enteredPassword;
//    user.username = enteredUsername;
//    
//    [user logInWithUsername: user.username password: user.password block: ^(PFUser* user, NSError* error){
//        if (!error){
//            NSLog(@"Doctor: %@ logged with success!", user.username);
//            //perform the segue
//        }else{
//            NSLog(@"Login failed due: %@", error.description);
//        }
//        
//    }];

}

#pragma mark fetchPatient
- (void)fetchPatient: (NSString*)CPF
      withCompletion:(void (^)(Patient* patient))completion;{
    
        PFQuery *query = [PFQuery queryWithClassName:@"Patient"];
        [query whereKey:@"CPF" equalTo:CPF];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d patients.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                
                Patient* patient = [[Patient alloc]init];
                patient.patientNameString = [object objectForKey:@"name"];
                patient.patientCPFString = [object objectForKey:@"CPF"];
                patient.patientAgeString = [object objectForKey:@"age"];
                patient.patientRGString = [object objectForKey:@"RG"];
                patient.patientDoctors = [object objectForKey:@"doctors"];
                patient.patientObjectId = [object objectForKey:@"objectId"];
                
                if (patient) {
                    completion(patient);
                }else{
                    completion(nil);
                    NSLog(@"404 - Envio.m - fetchPatient");
                }
            }
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)fetchAllPatients: (void (^)(Patient* patient))completion
{
    NSMutableArray* patients = [[NSMutableArray alloc]init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Patient"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d patients.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                
                Patient* patient = [[Patient alloc]init];
                patient.patientNameString = [object objectForKey:@"name"];
                patient.patientCPFString = [object objectForKey:@"CPF"];
                patient.patientAgeString = [object objectForKey:@"age"];
                patient.patientRGString = [object objectForKey:@"RG"];
                patient.patientGenderString = [object objectForKey:@"gender"];
                
                [patients addObject:patient];
                
                if (patient) {
                    completion(patient);
                }else{
                    completion(nil);
                    NSLog(@"404 - Envio.m - fetchAllPatients");
                }
            }
            

        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)fetchAllMedications:(void (^)(Medication *))completion{
    NSMutableArray* medications = [[NSMutableArray alloc]init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Medication"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d medications.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object[@"category"]);
                
                Medication* medication = [[Medication alloc]init];
                medication.medicationCategoryString = [object objectForKey:@"category"];
                medication.medicationActivePrincipleString = [object objectForKey:@"activeprinciples"];
                
                [medications addObject:medication];
                
                if (medication) {
                    completion(medication);
                }else{
                    completion(nil);
                    NSLog(@"404 - Envio.m - fetchAllMedications");
                }
            }
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}




#pragma mark fetchDoctor

- (void)fetchDoctor: (NSString*)CRM
      withCompletion:(void (^)(Doctor* doctor))completion{
    
    PFQuery *query = [PFQuery queryWithClassName:@"Doctor"];
    [query whereKey:@"CRM" equalTo:CRM];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d patients.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                
                Doctor* doctor = [[Doctor alloc]init];
                doctor.doctorCelularString = [object objectForKey:@"celular"];
                doctor.doctorCRMString = [object objectForKey:@"CRM"];
                doctor.doctorEmailString = [object objectForKey:@"email"];
                doctor.doctorNameString = [object objectForKey:@"name"];
                doctor.doctorPasswordString = [object objectForKey:@"password"];
                doctor.doctorUsernameString = [object objectForKey:@"username"];
                doctor.doctorObjectId = [object objectForKey:@"objectId"];

                if (doctor) {
                    completion(doctor);
                }else{
                    completion(nil);
                    NSLog(@"404 - Envio.m - fetchDoctor");
                }
            }
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}



#pragma mark fetchAppointment
- (void)fetchAppointment: (Doctor*)doctor
               createdAt: (NSDate*)createdAt
          withCompletion:(void (^)(Appointment* appointment))completion;{
    
    Appointment* appointment;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Appointment"];
    [query whereKey:@"createdAt" equalTo:createdAt];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d patients.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                appointment.appointmentDoctor = [object objectForKey:@"doctor"];
                appointment.appointmentCreatedAt = [object objectForKey:@"createdAt"];
                appointment.appointmentDiagnosis = [object objectForKey:@"diagnosis"];
                appointment.appointmentPatient = [object objectForKey:@"patient"];
                appointment.appointmentTreatment = [object objectForKey:@"treatment"];
                appointment.appointmentCaseHistory = [object objectForKey:@"caseHistory"];
                appointment.appointmentObjectId = [object objectForKey:@"objectId"];
                appointment.appointmentExams = [object objectForKey:@"exams"];
            
                if (appointment) {
                    completion(appointment);
                }else{
                    completion(nil);
                    NSLog(@"404 - Envio.m - fetchAppointment");
                }
            }
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)fetchAllAppointments: (void (^)(Appointment* appointment))completion
{
    Appointment* appointment;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Appointment"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d patients.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                appointment.appointmentDoctor = [object objectForKey:@"doctor"];
                appointment.appointmentCreatedAt = [object objectForKey:@"createdAt"];
                appointment.appointmentDiagnosis = [object objectForKey:@"diagnosis"];
                appointment.appointmentPatient = [object objectForKey:@"patient"];
                appointment.appointmentTreatment = [object objectForKey:@"treatment"];
                appointment.appointmentCaseHistory = [object objectForKey:@"caseHistory"];
                appointment.appointmentObjectId = [object objectForKey:@"objectId"];
                appointment.appointmentExams = [object objectForKey:@"exams"];
            }
            if (appointment) {
                completion(appointment);
            }else{
                completion(nil);
                NSLog(@"404 - Envio.m - fetchAllAppointments");
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}

#pragma mark fetchTreatment
- (void)fetchTreatment:(NSDate*)createdAt
        withCompletion:(void (^)(Treatment* treatment))completion{
    Treatment* treatment;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Treatment"];
    [query whereKey:@"createdAt" equalTo:createdAt];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d patients.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                treatment.treatmentDuration = [object objectForKey:@"duration"];
                treatment.treatmentDescription = [object objectForKey:@"createdAt"];
                treatment.treatementFinishedAt = [object objectForKey:@"finishedAt"];
                treatment.treatmentStatus = [object objectForKey:@"status"];
                treatment.treatmentObjectId = [object objectForKey:@"objectId"];
                treatment.treatmentVersionHistory = [object objectForKey:@"versionHistory"];
                treatment.treatmentUpdatedAt = [object objectForKey:@"updatedAt"];
            }
            
            if (treatment) {
                completion(treatment);
            }else{
                completion(nil);
                NSLog(@"404 - Envio.m - fetchTreatment");
            }

        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)fetchAllTreatments:(void (^)(Treatment* treatment))completion{
    Treatment* treatment;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Treatment"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d patients.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                treatment.treatmentDuration = [object objectForKey:@"duration"];
                treatment.treatmentDescription = [object objectForKey:@"createdAt"];
                treatment.treatementFinishedAt = [object objectForKey:@"finishedAt"];
                treatment.treatmentStatus = [object objectForKey:@"status"];
                treatment.treatmentObjectId = [object objectForKey:@"objectId"];
                treatment.treatmentVersionHistory = [object objectForKey:@"versionHistory"];
                treatment.treatmentUpdatedAt = [object objectForKey:@"updatedAt"];
            }
            
            if (treatment) {
                completion(treatment);
            }else{
                completion(nil);
                NSLog(@"404 - Envio.m - fetchAllTreatments");
            }
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

#pragma mark fetchDiagnosis
- (void)fetchDiagnosis: (NSDate*)createdAt
        withCompletion:(void (^)(Diagnosis* diagnosis))completion{
    
    Diagnosis* diagnosis;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Diagnosis"];
    [query whereKey:@"createdAt" equalTo:createdAt];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d patients.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                diagnosis.diagnosisCreatedAt = [object objectForKey:@"createdAt"];
                diagnosis.diagnosisConfirmedAt = [object objectForKey:@"confirmedAt"];
                diagnosis.diagnosisStatus = [object objectForKey:@"status"];
                diagnosis.diagnosisDescription = [object objectForKey:@"description"];
                diagnosis.diagnosisUpdatedAt = [object objectForKey:@"updatedAt"];
                diagnosis.diagnosisObjectId = [object objectForKey:@"objectId"];
                diagnosis.diagnosisStatus = [object objectForKey:@"status"];
                diagnosis.diagnosisVersionHistory = [object objectForKey:@"versionHistory"];
                
            }
            if (diagnosis) {
                completion(diagnosis);
            }else{
                completion(nil);
                NSLog(@"404 - Envio.m - fetchDiagnosis");
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            
        }
    }];
}

- (void)fetchAllDiagnosis:(void (^)(Diagnosis* diagnosis))completion{
    Diagnosis* diagnosis;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Diagnosis"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d patients.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                diagnosis.diagnosisCreatedAt = [object objectForKey:@"createdAt"];
                diagnosis.diagnosisConfirmedAt = [object objectForKey:@"confirmedAt"];
                diagnosis.diagnosisStatus = [object objectForKey:@"status"];
                diagnosis.diagnosisUpdatedAt = [object objectForKey:@"updatedAt"];
                diagnosis.diagnosisObjectId = [object objectForKey:@"objectId"];
                diagnosis.diagnosisVersionHistory = [object objectForKey:@"versionHistory"];
            }
            if (diagnosis) {
                completion(diagnosis);
            }else{
                completion(nil);
                NSLog(@"404 - Envio.m - fetchAllDiagnosis");
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            
        }
    }];
}


#pragma mark delete method

- (void) deleteTreatment: (Treatment*)treatment
          withCompletion: (void (^)(BOOL succeded))completion{
   
    Envio* envio = [[Envio alloc]init];
    
    PFObject* object = [PFObject objectWithoutDataWithClassName:@"Treatment" objectId:treatment.treatmentObjectId];
    
    [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError* error){
        if (succeeded) {
            NSLog(@"Treatment succesfully deleted");
            completion(succeeded);
        }
        else
        {
            NSLog(@"Error: %@", error.description);
            completion(succeeded);
        }
    }];
}

- (void) deletePatient: (Patient*)patient
            fromDoctor: (Doctor*)doctor{

    
    //Fetch doctor
    Envio* envio = [[Envio alloc]init];
    NSMutableArray* fetchedPatientsArray = [[NSMutableArray alloc]init];
    
    [envio fetchDoctor:doctor.doctorCRMString withCompletion:^(Doctor* doctor){
        if (doctor) {
            
            [fetchedPatientsArray arrayByAddingObjectsFromArray:doctor.doctorPatientsArray];
            
        }else{
            
            NSLog(@"deletePatient:fromDoctor: failed retrieving the doctor - Envio.m");
            
        }
    }];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Doctor"];
    [query whereKey:@"CRM" equalTo:doctor.doctorCRMString];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject * doctor, NSError *error) {
        if (!error) {
            // Found doctor
            [doctor setObject:fetchedPatientsArray forKey:@"patientsArray"];
            
            // Save
            [doctor saveInBackground];
        } else {
            // Did not find any doctors
            NSLog(@"Error: %@", error);
        }
    }];
    
}

- (void) deleteDiagnosis: (Diagnosis*)diagnosis
          withCompletion: (void (^)(BOOL succeded))completion{
    
    PFObject* object = [PFObject objectWithoutDataWithClassName:@"Diagnosis" objectId:diagnosis.diagnosisObjectId];
    
    [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError* error){
        if (succeeded) {
            NSLog(@"Treatment succesfully deleted");
            completion(succeeded);
        }
        else
        {
            NSLog(@"Error: %@", error.description);
            completion(succeeded);
        }
    }];
}



@end
