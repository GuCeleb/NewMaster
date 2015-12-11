#import <UIKit/UIKit.h>
#import "PosterScoring.h"
#import "PlatformScoring.h"
#import "Judge.h"
#import "Presenter.h"

#import "DownPicker.h"


@interface RattingsTabsVC : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) Judge *currentJudge;
@property (nonatomic, assign) int currentPresenterIndex;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL isStudent;

@end
