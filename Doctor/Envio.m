//
//  Envio.m
//  Doctor
//
//  Created by Breno Ramos on 10/19/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "Envio.h"
#import "AppDelegate.h"

@implementation Envio

- (void) showAlertViewError: (NSError*)error{
    UIAlertController* errorAlertView = [UIAlertController alertControllerWithTitle:@"Atenção!" message:[NSString stringWithFormat:@"Problema ao tentar conexão com servidor, tente outra vez. Erro: %@", error.description] preferredStyle:UIAlertControllerStyleAlert];
    
    [errorAlertView showDetailViewController:errorAlertView sender:nil];
}

- (void) showAlertViewConfirmation{

    
        UIAlertController* errorAlertView = [UIAlertController alertControllerWithTitle:@"Tudo certo!" message:[NSString stringWithFormat:@"Atividade feita com sucesso!"] preferredStyle:UIAlertControllerStyleAlert];
        [errorAlertView showDetailViewController:errorAlertView sender:nil];


}

- (void) newForumTopic:(ForumTopic *)forumTopic withCompletion:(void (^)(BOOL))completion{
    
    PFObject* topic = [PFObject objectWithClassName:@"Forum"];
    topic[@"Owner"] = forumTopic.topicForumOwner;
    topic[@"Sinopse"] = forumTopic.topicForumSinopse;
    topic[@"Subject"] = forumTopic.topicForumSubject;
    topic[@"UpdatedBy"] = forumTopic.topicForumUpdatedAt;
    topic[@"OwnerCRM"] = forumTopic.topicForumOwnerCRM;
    
    [topic saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            //[self generateForumCreationLog];
            completion(true);
        } else {
            // There was a problem, check error.description
            [self  showAlertViewError:error];
            
        }
    }];
    

}

#pragma mark newDoctor

- (void) newDoctor: (Doctor*)doctor{
    PFUser *user = [PFUser user];
    user.username = doctor.doctorUsernameString;
    user.password = doctor.doctorPasswordString;
    user.email = doctor.doctorEmailString;
    user[@"CRM"] = doctor.doctorCRMString;
    user[@"celular"] = doctor.doctorContactString;
    user[@"patients"] = doctor.doctorPatientsArray;
    
    PFFile* userPhoto = [PFFile fileWithData:doctor.doctorPhotoData];
    user[@"photo"] = userPhoto;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"Signed UP - OK!");
            [self generateDoctorCreationLog:doctor];
        } else {
            NSString *errorString = [error userInfo][@"error"];// Show the errorString somewhere and let the user try again.
            NSLog(@"%@", errorString);
            //Deal with it on a new method;
            [self  showAlertViewError:error];
        }
    }];
    
    
}

#pragma mark newPatient

- (void) newPatient:(Patient*)patient {
    
    PFObject* newPatient = [PFObject objectWithClassName:@"Patient"];
    newPatient[@"name"] = patient.patientNameString ? patient.patientNameString : @"";
    newPatient[@"CPF"] = patient.patientCPFString ? patient.patientCPFString : @"";
    newPatient[@"RG"] = patient.patientRGString ? patient.patientRGString : @"";
    newPatient[@"age"] = patient.patientAgeString ? patient.patientAgeString : @"";
    newPatient[@"address"] = patient.patientAdressString ? patient.patientAdressString : @"";
    newPatient[@"gender"] = patient.patientGenderString? patient.patientGenderString : @"";
    
    [newPatient saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
          //  [self generatePatientCreationLog];
        } else {
            // There was a problem, check error.description
         //   [self  showAlertViewError:error];

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
            [self generateDiagnosisCreationLog];
        } else {
            // There was a problem, check error.description
            [self  showAlertViewError:error];

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
            [self generateTreatmentCreationLog];
        } else {
            // There was a problem, check error.description
            [self  showAlertViewError:error];

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
            [self generateExamCreationLog];
        } else {
            // There was a problem, check error.description
            [self  showAlertViewError:error];

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
            [self  showAlertViewError:error];

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
            [self generateAppointmentCreationLog];
        } else {
            // There was a problem, check error.description
            [self  showAlertViewError:error];

        }
    }];
    
}

#pragma mark Queries
#pragma mark Sign In
- (void)signIn: (NSString*)username withPassword: (NSString*)password :(void (^)(BOOL finished))completion{
    PFUser *user = [PFUser user];
    user.username = username;
    user.password = password;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            completion(true);
            NSLog(@"foi");
        } else {
            completion(false);
        }
    }];
}
- (void)logIn: (NSString*)username withPassword: (NSString*)password :(void (^)(BOOL finished))completion{    
    PFUser* user = [[PFUser alloc] init];
    user.username = username;
    user.password = password;

    [PFUser logInWithUsernameInBackground:user.username password:user.password block:^(PFUser* user, NSError* error){
        if (!error){
            completion(true);
            //[self generateLogInLog];
        }else{
            completion(false);
            //[self  showAlertViewError:error];
        }
    }];
}

#pragma mark fetchPatient
- (void)fetchPatientPassingCPF:(NSString*)CPF
      withCompletion:(void (^)(Patient* patient))completion;{
    
        PFQuery *query = [PFQuery queryWithClassName:@"Patient"];
        [query whereKey:@"CPF" equalTo:CPF];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
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
            [self  showAlertViewError:error];

        }
    }];
}

- (void)fetchAllPatients: (void (^)(NSMutableArray * patientArray))completion
{
    NSMutableArray* patients = [[NSMutableArray alloc]init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Patient"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                
                Patient* patient = [[Patient alloc]init];
                patient.patientNameString = [object objectForKey:@"name"];
                patient.patientCPFString = [object objectForKey:@"CPF"];
                patient.patientAgeString = [object objectForKey:@"age"];
                patient.patientRGString = [object objectForKey:@"RG"];
                patient.patientGenderString = [object objectForKey:@"gender"];
                patient.patientObjectId = object.objectId;
                
                [patients addObject:patient];
                
                if (patients) {
                    completion(patients);
                }else{
                    completion(nil);
                    NSLog(@"404 - Envio.m - fetchAllPatients");
                }
            }
            

        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            [self  showAlertViewError:error];

        }
    }];
}

