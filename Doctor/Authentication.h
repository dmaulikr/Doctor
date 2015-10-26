//
//  Authentication.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/26/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Authentication : NSObject

- (void) verifyAuthenticity:(NSString *) user :(NSString *) password :(void (^)(BOOL finished))completion;

@property (nonatomic) BOOL granted;

@end
