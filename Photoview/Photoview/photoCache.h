//
//  photoCache.h
//  Photoview
//
//  Created by Dan Jones on 9/16/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface photoCache : NSObject


+ (photoCache *)createCacheWithURL:(NSString *)folder;
- (void)cachePhoto:(NSData *)photoData andWithPhotoDict:(NSDictionary *)photoDictionary;
- (NSURL *)findCachedPhoto:(NSDictionary *)photo;





@end

