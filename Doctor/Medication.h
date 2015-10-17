//
//  Medication.h
//  Doctor
//
//  Created by Bruno Muniz Azevedo Filho on 10/17/15.
//  Copyright © 2015 Doctr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Medication : NSObject

@property (strong, nonatomic) NSString* medicationCategoryString;
@property (strong, nonatomic) NSString* medicationActivePrincipleString;
@property (strong, nonatomic) NSArray* medicationCommercialsArray;

@end
