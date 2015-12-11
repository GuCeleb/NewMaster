#import "CommitteeLoginVC.h"
#import "Persistance.h"
#import "PresentersListMainVC.h"
@interface CommitteeLoginVC ()

@end

@implementation CommitteeLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer* tapBackground = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [tapBackground setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:tapBackground];
    if(self.navigationController.title != nil){
        self.isJudge = YES;
        self.lblTitle.text = @"Judge's Login";
    }
}

-(void)dismissKeyboard:(id)sender{
    [self.view endEditing:YES];
    
}

- (IBAction)dismissMe:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    Persistance *settings = [Persistance sharedInstance];
    NSString *username = settings.comLogin;
    NSString *pass = settings.comPassword;
    
    if(self.isJudge){
        if(settings.lstJudges.count == 0){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"No Judge is defined yet for login" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            return;
            
        }
        BOOL isInvalidPass = NO;
        
        for(int i=0; i<settings.lstJudges.count; i++){
            Judge *jj = [settings.lstJudges objectAtIndex:i];
            username = jj.UserID;
            pass = jj.Password;
            
            if ( [_txtUsername.text isEqualToString:username] && [_txtPassword.text isEqualToString:pass] ){
                isInvalidPass = NO;
                PresentersListMainVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"JudgePresenterVC"];
                vc.currentJudge = jj;
                
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }else{
                isInvalidPass = YES;
            }
        }
        
        if(isInvalidPass){
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error1" message:@"Username or password is invalid" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
        

    
    }else{
        if ( [_txtUsername.text isEqualToString:username] && [_txtPassword.text isEqualToString:pass] ){
            UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ComHomeVC"];
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Username or password is invalid" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }

    }
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
