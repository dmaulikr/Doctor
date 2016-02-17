#import <UIKit/UIKit.h>


@protocol ExamChooseInsuranceTableViewControllerDelegate <NSObject>
- (void)didMakeSelection:(NSString *)insuranceSelected;
@end

@interface ExamChooseInsuranceTableViewController : UITableViewController

@property (nonatomic, weak) id<ExamChooseInsuranceTableViewControllerDelegate> delegate;

@end