- (void)fetchLastSeen:(Doctor *)doctor :(Patient *) patient :(void (^)(NSString * lastSeen))completion
{
    PFQuery *query = [PFQuery queryWithClassName:@"Appointment"];
    [query whereKey:@"PatientEnvolved" equalTo:patient.patientCPFString];
    [query whereKey:@"DoctorEnvolved" equalTo:doctor.doctorCRMString];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                
                NSString* lastSeen = [[NSString alloc] initWithString:object[@"Date"]];
                
                if (lastSeen) {
                    completion(lastSeen);
                }else{
                    completion(nil);
                    NSLog(@"404 - Envio.m - fetchLastSeen");
                }
            }
        } else {
            completion(nil);
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            [self  showAlertViewError:error];
            
        }
    }];
}

- (void)fetchAllMedications:(void (^)(NSMutableArray * medicationArray))completion{
    NSMutableArray* medications = [[NSMutableArray alloc]init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Medication"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                Medication* medication = [[Medication alloc]init];
                medication.medicationCategoryString = [object objectForKey:@"category"];
                medication.medicationActivePrincipleString = [object objectForKey:@"activeprinciples"];
                [medications addObject:medication];
                if (medications) {
                    completion(medications);
                }else{
                    completion(nil);
                    NSLog(@"404 - Envio.m - fetchAllMedications");
                }
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            [self  showAlertViewError:error];

        }
    }];
}


- (void) setTopicAsFavourite:(NSString *)topicId :(Doctor *)doctor withCompletion:(void (^)(BOOL *finished))completion{
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    [query whereKey:@"CRM" equalTo:doctor.doctorCRMString];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSMutableArray* favArray = [[NSMutableArray alloc] initWithArray:object[@"favForumTopics"]];
                
                if ([favArray containsObject:topicId]) {
                    [favArray removeObject:topicId];
                }
                else{
                    [favArray addObject:topicId];
                }
                object[@"favForumTopics"] = favArray;
               
                PFQuery *query2 = [PFQuery queryWithClassName:@"User"];
                [query2 getObjectInBackgroundWithId:object.objectId block:^(PFObject *query2, NSError *error) {
                    query2[@"favForumTopics"] = favArray;
                    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
                    appDelegate.doctor.favTopicsArray = favArray;
                    completion(true);
                    [query2 saveInBackground];
                }];
                return ;
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            [self  showAlertViewError:error];
            
        }
    }];

}

- (void) setTopicAsSaw:(NSString *)topicId :(Doctor *)doctor withCompletion: (void (^)(BOOL* finished))completion{
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    [query whereKey:@"CRM" equalTo:doctor.doctorCRMString];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSMutableArray* sawArray = [[NSMutableArray alloc] initWithArray:object[@"sawForumTopics"]];
                [sawArray addObject:topicId];
                object[@"sawForumTopics"] = sawArray;
                
                PFQuery *query2 = [PFQuery queryWithClassName:@"User"];
                [query2 getObjectInBackgroundWithId:object.objectId block:^(PFObject *query2, NSError *error) {
                    query2[@"sawForumTopics"] = sawArray;
                    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
                    appDelegate.doctor.sawTopicsArray = sawArray;
                    completion(true);
                    [query2 saveInBackground];
                }];
                return ;
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            [self  showAlertViewError:error];
            
        }
    }];
   
}


- (void)fetchExamsPassingPatient:(Patient*)patient
               withCompletion:(void (^)(NSMutableArray* examsArray))completion{
  
    NSMutableArray* examsArray = [[NSMutableArray alloc] init];
    PFQuery *query = [PFQuery queryWithClassName:@"Exam"];
    [query whereKey:@"PatientEnvolved" equalTo:patient.patientCPFString];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                
//                Doctor* doctor = [[Doctor alloc]init];
//                doctor.doctorCelularString = [object objectForKey:@"celular"];
//                doctor.doctorCRMString = [object objectForKey:@"CRM"];
//                doctor.doctorEmailString = [object objectForKey:@"email"];
//                doctor.doctorNameString = [object objectForKey:@"name"];
//                doctor.doctorPasswordString = [object objectForKey:@"password"];
//                doctor.doctorUsernameString = [object objectForKey:@"username"];
//                doctor.doctorObjectId = [object objectForKey:@"objectId"];
                Exam *exam = [[Exam alloc] init];
                exam.examDescription = @"lilau";
                [examsArray addObject:exam];
            }
            if (examsArray) {
                completion(examsArray);
            }else{
                completion(nil);
                NSLog(@"404 - Envio.m - fetchDoctor");
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            [self  showAlertViewError:error];
            
        }
    }];


}

#pragma mark fetchDoctor

- (void)fetchDoctorPassingCRM:(NSString*)CRM
      withCompletion:(void (^)(Doctor* doctor))completion{
    
    PFQuery *query = [PFQuery queryWithClassName:@"Doctor"];
    [query whereKey:@"CRM" equalTo:CRM];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                
                Doctor* doctor = [[Doctor alloc]init];
                doctor.doctorContactString = [object objectForKey:@"celular"];
                doctor.doctorCRMString = [object objectForKey:@"CRM"];
                doctor.doctorEmailString = [object objectForKey:@"email"];
                doctor.doctorNameString = [object objectForKey:@"name"];
                doctor.doctorPasswordString = [object objectForKey:@"password"];
                doctor.doctorUsernameString = [object objectForKey:@"username"];
                doctor.doctorObjectId = [object objectForKey:@"objectId"];
                doctor.doctorPhotoData = [object objectForKey:@"photo"];

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
            [self  showAlertViewError:error];

        }
    }];
}



