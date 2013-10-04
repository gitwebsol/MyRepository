#import "MyPageViewController.h"
#import "AsakaraAppDelegate.h"
#import "SettingViewController.h"
#import "HideTabBarClass.h"
#import "StampStoreViewController.h"
#import "ThemeStoreViewController.h"
#import "PremiumViewController.h"
#import "HistoryViewController.h"
#import "LoginViewController.h"
#import "AsakaraAppDelegate.h"

@implementation MyPageViewController

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    HideTabBarClass *hide=[[HideTabBarClass alloc]init];
    [hide hideTabBar];
    [hide release];
    
    [Table reloadData];
    
}

-(void)backTab{
    
    AsakaraAppDelegate *appDelegate = (AsakaraAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate backButtonTouched];
    
}

-(IBAction)NameChange{
    
    SettingViewController *detailViewController = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    
}

-(IBAction)StampStore{
    
    StampStoreViewController *detailViewController = [[StampStoreViewController alloc] initWithNibName:@"StampStoreViewController" bundle:nil];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    
}

-(IBAction)ThemeStore{
    
    ThemeStoreViewController *detailViewController = [[ThemeStoreViewController alloc] initWithNibName:@"ThemeStoreViewController" bundle:nil];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    
}

-(IBAction)Premium{
    
    PremiumViewController *detailViewController = [[PremiumViewController alloc] initWithNibName:@"PremiumViewController" bundle:nil];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    
}

-(IBAction)History{
    
    HistoryViewController *detailViewController = [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    
}

-(IBAction)Policy{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://talk.girlswalker.com/privacy"]];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"マイページ";
    
    UIBarButtonItem *backButton =[[UIBarButtonItem alloc]initWithTitle:@"戻る" style:UIBarButtonItemStylePlain target:self action:@selector(backTab)];
    self.navigationItem.leftBarButtonItem = backButton;
    [backButton release];
    
    Table.delegate=self;
    Table.dataSource=self;
}

-(CGFloat)tableView:(UITableView*)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 57.0;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text=@"ニックネーム";
            break;
        case 1:
            cell.textLabel.text=@"書き込み履歴";
            break;
        case 2:
            cell.textLabel.text=@"月額会員";
            break;
        case 3:
            cell.textLabel.text=@"スタンプ";
            break;
        case 4:
            cell.textLabel.text=@"テーマ";
            break;
        case 5:
            cell.textLabel.text=@"利用規約";
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [self NameChange];
            break;
        case 1:
            [self History];
            break;
        case 2:
            [self Premium];
            break;
        case 3:
            [self StampStore];
            break;
        case 4:
            [self ThemeStore];
            break;
        case 5:
            [self Policy];
            [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
            break;
        default:
            break;
    }
}

-(void)dealloc{
    
    [super dealloc];
    [Table release];
    
}

- (void)viewDidUnload{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
