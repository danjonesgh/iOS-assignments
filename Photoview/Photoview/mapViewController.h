//
//  mapViewController.h
//  Photoview
//
//  Created by Dan Jones on 9/6/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "FlickrFetcher.h"

@class mapViewController;

@protocol MapViewControllerDelegate <NSObject>
- (UIImage *)mapViewController:(mapViewController *)sender imageForAnnotation:(id <MKAnnotation>)annotation withFormat:(FlickrPhotoFormat)format;
@end

@interface mapViewController : UIViewController
@property (nonatomic, strong) NSArray *mapPlaces;
@property (nonatomic, strong) NSArray *photoPlaces;
@property (nonatomic, strong) UIImage *imageSelected;
@property (nonatomic, strong) NSString *imageTitle;
@property (nonatomic, weak) id <MapViewControllerDelegate> delegate;

@end