#pragma mark fetchAppointment
- (void)fetchAppointmentPassingDoctor: (Doctor*)doctor withCompletion:(void (^)(NSMutableArray * appointmentArray))completion;{
    
    Appointment* appointment;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Appointment"];
    [query whereKey:@"doctorEnvolved" equalTo:doctor.doctorCRMString];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
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
                NSLog(@"404 - Envio.m - fetchAppointment");
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            [self  showAlertViewError:error];

        }
    }];
}
- (void)fetchAppointmentPassingPatient: (Patient*)patient withCompletion:(void (^)(NSMutableArray * appointmentArray))completion;{
    NSMutableArray* appointmentArray = [[NSMutableArray alloc] init];
    Appointment* appointment = [[Appointment alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Appointment"];
    [query whereKey:@"PatientEnvolved" equalTo:patient.patientCPFString];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                appointment.appointmentDoctor = [object objectForKey:@"doctor"];
                appointment.appointmentCreatedAt = [object objectForKey:@"createdAt"];
                appointment.appointmentDiagnosis = [object objectForKey:@"diagnosis"];
                appointment.appointmentPatient = [object objectForKey:@"patient"];
                appointment.appointmentTreatment = [object objectForKey:@"treatment"];
                appointment.appointmentCaseHistory = [object objectForKey:@"caseHistory"];
                appointment.appointmentObjectId = [object objectForKey:@"objectId"];
                appointment.appointmentExams = [object objectForKey:@"exams"];
                [appointmentArray addObject:appointment];
            }
            if (appointmentArray) {
                completion(appointmentArray);
            }else{
                completion(nil);
                NSLog(@"404 - Envio.m - fetchAppointment");
            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            [self  showAlertViewError:error];
            
        }
    }];
}

- (void)fetchAllAppointments: (void (^)(Appointment* appointment))completion
{
    Appointment* appointment;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Appointment"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
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
            [self  showAlertViewError:error];

        }
    }];

}

#pragma mark fetchTreatment
- (void)fetchTreatmentPassingPatient:(Patient *)patient
        withCompletion:(void (^)(NSMutableArray * treatmentArray))completion{
    Treatment* treatment = [[Treatment alloc] init];
    NSMutableArray* treatmentArray = [[NSMutableArray alloc] init];
    PFQuery *query = [PFQuery queryWithClassName:@"Treatment"];
    [query whereKey:@"PatientEnvolved" equalTo:patient.patientCPFString];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                treatment.treatmentDuration = [object objectForKey:@"duration"];
                treatment.treatmentDescription = [object objectForKey:@"createdAt"];
                treatment.treatementFinishedAt = [object objectForKey:@"finishedAt"];
                treatment.treatmentStatus = [object objectForKey:@"status"];
                treatment.treatmentObjectId = [object objectForKey:@"objectId"];
                treatment.treatmentVersionHistory = [object objectForKey:@"versionHistory"];
                treatment.treatmentUpdatedAt = [object objectForKey:@"updatedAt"];
                [treatmentArray addObject:treatment];
            }
            if (treatmentArray) {
                completion(treatmentArray);
            }else{
                completion(nil);
                NSLog(@"404 - Envio.m - fetchTreatment");
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            [self  showAlertViewError:error];
        }
    }];
}

- (void)fetchAllTreatments:(void (^)(NSMutableArray* treatmentArray))completion{
    Treatment* treatment;
    NSMutableArray* treatmentArray = [[NSMutableArray alloc] init];
    PFQuery *query = [PFQuery queryWithClassName:@"Treatment"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
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
            
            if (treatmentArray) {
                completion(treatmentArray);
            }else{
                completion(nil);
                NSLog(@"404 - Envio.m - fetchAllTreatments");
            }
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            [self  showAlertViewError:error];

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
            [self  showAlertViewError:error];

            
        }
    }];
}

- (void)fetchAllDiagnosis:(void (^)(Diagnosis* diagnosis))completion{
    Diagnosis* diagnosis;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Diagnosis"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
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
            [self  showAlertViewError:error];
            
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
            [self generateTreatmentDeleteLog];
        }
        else
        {
            NSLog(@"Error: %@", error.description);
            completion(succeeded);
            [self  showAlertViewError:error];

        }
    }];
}

- (void) deletePatient: (Patient*)patient
            fromDoctor: (Doctor*)doctor{

    
    //Fetch doctor
    Envio* envio = [[Envio alloc]init];
    NSMutableArray* fetchedPatientsArray = [[NSMutableArray alloc]init];
    
    [envio fetchDoctorPassingCRM:doctor.doctorCRMString withCompletion:^(Doctor* doctor){
        if (doctor) {
            
            [fetchedPatientsArray arrayByAddingObjectsFromArray:doctor.doctorPatientsArray];
            
        }else{
            
            NSLog(@"deletePatient:fromDoctor: failed retrieving the doctor - Envio.m");
            [self  showAlertViewError:nil];
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
            [self  showAlertViewError:error];

        }
    }];
    
}

- (void) deleteDiagnosis: (Diagnosis*)diagnosis
          withCompletion: (void (^)(BOOL succeded))completion{
    
    PFObject* object = [PFObject objectWithoutDataWithClassName:@"Diagnosis" objectId:diagnosis.diagnosisObjectId];
    
    [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError* error){
        if (succeeded) {
            completion(succeeded);
            [self generateDiagnosisDeleteLog];
        }
        else
        {
            NSLog(@"Error: %@", error.description);
            completion(succeeded);
            [self  showAlertViewError:error];

        }
    }];
}
//TO DO
- (void) deleteExam: (Exam*)exam withCompletion: (void (^)(BOOL succeded))completion{
    [self generateExamDeleteLog];
}
 

#pragma mark - Log Queries (Doctor)
- (void) generateDoctorCreationLog:(Doctor *)doctor{
    
    Log* log = [[Log alloc]init];
    PFObject* newLog = [PFObject objectWithClassName:@"Log"];
    
    log.logRegisteredBy = [NSString stringWithFormat:@"%@", doctor.doctorCRMString];
    log.logActivityType = @"Doctor - Creation";
    log.logActivityRegister = [NSString stringWithFormat:@"Doctor %@ was created | CRM:%@ | E-mail:%@ | Username:%@ | Celular:%@ ", doctor.doctorNameString, doctor.doctorCRMString, doctor.doctorEmailString, doctor.doctorUsernameString, doctor.doctorContactString];
    log.logPatientsEnvolved = nil;
    log.logCreatedAt = [self getSystemDate];
    
    newLog[@"registeredBy"] = log.logRegisteredBy;
    newLog[@"activityType"] = log.logActivityType;
    newLog[@"activityRegister"] = log.logActivityRegister;
    newLog[@"patientsEnvolved"] = log.logPatientsEnvolved;
    newLog[@"createdAt"] = log.logCreatedAt;
    
    [newLog saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self showAlertViewConfirmation];
            
        } else {
            // There was a problem, check error.description
            [self  showAlertViewError:error];
            
        }
    }];
}


