#import <UIKit/UIKit.h>
#import "Patient.h"


@protocol PatientSelectedTableViewControllerDelegate <NSObject>

- (void) askedForRefresh;

@end
@interface PatientSelectedTableViewController : UITableViewController

@property (nonatomic, strong) Patient* patient;
@property (nonatomic, strong) id <PatientSelectedTableViewControllerDelegate> delegate;

@end
