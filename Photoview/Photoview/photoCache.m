//
//  photoCache.m
//  Photoview
//
//  Created by Dan Jones on 9/16/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import "photoCache.h"
#import "FlickrFetcher.h"

@interface photoCache()
@property (nonatomic, strong) NSFileManager *fileManager;
@property (nonatomic, weak) NSURL *cacheURL;

#define MAX_CACHE_SIZE 10485760 // 10Mb
@end

@implementation photoCache
@synthesize fileManager = _fileManager;
@synthesize cacheURL = _cacheURL;

// Returns a file manager object
- (NSFileManager *)fileManager
{
    if (!_fileManager)
        _fileManager = [[NSFileManager alloc] init];
    return _fileManager;
}

- (void)setCacheURL:(NSURL *)cacheURL
{
    if (_cacheURL != cacheURL) {
        _cacheURL = cacheURL;
        BOOL isDir = NO;
        if (![self.fileManager fileExistsAtPath:[_cacheURL path] isDirectory:&isDir] || !isDir)
            [self.fileManager createDirectoryAtURL:_cacheURL withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSLog(@"self file maanger %@", _cacheURL);
    NSLog(@"self file maanger22 %@", cacheURL);
}

- (void)setupDirectory:(NSString *)url
{
   // NSDirectoryEnumerator *dirEnumerator = [self.fileManager
                                           // enumeratorAtURL:self.cacheURL
                                          //  includingPropertiesForKeys:[NSArray arrayWithObject:NSURLCreationDateKey]
                                          //  options:NSDirectoryEnumerationSkipsHiddenFiles
                                         //   errorHandler:nil];
   // NSLog(@"enum %@", dirEnumerator);/
    
    self.cacheURL = [[[self.fileManager URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject]URLByAppendingPathComponent:url isDirectory:YES];
}

- (NSURL *)findCachedPhoto:(NSDictionary *)photo
{
    NSString *photoID = [photo valueForKey:FLICKR_PHOTO_ID];
    NSString *photoPath = [[self.cacheURL URLByAppendingPathComponent:photoID] path];
    // if file doesn't exist create url for it
    if([self.fileManager fileExistsAtPath:photoPath])
    {
        return [self.cacheURL URLByAppendingPathComponent:photoID];
        //NSLog(@"didn'f find it");
        //return [self.cacheURL URLByAppendingPathComponent:photoID];
    }
    else
    {
        return nil;
    }
}

- (void)cachePhoto:(NSData *)photoData andWithPhotoDict:(NSDictionary *)photoDictionary
{
    if(![self findCachedPhoto:photoDictionary])
    {
        NSString *path = [[self findCachedPhoto:photoDictionary] path];
        NSString *photoID = [photoDictionary valueForKey:FLICKR_PHOTO_ID];
        NSString *photoPath = [[self.cacheURL URLByAppendingPathComponent:photoID] path];
        NSLog(@"the path %@", photoPath);
        [self.fileManager createFileAtPath:photoPath contents:photoData attributes:nil];
        [self setTheCache];
        
    }
}


- (void)setTheCache
{
    NSDirectoryEnumerator *enumerator = [self.fileManager enumeratorAtURL:self.cacheURL includingPropertiesForKeys:[NSArray arrayWithObject:NSURLCreationDateKey] options:NSDirectoryEnumerationSkipsHiddenFiles errorHandler:nil];
    NSLog(@"enumerator %@", enumerator);
    NSURL *fileURL;
    __block NSInteger directorySize = 0;
    NSMutableArray *fileArray = [NSMutableArray array];
    NSDictionary *fileDict;
    
    NSString *fileName;
       NSNumber *fileSize;
       NSDate *fileDate;
    for(fileURL in enumerator);
    {
        [fileURL getResourceValue:&fileName forKey:NSURLNameKey error:NULL];
     
        [fileURL getResourceValue:&fileSize forKey:NSURLFileSizeKey error:NULL];
     
        [fileURL getResourceValue:&fileDate forKey:NSURLCreationDateKey error:NULL];
        NSLog(@"file gettin %d", [fileSize integerValue]);
        NSLog(@"see file %c",
              [fileURL getResourceValue:&fileSize forKey:NSURLFileSizeKey error:NULL]);
        directorySize += [fileSize integerValue];
        fileDict = [[NSDictionary alloc] initWithObjectsAndKeys:fileURL,
                    @"url", fileSize, @"size", fileDate, @"date", nil];
        [fileArray addObject:fileDict];
       // NSLog(@"file %@", file);
    }
    NSLog(@"dir size %d", directorySize);
    if (directorySize > MAX_CACHE_SIZE) {
        NSArray *sorted = [fileArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [[obj1 valueForKey:@"date"] compare:[obj2 valueForKey:@"date"]];
        }];
        [sorted enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            directorySize -= [[obj valueForKey:@"size"] integerValue];
            [self.fileManager removeItemAtURL:[obj valueForKey:@"url"] error:nil];
            *stop = directorySize < MAX_CACHE_SIZE;
        }];
    }
   /* NSString *fileName;
    NSNumber *fileSize;
    NSDate *fileCreation;
    NSMutableArray *files = [NSMutableArray array];
    NSDictionary *fileData;
    __block NSUInteger dirSize = 0;
    for (NSURL *url in dirEnumerator) {
        [url getResourceValue:&fileName forKey:NSURLNameKey error:nil];
        [url getResourceValue:&fileSize forKey:NSURLFileSizeKey error:nil];
        [url getResourceValue:&fileCreation forKey:NSURLCreationDateKey error:nil];
        dirSize += [fileSize integerValue];
        fileData = [[NSDictionary alloc] initWithObjectsAndKeys:url,
                    @"url", fileSize, @"size", fileCreation, @"date", nil];
        [files addObject:fileData];
    }
    if (dirSize > MAX_FLICKR_CACHE_SIZE) {
        NSArray *sorted = [files sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [[obj1 valueForKey:@"date"] compare:[obj2 valueForKey:@"date"]];
        }];
        [sorted enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            dirSize -= [[obj valueForKey:@"size"] integerValue];
            [self.fileManager removeItemAtURL:[obj valueForKey:@"url"] error:nil];
            *stop = dirSize < MAX_FLICKR_CACHE_SIZE;
        }];
    }
    */
}

+ (photoCache *)createCacheWithURL:(NSString *)folder
{
    
    photoCache *cache = [[photoCache alloc] init];
    [cache setupDirectory:folder];
    return cache;
}



@end
