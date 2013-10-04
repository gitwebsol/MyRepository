//
//  MapWebViewController.h
//  Emerald
//
//  Created by Razvan on 7/3/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapAnnotation.h"
#import <MapKit/MapKit.h>
//=======================================================================
// MapWebViewController - Public Interface
//=======================================================================
@interface MapWebViewController : UIViewController <UIWebViewDelegate,MKMapViewDelegate,MKAnnotation>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSDictionary *articleContent;

@end
