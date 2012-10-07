//
//  photoAnnotation.m
//  Photoview
//
//  Created by Dan Jones on 9/9/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import "photoAnnotation.h"
#import "FlickrFetcher.h"

@implementation photoAnnotation

@synthesize photo = _photo;

+ (photoAnnotation *)annotationForPhoto:(NSDictionary *)photo
{
    photoAnnotation *annotation = [[photoAnnotation alloc] init];
    annotation.photo = photo;
    return annotation;
}

+ (photoAnnotation *)annotationForPlace
{
    photoAnnotation *annotation = [[photoAnnotation alloc] init];
    return annotation;
}

#pragma mark - MKAnnotation

- (NSString *)title
{
    NSString *returnTitle = @"";
    if([self.photo objectForKey:FLICKR_PHOTO_TITLE]) returnTitle = [self.photo objectForKey:FLICKR_PHOTO_TITLE];
    else if([self.photo objectForKey:@"woe_name"])returnTitle = [self.photo objectForKey:@"woe_name"];
    return returnTitle;
}

- (NSString *)subtitle
{
    NSString *returnVal = @"";
    if([self.photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION])
    returnVal = [self.photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
    else returnVal = @"";
    return returnVal;
}

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [[self.photo objectForKey:FLICKR_LATITUDE] doubleValue];
    coordinate.longitude = [[self.photo objectForKey:FLICKR_LONGITUDE] doubleValue];
    return coordinate;
}
@end
