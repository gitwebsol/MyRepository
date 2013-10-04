//
//  SearchViewController.h
//  Emerald
//
//  Created by Razvan on 6/3/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

//=======================================================================
// SearchViewController - Public Interface
//=======================================================================
@interface SearchViewController : UIViewController  <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>{
    
    __weak IBOutlet UITableView *_tableV;
    __weak IBOutlet UISearchBar *_searchBar;
}

@end
