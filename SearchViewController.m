//
//  SearchViewController.m
//  Emerald
//
//  Created by Razvan on 6/3/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import "SearchViewController.h"
#import "User.h"

//=======================================================================
// SearchViewController - Private Interface
//=======================================================================
@interface SearchViewController ()

@property (nonatomic, strong) NSMutableArray *usersArray;

@end

//=======================================================================
// SearchViewController - Implementation
//=======================================================================
@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _usersArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    _tableV = nil;
    _searchBar = nil;
    [super viewDidUnload];
}

//=======================================================================
// UITableViewDataSource methods
//=======================================================================
#pragma mark - UITableViewDataSource methods
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = [NSString stringWithFormat:@"CellFeed"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    User *currentUser = [self.usersArray objectAtIndex:indexPath.row];
    cell.textLabel.text = currentUser.name;
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:currentUser.imageURL]]];;
    
    return cell;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.usersArray.count;
}

//=======================================================================
// UITableViewDelegate methods
//=======================================================================
#pragma mark - UITableViewDelegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


//=======================================================================
// UISearchBarDelegate methods
//=======================================================================
#pragma mark - UISearchBarDelegate methods
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *searchTxt = [searchBar.text copy];
    searchBar.text = @"";
    [searchBar resignFirstResponder];
    [self retrieveDataForSearchedText:searchTxt];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSString *searchTxt = searchBar.text;
    
    if (searchTxt == nil || [searchTxt isEqualToString:@""]) {
        [searchBar resignFirstResponder];
    }
}

//=======================================================================
// Retrieving data methods
//=======================================================================
#pragma mark - Retrieving data methods
- (void)retrieveDataForSearchedText:(NSString *)searchTerm {

    [self.usersArray removeAllObjects];
    
    NSString *controllerMethod = @"users/json";
    NSString *path = [NSString stringWithFormat:@"%@/value=%@", controllerMethod, searchTerm];
    
    [[DataManager sharedInstance] getRequestWithParameters:nil
                                                    atPath:path
                                                   inBlock:^(id searchResults){
                                             
        if ([searchResults respondsToSelector:@selector(objectAtIndex:)]) {
            for (NSDictionary *info in (NSArray *)searchResults) {
                User *user = [[User alloc] initWithInfo:[info objectForKey:@"Theme"]];
                [self.usersArray addObject:user];
            }
            
            //Dispaly results and refresh tableview
            [_tableV reloadData];
        }
    }];
}

@end
