#import <UIKit/UIKit.h>

@interface AddJudgeVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtUserID;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnAddUpdate;


@property (nonatomic, assign) int editIndex;
@property (nonatomic, assign) BOOL isEdit;

@end
