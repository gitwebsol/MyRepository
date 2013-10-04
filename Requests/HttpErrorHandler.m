//
//  HttpErrorHandler.m
//  Emerald
//
//  Created by Razvan on 6/15/13.
//  Copyright (c) 2013 coltboy. All rights reserved.
//

#import "HttpErrorHandler.h"

//=======================================================================
// HttpErrorHandler - Implementation
//=======================================================================

@implementation HttpErrorHandler

+ (void)displayError:(NSError *)error {
    
    NSString *errorMessage = @"エラーが起きています。申し訳ございません。もう一度やり直してください。";
    
    if ([[error domain] isEqualToString:@"AFNetworkingErrorDomain"]) {
        
    //TO DO: return friendly user error message deppending on error code
        //AFNetworkReachabilityStatusNotReachable
        //        switch ([error code]) {
        //            case ￼:
        //                break;
        //            default:
        //                break;
        //        }
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:errorMessage
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                          otherButtonTitles:nil];
    [alert show];
}

@end
