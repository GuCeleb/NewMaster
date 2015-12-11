#import <UIKit/UIKit.h>

@interface CommitteeLoginVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (nonatomic, assign) BOOL isJudge;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end
