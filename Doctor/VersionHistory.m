//
//  VersionHistory.m
//  Doctor
//
//  Created by Breno Ramos on 10/27/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "VersionHistory.h"


@implementation VersionHistory

/*
 When the user taps the update button in a document, edits it, and press save, this method is called.
It takes the document version that the user was reading (oldVersion), and the edited form (newVersion).
 First it checks the type of the document.
 Then it add the old document and the objects of the array of it and puts in the array version of the new document.
 After that it deletes the old version from the Database, and if it was deleted succesfully, uploads the new version.
 
 OBS.: A whole new object is created even if the editing was a little one.
*/

- (void) updateVersion: (id)oldVersion
        withNewVersion: (id)newVersion {
    NSLog(@"UPDATE VERSION METHOD ENTERED");
    
    if ([oldVersion isKindOfClass:[Treatment class]] && [newVersion isKindOfClass:[Treatment class]]) {
        Treatment* oldTreatment = oldVersion;
        Treatment* newTreatment = newVersion;
        Envio* envio = [[Envio alloc]init];
        
        //Adds the past versions of the document in the versionHistory array of the new version
        [newTreatment.treatmentVersionHistory addObject:oldTreatment];
//      [newTreatment.treatmentVersionHistory addObjectsFromArray:oldTreatment.treatmentVersionHistory];
        
        //Delete old version from table, and save new version if succeded
        [envio deleteTreatment:oldTreatment withCompletion:^(BOOL succeded){
            if(succeded){
                [envio newTreatment:newTreatment];
                NSLog(@"Old treatment deleted with success!");
            } else {
                NSLog(@"Error, old treatment not deleted");
            }
       }];
        
    } else if ([oldVersion isKindOfClass:[Diagnosis class]] && [newVersion isKindOfClass:[Diagnosis class]]) {
        Diagnosis* oldDiagnosis = oldVersion;
        Diagnosis* newDiagnosis = newVersion;
        Envio* envio = [[Envio alloc]init];
        
        //Adds the past versions of the document in the versionHistory array of the new version
        [newDiagnosis.diagnosisVersionHistory addObject:oldDiagnosis];
//      [newDiagnosis.diagnosisVersionHistory addObjectsFromArray:oldDiagnosis.diagnosisVersionHistory];
        
        //Delete old version from table, and save new version if succeded
        [envio deleteDiagnosis:oldDiagnosis withCompletion:^(BOOL succeded){
            if(succeded){
                [envio newDiagnosis:newDiagnosis];
                NSLog(@"Old diagnosis deleted with success!");
            } else {
                NSLog(@"Error, old diagnosis not deleted");
            }
        }];
        
    } else if ([oldVersion isKindOfClass:[CaseHistory class]] && [newVersion isKindOfClass:[CaseHistory class]]) {
        CaseHistory* oldCaseHistory = oldVersion;
        CaseHistory* newCaseHistory = newVersion;
        Envio* envio = [[Envio alloc]init];
        
        //Adds the past versions of the document in the versionHistory array of the new version
        [newCaseHistory.caseHistoryVersionHistory addObject:oldCaseHistory];
 //       [newCaseHistory.caseHistoryVersionHistory addObjectsFromArray:oldCaseHistory.caseHistoryVersionHistory];
        
        //Delete old version from table, and save new version if succeded
        [envio deleteCaseHistory:oldCaseHistory withCompletion:^(BOOL succeded){
            if(succeded){
                [envio newCaseHistory:newCaseHistory];
                NSLog(@"Old treatment deleted with success!");
            } else {
                NSLog(@"Error, old treatment not deleted");
            }
        }];
    } else if ([oldVersion isKindOfClass:[Exam class]] && [newVersion isKindOfClass:[Exam class]]) {
        Exam* oldExam = oldVersion;
        Exam* newExam = newVersion;
        Envio* envio = [[Envio alloc]init];
        
        //Adds the past versions of the document in the versionHistory array of the new version
        [newExam.examVersionHistory addObject:oldExam];
//      [newExam.examVersionHistory addObjectsFromArray:oldExam.examVersionHistory];
        
        //Delete old version from table, and save new version if succeded
        [envio deleteExam:oldExam withCompletion:^(BOOL succeded){
            if(succeded){
                [envio newExam:newExam];
                NSLog(@"Old treatment deleted with success!");
            } else {
                NSLog(@"Error, old treatment not deleted");
            }
        }];
    }
}

@end

