#import <Foundation/Foundation.h>

@interface Medication : NSObject

@property (strong, nonatomic) NSString* medicationCategoryString;
@property (strong, nonatomic) NSString* medicationActivePrincipleString;
@property (strong, nonatomic) NSArray* medicationCommercialsArray;
@property (strong, nonatomic) NSString* medicationObjectId;

@end
