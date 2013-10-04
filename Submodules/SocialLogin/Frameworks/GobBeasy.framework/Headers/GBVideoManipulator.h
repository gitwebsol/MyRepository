//
//  VideoManipulator.h
//  gobbeasy
//
//  Created by Matteo Gobbi on 12/10/12.
//  Copyright (c) 2012 Matteo Gobbi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface GBVideoManipulator : NSObject {
    
}

+ (UIImage *)grabImageFromVideoURL:(NSURL *)videoURL atTime:(float)seconds;

@end
