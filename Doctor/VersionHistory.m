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
        withNewVersion: (id)newVersion
{
    NSLog(@"UPDATE VERSION METHOD ENTERED");
    if ([oldVersion isKindOfClass:[Treatment class]] && [newVersion isKindOfClass:[Treatment class]]) {
        Treatment* oldTreatment = oldVersion;
        Treatment* newTreatment = newVersion;
        Envio* envio = [[Envio alloc]init];
        
        //Adds the past versions of the document in the versionHistory array of the new version
        [newTreatment.treatmentVersionHistory addObject:oldTreatment];
        [newTreatment.treatmentVersionHistory addObjectsFromArray:oldTreatment.treatmentVersionHistory];
        
        //Delete old version from table, and save new version if succeded
        [envio deleteTreatment:oldTreatment withCompletion:^(BOOL succeded){
            if(succeded){
                [envio newTreatment:newTreatment];
                NSLog(@"Old treatment deleted with success!");
            } else {
                NSLog(@"Error, old treatment not deleted");
            }
       }];
        
    }
    
}

@end

