//
//  HttpErrorHandler.h
//  Emerald
//
//  Created by Razvan on 6/15/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import <Foundation/Foundation.h>

//=======================================================================
// HttpErrorHandler - Public Interface
//=======================================================================
@interface HttpErrorHandler : NSObject

+ (void)displayError:(NSError *)error;

@end
