#import "PresentersListMainVC.h"
#import "Presenter.h"
#import "Persistance.h"
#import "PresenterCell.h"
#import "AddPresenterVC.h"
#import "RattingsTabsVC.h"

@interface PresentersListMainVC ()

@end

@implementation PresentersListMainVC{
    NSMutableArray *items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    items = [Persistance sharedInstance].lstPresenters;
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMe:) name:@"UpdatePresenters" object:nil];
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"Logout"
                                                            style:UIBarButtonItemStylePlain target:self action:@selector(logout:)];;
    btn.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = btn;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadAll:) name:@"RefreshList" object:nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)reloadAll:(NSNotification *) noti{
    items = [Persistance sharedInstance].lstPresenters;
    [self.tableView reloadData];

    
}


-(void) logout:(id) sender{
    [self dismissViewControllerAnimated:YES completion:nil];
    //    self.navigationController pop
}

-(void)updateMe:(NSNotification *) noti{
    items = [Persistance sharedInstance].lstPresenters;
    [self.tableView reloadData];
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
    if([p.rattings objectForKey:self.currentJudge.Name] == nil){
        cell.lblRating.text = @"Not Rated";
    }else{
        // Calculate accumulative Score
        PlatformScoring *score1 = [((NSArray *)[p.rattings objectForKey:self.currentJudge.Name]) objectAtIndex:0];
        PosterScoring *score2 = [((NSArray *)[p.rattings objectForKey:self.currentJudge.Name]) objectAtIndex:1];
        
        int totalScore = [score1 getTotal] + [score2 getTotal];
        int earnedScore = [score1 getScore] + [score2 getScore];
        
        cell.lblRating.text = [[NSString alloc] initWithFormat:@"%d/%d", earnedScore, totalScore];
    }
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
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

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"ShowRatting"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];

        NSMutableDictionary *rattings = ((Presenter *)[items objectAtIndex:indexPath.row]).rattings;
        if([rattings objectForKey:self.currentJudge.Name] != nil){
            [[[UIAlertView alloc] initWithTitle:@"Rattings" message:@"You have already rated this presenter..." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            return NO;
        }
    }
    
    return YES;
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowRatting"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        RattingsTabsVC *vc = (RattingsTabsVC *)segue.destinationViewController;
        vc.currentPresenterIndex = (int)indexPath.row;
        vc.currentJudge = self.currentJudge;
    }
    
}

@end
