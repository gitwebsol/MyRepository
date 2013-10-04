//
//  MixedParser.m
//  suregift
//
//  Created by Matteo Gobbi on 11/01/13.
//  Copyright (c) 2013 Matteo Gobbi. All rights reserved.
//

#import "RequestParser.h"

@interface RequestParser () {
    NSMutableData *receivedData_;
}

- (NSData *)encodeDictionary:(NSMutableDictionary *)param;

@end

@implementation RequestParser

@synthesize strURL;

-(id)init {
    self = [super init];
    if(self) {
        //Alloco e azzero dictionary  
        dictParam = [[NSMutableDictionary alloc] init];
        return self;
    }
    return nil;
}

- (void)threadDidStart {
    NSURL * url = [NSURL URLWithString:strURL];
    NSData *postData = [self encodeDictionary:dictParam];
    
    // Create the request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:10.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"%d", postData.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    //NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    //[connection start];

    
    NSError *error;
    NSURLResponse *response;
    NSData *connectionData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    
    NSMutableDictionary *responseDict = [[NSMutableDictionary alloc] init];
    
    if(!connectionData) {
        //Connessione fallita
        [responseDict setValue:ERROR_CONNECTION forKey:ERROR_KEY];
    } else {
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        responseDict = [parser objectWithData:connectionData];
        [parser release], parser = nil;
    }
    
    [self performSelectorOnMainThread:@selector(threadDidEnd:) withObject:responseDict waitUntilDone:NO];
    
}

- (void)addPostValue:(NSString *)value forKey:(NSString *)key {
    [dictParam setValue:value forKey:key];
}

- (NSData *)encodeDictionary:(NSMutableDictionary *)param {
    NSString *post_string = @"";
    
    for (NSString* key in param) {
        NSString *value = param[key];
        NSString *appending = [NSString stringWithFormat:@"&%@=%@",key,value];
        post_string = [post_string stringByAppendingString:appending];
        
    }
    NSData *postData = [post_string dataUsingEncoding:NSUTF8StringEncoding];
    return postData;
}

/*
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [receivedData_ setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData_ appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *responseDict = [parser objectWithData:receivedData_];
    [parser release], parser = nil;
    
    [self performSelectorOnMainThread:@selector(threadDidEnd:) withObject:responseDict waitUntilDone:NO];
}
 */


- (void)viewDidUnload {
    self.strURL = nil;
}

- (void)dealloc {
    [strURL release];
    [dictParam release];
    [super dealloc];
}

@end
