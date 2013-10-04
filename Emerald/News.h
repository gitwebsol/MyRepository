//
//  News.h
//  Emerald
//
//  Created by ColtBoys on 12/21/12.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareTools.h"
#import "ClassicFeed.h"
#import "FullScreenArticle.h"
#import "LocalData.h"
#import "ODRefreshControl.h"
@interface News : UIViewController <UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate,ClassicFeedDelegate,UIScrollViewDelegate, UISearchBarDelegate>{
    IBOutlet UITableView *tableV;
    IBOutlet UILabel *lblTitleNav;
    IBOutlet UIView *viewHeader;
    NSMutableArray *dataTable;
    ShareTools *sharing;
    ClassicFeed *feedLoader;
    BOOL isHeaderHidden;
    ODRefreshControl *refreshControl;
    UIActivityIndicatorView *loading;
    UIView *viewNetworkError;
    __weak IBOutlet UISegmentedControl *segmentedControl;
}
@property (weak, nonatomic) IBOutlet UISearchBar *searchBarObj;
@property (nonatomic,retain) NSString *XMLsource;
@end
