#import "AddPresenterVC.h"
#import "Persistance.h"
#import "Presenter.h"

@interface AddPresenterVC ()

@end

@implementation AddPresenterVC{
    Presenter *presenter;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(dismissMe:)];
    btn.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = btn;
    
    if(_isEdit){
        presenter = [[Persistance sharedInstance].lstPresenters objectAtIndex:_editIndex];
        _txtName.text = presenter.Name;
        _txtTopic.text = presenter.Topic;
        _txtDate.text = presenter.Date;
        _txtTime.text = presenter.Time;
        _txtLocation.text = presenter.Location;
        _imgPhoto.image = presenter.image;
        [_btnAddUpdate setTitle:@"Update" forState:UIControlStateNormal];
        self.navigationItem.title = @"Update Presenter";

    }

}

-(void) dismissMe:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imgPhoto.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


- (IBAction)addPhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (IBAction)addPresenter:(id)sender {
    if([_txtName.text isEqualToString:@""]){
        [self showError:@"Please enter name of presenter"];
        return;
    }
    
    if([_txtTopic.text isEqualToString:@""]){
        [self showError:@"Please enter topic of presentation"];
        return;
    }
    
    if([_txtDate.text isEqualToString:@""]){
        [self showError:@"Please enter date of presentation"];
        return;
    }
    
    if([_txtTime.text isEqualToString:@""]){
        [self showError:@"Please enter time of presentation"];
        return;
    }
    
    if([_txtLocation.text isEqualToString:@""]){
        [self showError:@"Please enter location of presentation"];
        return;
    }
    
    if(_imgPhoto.image == nil){
        [self showError:@"Please add photo first to add this presenter"];
        return;
    }
    
    // Save presenter in to the database
    Persistance *settings = [Persistance sharedInstance];
    Presenter *p = [Presenter new];
    p.rattings = [NSMutableDictionary new];
    p.Name = _txtName.text;
    p.Topic = _txtTopic.text;
    p.Date = _txtDate.text;
    p.Time = _txtTime.text;
    p.Location = _txtLocation.text;
    p.image = _imgPhoto.image;
    if(_isEdit)
        [settings.lstPresenters replaceObjectAtIndex:_editIndex withObject:p];
    else
        [settings.lstPresenters addObject:p];
    [settings synchronize];

    if(_isEdit)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdatePresenters" object:nil];
    
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
