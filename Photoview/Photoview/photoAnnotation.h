//
//  photoAnnotation.h
//  Photoview
//
//  Created by Dan Jones on 9/9/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface photoAnnotation : NSObject <MKAnnotation>

+ (photoAnnotation *)annotationForPhoto:(NSDictionary *)photo; // Flickr photo dictionary
+ (photoAnnotation *)annotationForPlace;

@property (nonatomic, strong) NSDictionary *photo;
@property (nonatomic, strong) NSString *descripString;

@end
