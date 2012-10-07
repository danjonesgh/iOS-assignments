//
//  mapViewController.m
//  Photoview
//
//  Created by Dan Jones on 9/6/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import "mapViewController.h"
#import <MapKit/MapKit.h>
#import "imageViewController.h"

@interface mapViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation mapViewController
@synthesize mapView = _mapView;
@synthesize mapPlaces = _mapPlaces;
@synthesize photoPlaces = _photoPlaces;
@synthesize imageSelected = _imageSelected;
@synthesize delegate = _delegate;
@synthesize imageTitle = _imageTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)updateMapView
{
    if (self.mapView.annotations) [self.mapView removeAnnotations:self.mapView.annotations];
    //NSLog(@"ok %@", self.mapPlaces);
    if (self.mapPlaces) [self.mapView addAnnotations:self.mapPlaces];
    
}

- (void)setMapPlaces:(NSArray *)mapPlaces
{
    if (_mapPlaces != mapPlaces) {
        _mapPlaces = mapPlaces;
    }

    [self updateMapView];
}

- (void)setImageSelected:(UIImage *)imageSelected
{
    if (_imageSelected != imageSelected) {
        _imageSelected = imageSelected;
    }
    
    [self updateMapView];
}

- (void)setPhotoPlaces:(NSArray *)photoPlaces
{
    if (_photoPlaces != photoPlaces) {
        _photoPlaces = photoPlaces;
    }
    [self updateMapView];
}



#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *aView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"MapVC"];
    if (!aView) {
        aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MapVC"];
        aView.canShowCallout = YES;
        aView.leftCalloutAccessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        // could put a rightCalloutAccessoryView here
    }
    
    aView.annotation = annotation;
    [(UIImageView *)aView.leftCalloutAccessoryView setImage:nil];
    aView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
   
    return aView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)aView
{
    UIImage *image = [self.delegate mapViewController:self imageForAnnotation:aView.annotation withFormat:FlickrPhotoFormatLarge];
    [(UIImageView *)aView.leftCalloutAccessoryView setImage:image];
   
    
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    
    id detail = [self.splitViewController.viewControllers lastObject];
    if([detail isKindOfClass:[imageViewController class]])
    {
        [detail setImageToUse:[self.delegate mapViewController:self imageForAnnotation:view.annotation withFormat:FlickrPhotoFormatLarge]];
    }
    self.imageSelected = [self.delegate mapViewController:self imageForAnnotation:view.annotation withFormat:FlickrPhotoFormatLarge];
    [self performSegueWithIdentifier:@"mapToImage" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // send image and title in segue
    if([segue.identifier isEqualToString:@"mapToImage"])
    {
        [segue.destinationViewController setImageToUse:self.imageSelected];
        
        [segue.destinationViewController setTitleOfImage:self.imageTitle];
    }
}


- (void)viewDidLoad
{
    [self updateMapView];
    self.mapView.delegate = self;
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
