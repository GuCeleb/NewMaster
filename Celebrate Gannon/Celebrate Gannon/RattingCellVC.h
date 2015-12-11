#import <UIKit/UIKit.h>
#import "DownPicker.h"

@interface RattingCellVC : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UITextField *txtScore;
@property (strong, nonatomic) DownPicker *downPicker;


@end
