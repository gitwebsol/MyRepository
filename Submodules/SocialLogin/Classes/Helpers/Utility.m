//
//  Utility.m
//  suregift
//
//  Created by Matteo Gobbi on 21/12/12.
//  Copyright (c) 2012 Matteo Gobbi. All rights reserved.
//

#import "Utility.h"


@implementation Utility

+ (NSString *) encryptString:(NSString*)plaintext {
    
    NSString *string = [FBEncryptorAES encryptBase64String:plaintext
                                                 keyString:kKey
                                             separateLines:NO];
    
    
    //Codifico la stringa pronta per l'invio via GET o POST
    string = [self URLEncodedString_ch:string];
    
	return string;
}


+ (NSString *) decryptString:(NSString*)ciphertext {
    return [FBEncryptorAES decryptBase64String:ciphertext keyString:kKey];
}


+ (NSString *) encryptData:(NSData *)data urlEncode:(BOOL)encode{
    
    NSString *string = [FBEncryptorAES encryptBase64Data:data
                                                 keyString:kKey
                                             separateLines:NO];
    
    
    //Codifico la stringa pronta per l'invio via GET o POST
    if(encode)
        string = [self URLEncodedString_ch:string];
    
	return string;
}

+ (NSData *) decryptStringToData:(NSString*)ciphertext {
    return [FBEncryptorAES decryptBase64StringToData:ciphertext keyString:kKey];
}

+ (NSString *) URLEncodedString_ch:(NSString *)string {
    //return string;
    NSMutableString * output = [NSMutableString string];
    const unsigned char * source = (const unsigned char *)[string UTF8String];
    int sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    
    return output;
}


//Genera un id device legato all'application identifier
+ (NSString *) getDeviceAppId
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *value = [defaults objectForKey:DEVICE_APP_ID];
    
    if (!value)
    {
        value = (NSString *) CFUUIDCreateString (NULL, CFUUIDCreate(NULL));
        [defaults setValue: value forKey: DEVICE_APP_ID];
        [defaults synchronize];
    }
    
    return value;
}

+ (NSString *) getDeviceToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *value = [defaults objectForKey:DEVICE_PUSH_TOKEN];
    
    if (!value)
    {
        value = @"";
        [defaults setValue:value forKey: DEVICE_PUSH_TOKEN];
        [defaults synchronize];
    }
    
    return value;
}

+ (NSString *) getSession
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *value = [defaults objectForKey:USER_SESSION];
    
    if (!value)
    {
        value = @"";
        [defaults setValue:value forKey: USER_SESSION];
        [defaults synchronize];
    }
    
    return value;
}


//General
+ (void) setDefaultValue:(NSString *)value forKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:value forKey:key];
    [defaults synchronize];
}

+ (NSString *) getDefaultValueForKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *value = [defaults objectForKey:key];
    
    if (!value)
    {
        value = @"";
        [defaults setValue:value forKey: key];
        [defaults synchronize];
    }
    
    return value;
}

+(void)logout {
    //Sloggo e cancello user default facebook
    if(FBSession.activeSession.isOpen)
        [FBSession.activeSession closeAndClearTokenInformation];
    
    //Cancello user default sessione etc.
    [self setDefaultValue:@"" forKey:USER_SESSION];
    [self setDefaultValue:@"" forKey:USER_FACEBOOK_LOGIN];
    [self setDefaultValue:@"" forKey:USER_IMG_PROFILE];
}


@end
