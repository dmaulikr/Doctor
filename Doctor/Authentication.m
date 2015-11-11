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
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    [query whereKey:@"username" equalTo:user];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                if ([object[@"password"] isEqualToString:password]) {
                    self.granted = true;
                    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
                    Doctor* doctor = [[Doctor alloc] init];
                    doctor.doctorCRMString = object[@"CRM"];
                    doctor.doctorNameString = object[@"Nome"];
                    doctor.favTopicsArray = object[@"favForumTopics"];
                    appDelegate.doctor = doctor;
                }else{
                    self.granted = false;
                    NSLog(@"Wrong");
                }
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