- (void) generateDoctorUpdateInfoLog:(Doctor *)doctor{
    
    Log* log = [[Log alloc]init];
    PFObject* newLog = [PFObject objectWithClassName:@"Log"];
    
    log.logRegisteredBy = [NSString stringWithFormat:@"%@", doctor.doctorCRMString];
    log.logActivityType = @"Doctor - Updated Info";
    log.logActivityRegister = [NSString stringWithFormat:@"Doctor %@ updated something | CRM:%@ | E-mail:%@ | Username:%@ | Celular:%@ ", doctor.doctorNameString, doctor.doctorCRMString, doctor.doctorEmailString, doctor.doctorUsernameString, doctor.doctorContactString];
    log.logPatientsEnvolved = nil;
    log.logCreatedAt = [self getSystemDate];
    
    newLog[@"registeredBy"] = log.logRegisteredBy;
    newLog[@"activityType"] = log.logActivityType;
    newLog[@"activityRegister"] = log.logActivityRegister;
    newLog[@"patientsEnvolved"] = log.logPatientsEnvolved;
    newLog[@"createdAt"] = log.logCreatedAt;
    
    [newLog saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self showAlertViewConfirmation];
            
        } else {
            // There was a problem, check error.description
            [self  showAlertViewError:error];
            
        }
    }];
    
}
- (void) generateDoctorInteractionLog:(Doctor *)doctor{
    
    Log* log = [[Log alloc]init];
    PFObject* newLog = [PFObject objectWithClassName:@"Log"];
    
    log.logRegisteredBy = [NSString stringWithFormat:@"%@", doctor.doctorCRMString];
    log.logActivityType = @"Doctor creation";
    log.logActivityRegister = [NSString stringWithFormat:@"Doctor %@ Interacted | CRM:%@ | E-mail:%@ | Username:%@ | Celular:%@ ", doctor.doctorNameString, doctor.doctorCRMString, doctor.doctorEmailString, doctor.doctorUsernameString, doctor.doctorContactString];
    log.logPatientsEnvolved = nil;
    log.logCreatedAt = [self getSystemDate];
    
    newLog[@"registeredBy"] = log.logRegisteredBy;
    newLog[@"activityType"] = log.logActivityType;
    newLog[@"activityRegister"] = log.logActivityRegister;
    newLog[@"patientsEnvolved"] = log.logPatientsEnvolved;
    newLog[@"createdAt"] = log.logCreatedAt;
    
    [newLog saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self showAlertViewConfirmation];
            
        } else {
            // There was a problem, check error.description
            [self  showAlertViewError:error];
            
        }
    }];
    
}
- (void) generateDoctorDeleteLog:(Doctor *)doctor{
    
    Log* log = [[Log alloc]init];
    PFObject* newLog = [PFObject objectWithClassName:@"Log"];
    
    log.logRegisteredBy = [NSString stringWithFormat:@"%@", doctor.doctorCRMString];
    log.logActivityType = @"Doctor creation";
    log.logActivityRegister = [NSString stringWithFormat:@"Doctor %@ was Deleted of our platform | CRM:%@ | E-mail:%@ | Username:%@ | Celular:%@ ", doctor.doctorNameString, doctor.doctorCRMString, doctor.doctorEmailString, doctor.doctorUsernameString, doctor.doctorContactString];
    log.logPatientsEnvolved = nil;
    log.logCreatedAt = [self getSystemDate];
    
    newLog[@"registeredBy"] = log.logRegisteredBy;
    newLog[@"activityType"] = log.logActivityType;
    newLog[@"activityRegister"] = log.logActivityRegister;
    newLog[@"patientsEnvolved"] = log.logPatientsEnvolved;
    newLog[@"createdAt"] = log.logCreatedAt;
    
    [newLog saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self showAlertViewConfirmation];
            
        } else {
            // There was a problem, check error.description
            [self  showAlertViewError:error];
            
        }
    }];
    
}

#pragma mark - Log Queries (Patient)
- (void) generatePatientCreationLog:(Patient *)patient{
    Log* log = [[Log alloc]init];
    PFObject* newLog = [PFObject objectWithClassName:@"Log"];
    
    log.logRegisteredBy = [NSString stringWithFormat:@"%@", patient.patientCPFString];
    log.logActivityType = @"Patient Creation";
    log.logActivityRegister = [NSString stringWithFormat:@"Patient %@ was created | CPF:%@ | Nome:%@", patient.patientObjectId, patient.patientCPFString, patient.patientNameString];
    log.logPatientsEnvolved = [NSArray arrayWithObjects:patient, nil];
    log.logCreatedAt = [self getSystemDate];
    
    newLog[@"registeredBy"] = log.logRegisteredBy;
    newLog[@"activityType"] = log.logActivityType;
    newLog[@"activityRegister"] = log.logActivityRegister;
    newLog[@"patientsEnvolved"] = log.logPatientsEnvolved;
    newLog[@"createdAt"] = log.logCreatedAt;
    
    [newLog saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self showAlertViewConfirmation];
            
        } else {
            // There was a problem, check error.description
            [self  showAlertViewError:error];
            
        }
    }];
    
}
- (void) generatePatientUpdateInfoLog:(Patient *)patient{
    
    Log* log = [[Log alloc]init];
    PFObject* newLog = [PFObject objectWithClassName:@"Log"];
    
    log.logRegisteredBy = [NSString stringWithFormat:@"%@", patient.patientCPFString];
    log.logActivityType = @"Patient Updated Info";
    log.logActivityRegister = [NSString stringWithFormat:@"Patient %@ updated Info | CPF:%@ | Nome:%@", patient.patientObjectId, patient.patientCPFString, patient.patientNameString];
    log.logPatientsEnvolved = [NSArray arrayWithObjects:patient, nil];
    log.logCreatedAt = [self getSystemDate];
    
    newLog[@"registeredBy"] = log.logRegisteredBy;
    newLog[@"activityType"] = log.logActivityType;
    newLog[@"activityRegister"] = log.logActivityRegister;
    newLog[@"patientsEnvolved"] = log.logPatientsEnvolved;
    newLog[@"createdAt"] = log.logCreatedAt;
    
    [newLog saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self showAlertViewConfirmation];
            
        } else {
            // There was a problem, check error.description
            [self  showAlertViewError:error];
            
        }
    }];
    
}
- (void) generatePatientDeleteLog:(Patient *)patient{
    
    Log* log = [[Log alloc]init];
    PFObject* newLog = [PFObject objectWithClassName:@"Log"];
    
    log.logRegisteredBy = [NSString stringWithFormat:@"%@", patient.patientCPFString];
    log.logActivityType = @"Patient - Deleted";
    log.logActivityRegister = [NSString stringWithFormat:@"Patient %@ was deleted | CPF:%@ | Nome:%@", patient.patientObjectId, patient.patientCPFString, patient.patientNameString];
    log.logPatientsEnvolved = [NSArray arrayWithObjects:patient, nil];
    log.logCreatedAt = [self getSystemDate];
    
    newLog[@"registeredBy"] = log.logRegisteredBy;
    newLog[@"activityType"] = log.logActivityType;
    newLog[@"activityRegister"] = log.logActivityRegister;
    newLog[@"patientsEnvolved"] = log.logPatientsEnvolved;
    newLog[@"createdAt"] = log.logCreatedAt;
    
    [newLog saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self showAlertViewConfirmation];
            
        } else {
            // There was a problem, check error.description
            [self  showAlertViewError:error];
            
        }
    }];
    
}

