#import "AddJudgeVC.h"
#import "Persistance.h"
#import "Judge.h"

@interface AddJudgeVC ()

@end

@implementation AddJudgeVC{
    Judge *judge;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(dismissMe:)];
    btn.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = btn;
    
    if(_isEdit){
        judge = [[Persistance sharedInstance].lstJudges objectAtIndex:_editIndex];
        _txtName.text = judge.Name;
        _txtUserID.text = judge.UserID;
        _txtPassword.text = judge.Password;
        [_btnAddUpdate setTitle:@"Update" forState:UIControlStateNormal];
        self.navigationItem.title = @"Update Judge";
        
    }
}

-(void) dismissMe:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addJudge:(id)sender {
    if([_txtName.text isEqualToString:@""]){
        [self showError:@"Please enter name of judge"];
        return;
    }
    
    if([_txtUserID.text isEqualToString:@""]){
        [self showError:@"Please enter user id for judge"];
        return;
    }
    
    if([_txtPassword.text isEqualToString:@""]){
        [self showError:@"Please enter password for judge"];
        return;
    }
    
    // Save presenter in to the database
    Persistance *settings = [Persistance sharedInstance];
    Judge *j = [Judge new];
    j.Name = _txtName.text;
    j.UserID = _txtUserID.text;
    j.Password = _txtPassword.text;
    if(_isEdit)
        [settings.lstJudges replaceObjectAtIndex:_editIndex withObject:j];
    else
        [settings.lstJudges addObject:j];
    [settings synchronize];
    
    if(_isEdit)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateJudges" object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showError:(NSString *)msg{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
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
