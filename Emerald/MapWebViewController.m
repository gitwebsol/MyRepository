//
//  MapWebViewController.m
//  Emerald
//
//  Created by Razvan on 7/3/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import "MapWebViewController.h"
#import "SVProgressHUD.h"

//=======================================================================
// MapWebViewController - Private Interface
//=======================================================================
@interface MapWebViewController ()

@end

//=======================================================================
// MapWebViewController - Implementation
//=======================================================================
@implementation MapWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   // [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
    
    NSMutableArray *locations = [[NSMutableArray alloc] init];
    
    NSURL *url = [NSURL URLWithString:@"http://www.iblazing.com/client/MyAnnotations/MyAnnotations.xml"];
    NSArray *plistdata =
    [NSArray arrayWithContentsOfURL:url];
    for (int i=0; i<[plistdata count]; i++) {
        MapAnnotation *myAnnotation = [[MapAnnotation alloc] init];
        float realLatitude = [[[plistdata objectAtIndex:i] objectForKey:@"latitude"] floatValue];
        float realLongitude = [[[plistdata objectAtIndex:i] objectForKey:@"longitude"] floatValue];
        
        CLLocationCoordinate2D theCoordinate;
        theCoordinate.latitude = realLatitude;
        theCoordinate.longitude = realLongitude;
        myAnnotation.coordinate = theCoordinate;
        myAnnotation.title = [[plistdata objectAtIndex:i] objectForKey:@"title"];
        myAnnotation.subtitle = [[plistdata objectAtIndex:i] objectForKey:@"subtitle"];
        [_mapView addAnnotation:myAnnotation];
        [locations addObject:myAnnotation];
        
    }

   
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 2000000, 2000000);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = userLocation.coordinate;
    point.title = @"Current Location";
    
    [self.mapView addAnnotation:point];
}

-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation {
    MKPinAnnotationView *pinView = nil;
    
    if(annotation != _mapView.userLocation) {
        static NSString *defaultPinID = @"com.invasivecode.pin";
        pinView = (MKPinAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinView == nil ) pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID];
        
        pinView.pinColor = MKPinAnnotationColorPurple;
        pinView.canShowCallout = YES;
        pinView.animatesDrop = YES;
    }
    else {
        [_mapView.userLocation setTitle:@"I am here"];
    }
    
    return pinView;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {

    [super viewDidUnload];
    
   
}

//=======================================================================
// UIWebViewDelegate methods
//=======================================================================
#pragma mark - UIWebViewDelegate methods
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [SVProgressHUD dismiss];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                   message:error.localizedDescription
                                                  delegate:nil
                                         cancelButtonTitle:@"Ok"
                                         otherButtonTitles:nil];
    [alert show];
}

//=======================================================================
// IBAction methods
//=======================================================================
#pragma mark - IBAction methods
- (IBAction)backBtnPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

@end