#pragma mark - Log Queries (Diagnosis)
- (void) generateDiagnosisCreationLog:(Diagnosis *)diagnosis{
    
    Log* log = [[Log alloc]init];
    PFObject* newLog = [PFObject objectWithClassName:@"Log"];
    
    log.logRegisteredBy = [NSString stringWithFormat:@"%@", diagnosis.diagnosisAuthor];
    log.logActivityType = @"Diagnosis - created";
    log.logActivityRegister = [NSString stringWithFormat:@"Diagnosis %@ was created | Confirmed At:%@ | Description:%@", diagnosis.diagnosisObjectId, diagnosis.diagnosisConfirmedAt, diagnosis.diagnosisDescription];
    log.logPatientsEnvolved = [NSArray arrayWithObjects:diagnosis.diagnosisPatient, nil];
    log.logCreatedAt = [self getSystemDate];
    
    newLog[@"registeredBy"] = log.logRegisteredBy;
    newLog[@"activityType"] = log.logActivityType;
    newLog[@"activityRegister"] = log.logActivityRegister;
    newLog[@"patientsEnvolved"] = log.logPatientsEnvolved;
    newLog[@"createdAt"] = log.logCreatedAt;
    
    [newLog saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self showAlertViewConfirmation];
            
        } else {
            // There was a problem, check error.description
            [self  showAlertViewError:error];
            
        }
    }];
    
}

//USE WHEN THE METHOD OF THE CLASSE VersionHistory.h IS CALLED
- (void) generateDiagnosisUpdateLog:(Diagnosis *)diagnosis{
    
    Log* log = [[Log alloc]init];
    PFObject* newLog = [PFObject objectWithClassName:@"Log"];
    
    log.logRegisteredBy = [NSString stringWithFormat:@"%@", diagnosis.diagnosisAuthor];
    log.logActivityType = @"Diagnosis - Updated";
    log.logActivityRegister = [NSString stringWithFormat:@"Diagnosis %@ was created | Confirmed At:%@ | Description:%@", diagnosis.diagnosisObjectId, diagnosis.diagnosisConfirmedAt, diagnosis.diagnosisDescription];
    log.logPatientsEnvolved = [NSArray arrayWithObjects:diagnosis.diagnosisPatient, nil];
    log.logCreatedAt = [self getSystemDate];
    
    newLog[@"registeredBy"] = log.logRegisteredBy;
    newLog[@"activityType"] = log.logActivityType;
    newLog[@"activityRegister"] = log.logActivityRegister;
    newLog[@"patientsEnvolved"] = log.logPatientsEnvolved;
    newLog[@"createdAt"] = log.logCreatedAt;
    
    [newLog saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self showAlertViewConfirmation];
            
        } else {
            // There was a problem, check error.description
            [self  showAlertViewError:error];
            
        }
    }];
    
}
- (void) generateDiagnosisDeleteLog:(Diagnosis *)diagnosis{
    Log* log = [[Log alloc]init];
    PFObject* newLog = [PFObject objectWithClassName:@"Log"];
    
    log.logRegisteredBy = [NSString stringWithFormat:@"%@", diagnosis.diagnosisAuthor];
    log.logActivityType = @"Diagnosis - Deleted";
    log.logActivityRegister = [NSString stringWithFormat:@"Diagnosis %@ was deleted| Confirmed At:%@ | Description:%@", diagnosis.diagnosisObjectId, diagnosis.diagnosisConfirmedAt, diagnosis.diagnosisDescription];
    log.logPatientsEnvolved = [NSArray arrayWithObjects:diagnosis.diagnosisPatient, nil];
    log.logCreatedAt = [self getSystemDate];
    
    newLog[@"registeredBy"] = log.logRegisteredBy;
    newLog[@"activityType"] = log.logActivityType;
    newLog[@"activityRegister"] = log.logActivityRegister;
    newLog[@"patientsEnvolved"] = log.logPatientsEnvolved;
    newLog[@"createdAt"] = log.logCreatedAt;
    
    [newLog saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self showAlertViewConfirmation];
            
        } else {
            // There was a problem, check error.description
            [self  showAlertViewError:error];
            
        }
    }];
}

