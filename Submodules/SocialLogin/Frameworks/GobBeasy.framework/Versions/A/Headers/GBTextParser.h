//
//  GBTextParser.h
//  GobBeasy
//
//  Created by Matteo Gobbi on 20/10/12.
//  Copyright (c) 2012 Matteo Gobbi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBTextParser : NSObject {
    
}

+ (NSString *)parseStringFromText:(NSString *)text betweenTagString:(NSString *)tag1 andTagString:(NSString *)tag2;
+ (NSString *)parseStringFromText:(NSString *)text betweenTagString:(NSString *)tag1 andTagString:(NSString *)tag2 afterFirstOcccurenceOfString:(NSString *)afterString;

+ (NSMutableArray *)parseArrayStringFromText:(NSString *)text betweenTagString:(NSString *)tag1 andTagString:(NSString *)tag2;
+ (NSMutableArray *)parseArrayStringFromText:(NSString *)text betweenTagString:(NSString *)tag1 andTagString:(NSString *)tag2 afterFirstOcccurenceOfString:(NSString *)afterString;

@end

