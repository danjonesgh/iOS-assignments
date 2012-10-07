//
//  Photo+Flickr.h
//  Photoview
//
//  Created by Dan Jones on 9/19/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import "Photo.h"

@interface Photo (Flickr)



+ (Photo *)photoWithFlickrInfo:(NSDictionary *)flickrInfo
        inManagedObjectContext:(NSManagedObjectContext *)context;

+ (NSString *)checkPhotoExists:(NSDictionary *)photo inContext:(NSManagedObjectContext *)context;

+ (void)deletePhoto:(NSDictionary *)photo inContext:(NSManagedObjectContext *)context;

+ (void)returnPhotos;

@end
