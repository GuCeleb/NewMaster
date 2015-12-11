#import "ListJudgesVC.h"
#import "Judge.h"
#import "Persistance.h"
#import "AddJudgeVC.h"

@interface ListJudgesVC ()

@end

@implementation ListJudgesVC{
    NSMutableArray *items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    items = [Persistance sharedInstance].lstJudges;
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(dismissMe:)];
    btn.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = btn;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMe:) name:@"UpdateJudges" object:nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)updateMe:(NSNotification *) noti{
    items = [Persistance sharedInstance].lstJudges;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Judge *j = [items objectAtIndex:indexPath.row];
    cell.textLabel.text = j.Name;
    cell.textLabel.textColor = [UIColor colorWithRed:159.0/255.0 green:27.0/255.0 blue:51.0/255.0 alpha:1];
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;

}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [items removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        Persistance *p = [Persistance sharedInstance];
        p.lstJudges = items;
        [p synchronize];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"EditJudge"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        AddJudgeVC *vc = (AddJudgeVC *)segue.destinationViewController;
        vc.isEdit = YES;
        vc.editIndex = (int)indexPath.row;
    }
    
}

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

@end
