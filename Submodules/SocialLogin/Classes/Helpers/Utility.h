//
//  Utility.h
//  suregift
//
//  Created by Matteo Gobbi on 21/12/12.
//  Copyright (c) 2012 Matteo Gobbi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

#import "NSData+Base64.h"
#import "FBEncryptorAES.h"


@interface Utility : NSObject
{
    
}

+(NSString *)encryptString:(NSString *)string;
+(NSString *)decryptString:(NSString*)ciphertext;
+ (NSString *) encryptData:(NSData *)data urlEncode:(BOOL)encode;
+ (NSData *) decryptStringToData:(NSString*)ciphertext;
+ (NSString *) URLEncodedString_ch:(NSString *)string;
+ (NSString *) getDeviceAppId;
+ (NSString *) getDeviceToken;
+ (NSString *) getSession;

+ (void) setDefaultValue:(NSString *)value forKey:(NSString *)key;
+ (NSString *) getDefaultValueForKey:(NSString *)key;

+(void)logout;

@end