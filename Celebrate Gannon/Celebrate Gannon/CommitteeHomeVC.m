#import "CommitteeHomeVC.h"

@interface CommitteeHomeVC ()

@end

@implementation CommitteeHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"Logout"
                                     style:UIBarButtonItemStylePlain target:self action:@selector(logout:)];;
    btn.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = btn;

}

-(void) logout:(id) sender{
    [self dismissViewControllerAnimated:YES completion:nil];
//    self.navigationController pop
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
