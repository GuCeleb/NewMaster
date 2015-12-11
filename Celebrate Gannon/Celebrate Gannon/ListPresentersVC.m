#import "ListPresentersVC.h"
#import "Presenter.h"
#import "Persistance.h"
#import "PresenterCell.h"
#import "AddPresenterVC.h"

@interface ListPresentersVC ()

@end

@implementation ListPresentersVC{
    NSMutableArray *items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    items = [Persistance sharedInstance].lstPresenters;
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(dismissMe:)];
    btn.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = btn;

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMe:) name:@"UpdatePresenters" object:nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    cell.imgPhoto.image = p.image;
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
        p.lstPresenters = items;
        [p synchronize];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"EditPresenter"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        AddPresenterVC *vc = (AddPresenterVC *)segue.destinationViewController;
        vc.isEdit = YES;
        vc.editIndex = (int)indexPath.row;
    }

}

@end