#pragma mark - Log Queries (Exam)
- (void) generateExamCreationLog:(Exam *)exam{
    
    Log* log = [[Log alloc]init];
    PFObject* newLog = [PFObject objectWithClassName:@"Log"];
    
    log.logRegisteredBy = [NSString stringWithFormat:@"%@", exam.examApplicant];
    log.logActivityType = @"Exam - created";
    log.logActivityRegister = [NSString stringWithFormat:@"Exam %@ was created | Type:%@ | Description:%@", exam.examObjectId, exam.examType, exam.examDescription];
    log.logPatientsEnvolved = [NSArray arrayWithObjects:exam.examPatient, nil];
    log.logCreatedAt = [self getSystemDate];
    
    newLog[@"registeredBy"] = log.logRegisteredBy;
    newLog[@"activityType"] = log.logActivityType;
    newLog[@"activityRegister"] = log.logActivityRegister;
    newLog[@"patientsEnvolved"] = log.logPatientsEnvolved;
    newLog[@"createdAt"] = log.logCreatedAt;
    
    [newLog saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self showAlertViewConfirmation];
            
        } else {
            // There was a problem, check error.description
            [self  showAlertViewError:error];
            
        }
    }];
    
}
- (void) generateExamUpdateLog:(Exam *)exam{
    
    Log* log = [[Log alloc]init];
    PFObject* newLog = [PFObject objectWithClassName:@"Log"];
    
    log.logRegisteredBy = [NSString stringWithFormat:@"%@", exam.examApplicant];
    log.logActivityType = @"Exam - Updated";
    log.logActivityRegister = [NSString stringWithFormat:@"Exam %@ was updated | CreatedAt:%@ | Description:%@", exam.examObjectId, exam.examCreatedAt, exam.examDescription];
    log.logPatientsEnvolved = [NSArray arrayWithObjects:exam.examPatient, nil];
    log.logCreatedAt = [self getSystemDate];
    
    newLog[@"registeredBy"] = log.logRegisteredBy;
    newLog[@"activityType"] = log.logActivityType;
    newLog[@"activityRegister"] = log.logActivityRegister;
    newLog[@"patientsEnvolved"] = log.logPatientsEnvolved;
    newLog[@"createdAt"] = log.logCreatedAt;
    
    [newLog saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self showAlertViewConfirmation];
            
        } else {
            // There was a problem, check error.description
            [self  showAlertViewError:error];
            
        }
    }];
    
}
- (void) generateExamDeleteLog:(Exam *)exam{
    
    Log* log = [[Log alloc]init];
    PFObject* newLog = [PFObject objectWithClassName:@"Log"];
    
    log.logRegisteredBy = [NSString stringWithFormat:@"%@", exam.examApplicant];
    log.logActivityType = @"Exam - Deleted";
    log.logActivityRegister = [NSString stringWithFormat:@"Exam %@ was updated | CreatedAt:%@ | Description:%@", exam.examObjectId, exam.examCreatedAt, exam.examDescription];
    log.logPatientsEnvolved = [NSArray arrayWithObjects:exam.examPatient, nil];
    log.logCreatedAt = [self getSystemDate];
    
    newLog[@"registeredBy"] = log.logRegisteredBy;
    newLog[@"activityType"] = log.logActivityType;
    newLog[@"activityRegister"] = log.logActivityRegister;
    newLog[@"patientsEnvolved"] = log.logPatientsEnvolved;
    newLog[@"createdAt"] = log.logCreatedAt;
    
    [newLog saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self showAlertViewConfirmation];
            
        } else {
            // There was a problem, check error.description
            [self  showAlertViewError:error];
            
        }
    }];
    
}

#pragma mark - Log Queries (Appointment)
- (void) generateAppointmentCreationLog:(Appointment *)appointment{
    
    Log* log = [[Log alloc]init];
    PFObject* newLog = [PFObject objectWithClassName:@"Log"];
    
    log.logRegisteredBy = [NSString stringWithFormat:@"%@", appointment.appointmentDoctor];
    log.logActivityType = @"Appointment - Created";
    log.logActivityRegister = [NSString stringWithFormat:@"Appointment %@ was created | Patient:%@", appointment.appointmentObjectId, appointment.appointmentPatient];
    log.logPatientsEnvolved = [NSArray arrayWithObjects:appointment.appointmentPatient, nil];
    log.logCreatedAt = [self getSystemDate];
    
    newLog[@"registeredBy"] = log.logRegisteredBy;
    newLog[@"activityType"] = log.logActivityType;
    newLog[@"activityRegister"] = log.logActivityRegister;
    newLog[@"patientsEnvolved"] = log.logPatientsEnvolved;
    newLog[@"createdAt"] = log.logCreatedAt;
    
    [newLog saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self showAlertViewConfirmation];
            
        } else {
            // There was a problem, check error.description
            [self  showAlertViewError:error];
            
        }
    }];

    
}
- (void) generateAppointmentUpdateLog:(Appointment *)appointment{
    
    Log* log = [[Log alloc]init];
    PFObject* newLog = [PFObject objectWithClassName:@"Log"];
    
    log.logRegisteredBy = [NSString stringWithFormat:@"%@", appointment.appointmentDoctor];
    log.logActivityType = @"Appointment - Updated";
    log.logActivityRegister = [NSString stringWithFormat:@"Appointment %@ was updated | Patient:%@", appointment.appointmentObjectId, appointment.appointmentPatient];
    log.logPatientsEnvolved = [NSArray arrayWithObjects:appointment.appointmentPatient, nil];
    log.logCreatedAt = [self getSystemDate];
    
    newLog[@"registeredBy"] = log.logRegisteredBy;
    newLog[@"activityType"] = log.logActivityType;
    newLog[@"activityRegister"] = log.logActivityRegister;
    newLog[@"patientsEnvolved"] = log.logPatientsEnvolved;
    newLog[@"createdAt"] = log.logCreatedAt;
    
    [newLog saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self showAlertViewConfirmation];
            
        } else {
            // There was a problem, check error.description
            [self  showAlertViewError:error];
            
        }
    }];
    
}
- (void) generateAppointmentDeleteLog:(Appointment *)appointment{
    
    Log* log = [[Log alloc]init];
    PFObject* newLog = [PFObject objectWithClassName:@"Log"];
    
    log.logRegisteredBy = [NSString stringWithFormat:@"%@", appointment.appointmentDoctor];
    log.logActivityType = @"Appointment - Deleted";
    log.logActivityRegister = [NSString stringWithFormat:@"Appointment %@ was deleted | Patient:%@", appointment.appointmentObjectId, appointment.appointmentPatient];
    log.logPatientsEnvolved = [NSArray arrayWithObjects:appointment.appointmentPatient, nil];
    log.logCreatedAt = [self getSystemDate];
    
    newLog[@"registeredBy"] = log.logRegisteredBy;
    newLog[@"activityType"] = log.logActivityType;
    newLog[@"activityRegister"] = log.logActivityRegister;
    newLog[@"patientsEnvolved"] = log.logPatientsEnvolved;
    newLog[@"createdAt"] = log.logCreatedAt;
    
    [newLog saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self showAlertViewConfirmation];
            
        } else {
            // There was a problem, check error.description
            [self  showAlertViewError:error];
            
        }
    }];
    
}

