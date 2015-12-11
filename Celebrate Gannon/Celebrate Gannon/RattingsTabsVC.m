#import "RattingsTabsVC.h"
#import "RattingCellVC.h"
#import "Persistance.h"
#import <IQKeyboardManager.h>

@implementation RattingsTabsVC{
    PlatformScoring *platform;
    PosterScoring *poster;
    NSMutableArray* options;
    BOOL isPlatform;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isPlatform = YES;
    if(_isStudent == NO){
        platform = [PlatformScoring new];
        poster = [PosterScoring new];
    }else{
        Persistance *settings = [Persistance sharedInstance];
        Presenter *p = [settings.lstPresenters objectAtIndex:_currentPresenterIndex];
        NSArray *arr = [[p.rattings allValues] lastObject];
        platform = [arr objectAtIndex:0];
        poster = [arr objectAtIndex:1];
        
    }
    
    options = [[NSMutableArray alloc] init];
    
    // add some sample data
    [options addObject:@"1"];
    [options addObject:@"2"];
    [options addObject:@"3"];
    [options addObject:@"4"];
    [options addObject:@"5"];
    
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]
                            initWithBarButtonSystemItem:(UIBarButtonSystemItemStop)
                            target:self
                            action:@selector(closeMe:)];
    
    btn.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = btn;
    
    if(_isStudent == NO){
        UIBarButtonItem *btnSubmit = [[UIBarButtonItem alloc] initWithTitle:@"Submit"
                                                                      style:UIBarButtonItemStylePlain target:self action:@selector(submitRate:)];
        btnSubmit.tintColor = [UIColor whiteColor];
        self.navigationItem.rightBarButtonItem = btnSubmit;
    }
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)submitRate:(id) sender{
//    for(int i=0; i<platform.items.count; i++){
//        RattingCellVC *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//        ScoringObject *obj = [platform.items objectAtIndex:i];
//        obj.Points = [cell.txtScore.text intValue];
//        [platform.items replaceObjectAtIndex:i withObject:obj];
//        
//    }
//    
//    for(int i=0; i<poster.items.count; i++){
//        RattingCellVC *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:1]];
//        ScoringObject *obj = [poster.items objectAtIndex:i];
//        obj.Points = [cell.txtScore.text intValue];
//        [poster.items replaceObjectAtIndex:i withObject:obj];
//        
//    }
    
    NSArray *arr = [NSArray arrayWithObjects:platform, poster, nil];
    
    Persistance *settings = [Persistance sharedInstance];
    Presenter *p = [settings.lstPresenters objectAtIndex:self.currentPresenterIndex];
    [p.rattings setValue:arr forKey:self.currentJudge.Name];
    [settings.lstPresenters replaceObjectAtIndex:self.currentPresenterIndex withObject:p];
    [settings synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshList" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)closeMe:(id) sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return isPlatform ? platform.items.count : poster.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RattingCellVC *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    // bind yourTextField to DownPicker
    
    if(_isStudent == NO){
        cell.downPicker = [[DownPicker alloc] initWithTextField:cell.txtScore withData:options];
        [cell.downPicker setPlaceholder:@"Rate"];
        cell.downPicker.tag = indexPath.row;
        cell.downPicker.tag = indexPath.row;
        [cell.downPicker addTarget:self
                                action:@selector(dp_Selected:)
                      forControlEvents:UIControlEventValueChanged];
    }
    ScoringObject *obj;
    
    if(isPlatform == YES){
        obj =[platform.items objectAtIndex:indexPath.row];
    }else{
        obj =[poster.items objectAtIndex:indexPath.row];
        
    }
    cell.title.text =  [[NSString alloc] initWithFormat:@"%ld. %@", (indexPath.row +1), obj.Criteria];
    cell.txtScore.text = [[NSString alloc] initWithFormat:@"%d",obj.Points];
    cell.txtScore.enabled = !_isStudent;
    
    return cell;
}

-(void)dp_Selected:(id)dp {
    DownPicker *dp1 = (DownPicker *) dp;
    NSString* selectedValue = [dp1 text];
    
    ScoringObject *obj;
    if(isPlatform){
        obj = [platform.items objectAtIndex:dp1.tag];
    }else{
        obj = [poster.items objectAtIndex:dp1.tag];
    }
    obj.Points = [selectedValue intValue];
    if(isPlatform){
        [platform.items replaceObjectAtIndex:dp1.tag withObject:obj];
    }else{
        [poster.items replaceObjectAtIndex:dp1.tag withObject:obj];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return isPlatform ? @"Platform" : @"Poster";
}

- (IBAction)changeView:(id)sender {
    UISegmentedControl *seg = (UISegmentedControl *) sender;
    if(seg.selectedSegmentIndex == 0)
        isPlatform = YES;
    else
        isPlatform = NO;
    
    [self.tableView reloadData];
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
