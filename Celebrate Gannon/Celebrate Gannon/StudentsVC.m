#import "StudentsVC.h"
#import "Presenter.h"
#import "Persistance.h"
#import "PresenterCell.h"
#import "AddPresenterVC.h"
#import "RattingsTabsVC.h"

@implementation StudentsVC{
    
NSMutableArray *items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    items = [Persistance sharedInstance].lstPresenters;
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)reloadAll:(NSNotification *) noti{
    items = [Persistance sharedInstance].lstPresenters;
    [self.tableView reloadData];
    
    
}

- (IBAction)closeMe:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void) dismissMe:(id)sender{
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
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PresenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Presenter *p = (Presenter *) [items objectAtIndex:indexPath.row];
    cell.lblName.text = p.Name;
    cell.lblTopic.text = [@"Topic: " stringByAppendingString:p.Topic];
    cell.lblLocation.text =[@"Location: " stringByAppendingString:p.Location];
    cell.lblDateTime.text =[[[@"on " stringByAppendingString:p.Date] stringByAppendingString:@" at "] stringByAppendingString:p.Time];
    cell.imgPhoto.image = p.image;
    cell.lblRating.layer.borderColor = [cell.lblRating.textColor CGColor];
    cell.lblRating.layer.cornerRadius = 10;
    cell.lblRating.layer.borderWidth = 2;
    cell.btnLike.selected = p.isLiked;
    cell.btnLike.tag = indexPath.row;
    
    [cell.btnLike addTarget:self action:@selector(btnLikeClick:) forControlEvents:UIControlEventTouchDown];
    
    NSArray *values = [p.rattings allValues];

    int totalScore = 0;
    int earnedScore = 0;

    for(int i=0; i<values.count; i++){
        
        PlatformScoring *score1 = [((NSArray *)[values objectAtIndex:i]) objectAtIndex:0];
        PosterScoring *score2 = [((NSArray *)[values objectAtIndex:i]) objectAtIndex:1];
        totalScore += [score1 getTotal] + [score2 getTotal];
        earnedScore += [score1 getScore] + [score2 getScore];
        
    }
    
    cell.lblRating.text = [[NSString alloc] initWithFormat:@"%d/%d", earnedScore, totalScore];
    return cell;
}

-(void)btnLikeClick:(id)sender{
    UIButton *btn = (UIButton *) sender;
    Presenter *p =  [items objectAtIndex:btn.tag];
    for(int i=0; i<items.count; i++){
        Presenter *pp = [items objectAtIndex:i];
        pp.isLiked = NO;
    }
    p.isLiked = !btn.selected;
    Persistance *set = [Persistance sharedInstance];
    set.lstPresenters = items;
    [set synchronize];
    
    btn.selected = !btn.selected;
    [self.tableView reloadData];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

//// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        [items removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        Persistance *p = [Persistance sharedInstance];
//        p.lstPresenters = items;
//        [p synchronize];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }
//}

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

//- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
//    if ([identifier isEqualToString:@"ShowRatting"]) {
//        
//        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
//        
//        NSMutableDictionary *rattings = ((Presenter *)[items objectAtIndex:indexPath.row]).rattings;
//        if([rattings objectForKey:self.currentJudge.Name] != nil){
//            [[[UIAlertView alloc] initWithTitle:@"Rattings" message:@"You have already rated this presenter..." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
//            return NO;
//        }
//    }
//    
//    return YES;
//}
//
//
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"StudentView"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        RattingsTabsVC *vc = (RattingsTabsVC *)segue.destinationViewController;
        vc.currentPresenterIndex = (int)indexPath.row;
        vc.isStudent = YES;
    }
    
}

@end
