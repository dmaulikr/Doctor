#import <UIKit/UIKit.h>
@protocol ExamChooseTypeTableViewControllerDelegate <NSObject>
- (void) didMakeSelectionExamType:(NSString *)typeSelected;
@end

@interface ExamChooseTypeTableViewController : UITableViewController
@property (nonatomic, weak) id <ExamChooseTypeTableViewControllerDelegate> delegate;
@end
