#import <Foundation/Foundation.h>

@interface Authentication : NSObject

- (void) verifyAuthenticity:(NSString *) user :(NSString *) password :(void (^)(BOOL finished))completion;

@property (nonatomic) BOOL granted;

@end
