//
//  Photo+Flickr.m
//  Photoview
//
//  Created by Dan Jones on 9/19/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import "Photo+Flickr.h"
#import "FlickrFetcher.h"
#import "Photo.h"
#import "Place+Create.h"
#import "Tag+Create.h"
#import "vacationHelper.h"
#import "Place.h"
#import "Tag.h"

@implementation Photo (Flickr)



+ (Photo *)photoWithFlickrInfo:(NSDictionary *)flickrInfo
        inManagedObjectContext:(NSManagedObjectContext *)context
{
    Photo *photo = nil;
   // NSLog(@"flicker info %@", flickrInfo);
    //NSLog(@"add photo id %@", [flickrInfo objectForKey:FLICKR_PHOTO_ID]);
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.predicate = [NSPredicate predicateWithFormat:@"unique = %@", [flickrInfo objectForKey:FLICKR_PHOTO_ID]];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || ([matches count] > 1)) {
        // handle error
    }
    // add it, not found
    else if ([matches count] == 0) {
        NSLog(@"adding it");
        photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
        photo.unique = [flickrInfo objectForKey:FLICKR_PHOTO_ID];
        photo.title = [flickrInfo objectForKey:FLICKR_PHOTO_TITLE];
        photo.subtitle = [flickrInfo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
        photo.imageurl = [[FlickrFetcher urlForPhoto:flickrInfo format:FlickrPhotoFormatLarge] absoluteString];
        //photo.inplace = [flickrInfo objectForKey:FLICKR_PHOTO_PLACE_NAME];
        NSLog(@"flickr infor %@", flickrInfo);
        photo.inplace = [Place placeWithName:[flickrInfo objectForKey:FLICKR_PHOTO_PLACE_NAME] inManagedObjectContext:context];
        NSLog(@"phot in place set %@", photo.inplace);
        photo.tags = [Tag tagWithName:[flickrInfo objectForKey:FLICKR_TAGS] inManagedObjectContext:context];
        NSLog(@"tags setn %@", [flickrInfo objectForKey:FLICKR_TAGS]);
       // photo.whoTook = [Photographer photographerWithName:[flickrInfo objectForKey:FLICKR_PHOTO_OWNER] inManagedObjectContext:context];
        
        NSLog(@"all matches when adding%@", matches);
    }
    // it exists
    else {
        NSLog(@"exists already");
        photo = [matches lastObject];
        NSLog(@"all matches not adding, exists%@", matches);
    }
    
    return photo;
}

+ (NSString *)checkPhotoExists:(NSDictionary *)photo inContext:(NSManagedObjectContext *)context
{
    Photo *ourphoto;
    //Photo *test = nil;
    NSString *exists;
    //NSLog(@"check photo %@", photo);
    //NSLog(@"check id %@", [photo objectForKey:FLICKR_PHOTO_ID]);
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.predicate = [NSPredicate predicateWithFormat:@"unique = %@", [photo objectForKey:FLICKR_PHOTO_ID]];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || ([matches count] > 1)) {
        // handle error
    }
    // add it, not found
    else if ([matches count] == 0) {
        NSLog(@"not found, visit it");
        NSLog(@"checking matches not exist %@", matches);
        exists = @"Visit";
    }
    // it exists
    else {
        ourphoto = [matches lastObject];
        NSLog(@"photo already here, matches %@", matches);
        NSLog(@"already here, option to unvisit");
        NSLog(@"photo found %@", matches);
        exists = @"Unvisit";
    }
    
    return exists;
}

+ (void)deletePhoto:(NSDictionary *)photo inContext:(NSManagedObjectContext *)context
{
    Photo *photoToDelete = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.predicate = [NSPredicate predicateWithFormat:@"unique = %@", [photo objectForKey:FLICKR_PHOTO_ID]];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || ([matches count] > 1)) {
        // handle error
    }
    // add it, not found
    else if ([matches count] == 0) {
        NSLog(@"not found, can't delete");
        
    }
    // it exists
    else {
        NSLog(@"already here, delete it");
        
        photoToDelete = [matches lastObject];
        NSLog(@"matches when deleting %@", matches);
        NSLog(@"phototodelete %@", photoToDelete);
        [photoToDelete.managedObjectContext deleteObject:photoToDelete];
    
    }

}


+ (void)returnPhotos
{
    
}


@end