#pragma mark - Log Queries (Forum)
- (void) generateForumCreationLog:(ForumTopic *)forumTopic{

    
}
- (void) generateForumUpdateLog:(ForumTopic *)forumTopic{
    
}
- (void) generateForumDeleteLog:(ForumTopic *)forumTopic{
    
}
- (void) generateForumInteractionLog:(ForumTopic *)forumTopic{
    
}

#pragma mark - Log Queries (Treatment)
- (void) generateTreatmentCreationLog:(Treatment *)treatment{
    
    Log* log = [[Log alloc]init];
    PFObject* newLog = [PFObject objectWithClassName:@"Log"];
    
    log.logRegisteredBy = [NSString stringWithFormat:@"%@", treatment.treatmentDoctor];
    log.logActivityType = @"Treatment - Creation";
//    log.logActivityRegister = [NSString stringWithFormat:@"Treatment %@ was created | Patient:%@ | Description: %@ " , treatment.treatmentObjectId, treatment.treatmentPatient, treatment.treatmentDescription];
//    log.logPatientsEnvolved = [NSArray arrayWithObjects:treatment.treatmentPatient, nil];
//    log.logCreatedAt = [self getSystemDate];
    
    newLog[@"registeredBy"] = log.logRegisteredBy;
    newLog[@"activityType"] = log.logActivityType;
    newLog[@"activityRegister"] = log.logActivityRegister;
    newLog[@"patientsEnvolved"] = log.logPatientsEnvolved;
    newLog[@"createdAt"] = log.logCreatedAt;
    
    [newLog saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self showAlertViewConfirmation];
            
        } else {
            // There was a problem, check error.description
            [self  showAlertViewError:error];
            
        }
    }];
    
}
- (void) generateTreatmentUpdateLog:(Treatment *)treatment{
    
    Log* log = [[Log alloc]init];
    PFObject* newLog = [PFObject objectWithClassName:@"Log"];
    
//    log.logRegisteredBy = [NSString stringWithFormat:@"%@", treatment.treatmentDoctor];
//    log.logActivityType = @"Treatment - Update";
//    log.logActivityRegister = [NSString stringWithFormat:@"Treatment %@ was updated | Patient:%@ | Description: %@ " , treatment.treatmentObjectId, treatment.treatmentPatient, treatment.treatmentDescription];
//    log.logPatientsEnvolved = [NSArray arrayWithObjects:treatment.treatmentPatient, nil];
//    log.logCreatedAt = [self getSystemDate];
    
    newLog[@"registeredBy"] = log.logRegisteredBy;
    newLog[@"activityType"] = log.logActivityType;
    newLog[@"activityRegister"] = log.logActivityRegister;
    newLog[@"patientsEnvolved"] = log.logPatientsEnvolved;
    newLog[@"createdAt"] = log.logCreatedAt;
    
    [newLog saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self showAlertViewConfirmation];
            
        } else {
            // There was a problem, check error.description
            [self  showAlertViewError:error];
            
        }
    }];
    
}
- (void) generateTreatmentDeleteLog:(Treatment *)treatment{
    
    Log* log = [[Log alloc]init];
    PFObject* newLog = [PFObject objectWithClassName:@"Log"];
    
//    log.logRegisteredBy = [NSString stringWithFormat:@"%@", treatment.treatmentDoctor];
//    log.logActivityType = @"Treatment - Deleted";
//    log.logActivityRegister = [NSString stringWithFormat:@"Treatment %@ was deleteds | Patient:%@ | Description: %@ " , treatment.treatmentObjectId, treatment.treatmentPatient, treatment.treatmentDescription];
//    log.logPatientsEnvolved = [NSArray arrayWithObjects:treatment.treatmentPatient, nil];
//    log.logCreatedAt = [self getSystemDate];
//    
    newLog[@"registeredBy"] = log.logRegisteredBy;
    newLog[@"activityType"] = log.logActivityType;
    newLog[@"activityRegister"] = log.logActivityRegister;
    newLog[@"patientsEnvolved"] = log.logPatientsEnvolved;
    newLog[@"createdAt"] = log.logCreatedAt;
    
    [newLog saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self showAlertViewConfirmation];
            
        } else {
            // There was a problem, check error.description
            [self  showAlertViewError:error];
            
        }
    }];
    
}


- (void)fetchAllForumTopics :(void (^)(NSMutableArray* forumTopicsArray))completion{
    NSMutableArray* forumTopicsArray = [[NSMutableArray alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Forum"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                ForumTopic * topic = [[ForumTopic alloc] init];
                topic.topicForumUpdatedAt = object[@"UpdatedBy"];
                topic.topicForumSinopse = object[@"Sinopse"];
                topic.topicForumOwner = object[@"Owner"];
                topic.topicForumOwnerCRM = object[@"OwnerCRM"];
                topic.topicForumSubject = object[@"Subject"];
                topic.topicObjectId = object.objectId;
                [forumTopicsArray addObject:topic];
            }
            if (forumTopicsArray) {
                completion(forumTopicsArray);
            }else{
                completion(nil);
                NSLog(@"404 - Envio.m - fetchAllTopicsForum");
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            [self  showAlertViewError:error];
            
        }
    }];

}

- (void)fetchMessagesFromTopic: (NSString *)relatedIdForum withCompletion:(void (^)(NSMutableArray* messageArray))completion{
    NSMutableArray* messagesFromForum = [[NSMutableArray alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"ForumMessages"];
    [query whereKey:@"forumId" equalTo:relatedIdForum];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                ForumTopicMessage * message = [[ForumTopicMessage alloc] init];
                message.messageForumContent = object[@"messageContent"];
                message.messageForumCreatedAt = object[@"whenCreated"];
                message.messageForumOwner = object[@"messageOwner"];
                message.messageForumRelatedId = object[@"forumId"];
                [messagesFromForum addObject:message];
            }
            if (messagesFromForum) {
                completion(messagesFromForum);
            }else{
                completion(nil);
                NSLog(@"404 - Envio.m - fetchAllMessages");
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            [self  showAlertViewError:error];
            
        }
    }];
}


