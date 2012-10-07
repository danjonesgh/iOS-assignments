//
//  itineraryPhotoViewController.h
//  Photoview
//
//  Created by Dan Jones on 9/19/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@interface itineraryPhotoViewController : CoreDataTableViewController

@property (nonatomic, strong) NSString *placeString;

@property (nonatomic, strong) UIImage *vacationImage;
@end
