#import <UIKit/UIKit.h>
#import "Patient.h"
#import "Exam.h"

@interface PatientSelectedExamSelectedTableViewController : UITableViewController

@property (strong, nonatomic) Patient* patient;
@property (strong, nonatomic) Exam* exam;

@end