- (void) newMessage:(ForumTopicMessage *)message whenComplete:(void (^)(BOOL finished))completion{
    PFObject* messageParse = [PFObject objectWithClassName:@"ForumMessages"];
    messageParse[@"messageOwner"] = message.messageForumOwner;
    messageParse[@"messageContent"] = message.messageForumContent;
    messageParse[@"whenCreated"] = message.messageForumCreatedAt;
    messageParse[@"forumId"] = message.messageForumRelatedId;
    
    [messageParse saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
          //  [self generateForumCreationLog];
            completion(true);
        } else {
            // There was a problem, check error.description
         //   [self  showAlertViewError:error];
            completion(false);
        }
    }];

}

#pragma mark - Log Queries (Message - Cryptography ASAP)
- (void) generateMessageCreationLog:(Message *)message{
    
}
- (void) generateMessageDeleteLog:(Message *)message{
    
}


#pragma mark - Other log queries
- (void) generateLogInLog{
    
}

#pragma mark - Private Methods
- (NSString *)getSystemDate{
    return @"";
}

#pragma mark - Forum Fetchs and Entries

#pragma mark - Entries
//- (void) newTopic: (ForumTopic*) topic{
//    
//    PFObject* newTopic = [PFObject objectWithClassName:@"Topics"];
//    newTopic[@"title"] = topic.topicForumTitle;
//    newTopic[@"createdBy"] = topic.topicForumCreatedBy;
//    newTopic[@"subject"] = topic.topicSubject;
//    
//    [newTopic saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
//            NSLog(@"New topic created! - '%@' ", topic.topicForumTitle);
//        } else {
//            // There was a problem, check error.description
//            [self  showAlertViewError:error];
//            
//        }
//    }];
//}
//
//- (void) newTopicMessage: (ForumTopicMessage*) message{
//    
//    PFObject* newTopicMessage = [PFObject objectWithClassName:@"ForumMessages"];
//    newTopicMessage[@"text"] = message.messageForumText;
//    newTopicMessage[@"createdBy"] = message.messageForumCreatedBy;
//    newTopicMessage[@"topic"] = message.messageForumTopic;
//    
//    [newTopicMessage saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
//            NSLog(@"New topic message created!");
//        } else {
//            // There was a problem, check error.description
//            [self  showAlertViewError:error];
//        }
//    }];
//}


#pragma mark - Forum Fetchs
//- (void) fetchAllTopicsAboutSubject: (ForumSubject*)subject
//              withCompletion:(void (^)(ForumTopic* topic))completion{
//    
//    ForumTopic* topic;
//    
//    PFQuery *query = [PFQuery queryWithClassName:@"Topics"];
//    [query whereKey:@"subject" equalTo:subject];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//            for (PFObject *object in objects) {
//                NSLog(@"%@", object.objectId);
//                topic.topicForumObjectId = [object objectForKey:@"objectId"];
//                topic.topicForumCreatedBy = [object objectForKey:@"createdBy"];
//                topic.topicForumCreatedAt = [object objectForKey:@"createdAt"];
//                topic.topicForumUpdatedAt = [object objectForKey:@"updatedAt"];
//                topic.topicSubject = [object objectForKey:@"subject"];
//                topic.topicForumTitle = [object objectForKey:@"title"];
//            }
//            if (topic) {
//                completion(topic);
//            }else{
//                completion(nil);
//                NSLog(@"404 - Envio.m - fetchTopic");
//            }
//        } else {
//            // Log details of the failure
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
//            [self  showAlertViewError:error];
//            
//        }
//    }];
//}

//- (void) fetchTopicsThatIncludes: (NSString*) search
//                  withCompletion: (void (^)(ForumTopic* topic))completion{
//    
//    ForumTopic* topic;
//    
//    PFQuery *query = [PFQuery queryWithClassName:@"Topics"];
//    [query whereKey:@"title" containsString:search];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//            for (PFObject *object in objects) {
//                NSLog(@"%@", object.objectId);
//                topic.topicForumObjectId = [object objectForKey:@"objectId"];
//                topic.topicForumCreatedBy = [object objectForKey:@"createdBy"];
//                topic.topicForumCreatedAt = [object objectForKey:@"createdAt"];
//                topic.topicForumUpdatedAt = [object objectForKey:@"updatedAt"];
//                topic.topicSubject = [object objectForKey:@"subject"];
//                topic.topicForumTitle = [object objectForKey:@"title"];
//                
//            }
//            if (topic) {
//                completion(topic);
//            }else{
//                completion(nil);
//                NSLog(@"404 - Envio.m - fetchTopicThatIncludes");
//            }
//        } else {
//            // Log details of the failure
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
//            [self  showAlertViewError:error];
//            
//        }
//    }];
//}

//- (void) fetchAllTopicMessagesOfTopic: (ForumTopic*)topic
//                       withCompletion: (void (^)(ForumTopicMessage* message))completion{
//    
//    ForumTopicMessage* message;
//    
//    PFQuery *query = [PFQuery queryWithClassName:@"Topics"];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//            for (PFObject *object in objects) {
//                NSLog(@"%@", object.objectId);
//                message.messageForumObjectId = [object objectForKey:@"objectId"];
//                message.messageForumCreatedBy = [object objectForKey:@"createdBy"];
//                message.messageForumCreatedAt = [object objectForKey:@"createdAt"];
//                message.messageForumText = [object objectForKey:@"text"];
//                message.messageForumTopic = [object objectForKey:@"topic"];
//                
//            }
//            if (message) {
//                completion(message);
//            }else{
//                completion(nil);
//                NSLog(@"404 - Envio.m - fetchAllMessagesFromTopic");
//            }
//        } else {
//            // Log details of the failure
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
//            [self  showAlertViewError:error];
//            
//        }
//    }];
//
//    
//}


- (void) updatePatient:(NSString *)patientId withPatient:(Patient *)patient withCompletion:(void (^)(BOOL *))completion{
    PFQuery* query = [[PFQuery alloc] initWithClassName:@"Patient"];
    [query getObjectInBackgroundWithId:patientId block:^(PFObject* object, NSError *error){
        if (patient.patientGenderString) {
            object[@"gender"] = patient.patientGenderString;
        }
        if (patient.patientAdressString) {
            object[@"address"] = patient.patientAdressString;
        }
        [object saveInBackground];
        completion(true);
    }];
    
}

@end
