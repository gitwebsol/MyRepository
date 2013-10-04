//
//  MapAnnotation.h
//  MKMapView
//
//  Created by rlwebsolutions on 1/12/13.
//  Copyright (c) 2013 rlwebsolutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface MapAnnotation : NSObject <MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
}
@property(nonatomic,assign) CLLocationCoordinate2D coordinate;
@property(nonatomic,retain) NSString *title;
@property(nonatomic,retain) NSString *subtitle;
@end
