//
//  Authentication.m
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/26/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import "Authentication.h"
#import "Parse.h"
#import "AppDelegate.h"
#import "Doctor.h"

@implementation Authentication

- (void) verifyAuthenticity:(NSString *) user :(NSString *) password :(void (^)(BOOL finished))completion{
    PFQuery *query = [PFQuery queryWithClassName:@"Users"];
    [query whereKey:@"username" equalTo:user];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                    self.granted = true;
                    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
                    Doctor* doctor = [[Doctor alloc] init];
                    doctor.doctorCRMString = object[@"CRM"];
                    doctor.doctorNameString = object[@"Nome"];
                    doctor.favTopicsArray = object[@"favForumTopics"];
                    doctor.sawTopicsArray = object[@"sawForumTopics"];
                    doctor.isFirstTime = [object[@"isFirstTime"] boolValue];
                    doctor.doctorEmailString = object[@"Email"];
                    doctor.doctorAddressString = object[@"Address"];
                    doctor.doctorPasswordString = object[@"password"];
                    doctor.doctorUsernameString = user;
                    doctor.doctorObjectId = object.objectId;
                    doctor.doctorContactString = object[@"Contact"];
                    PFFile* file = [object objectForKey:@"photo"];
                    if (file) doctor.doctorPhotoData = file.getData;
                    appDelegate.doctor = doctor;
            }
            if (self.granted) {
                completion(true);
            }else{
                completion(false);
                NSLog(@"404");
            }
        } else {
            completion(false);
        }
    }];
}


@end
