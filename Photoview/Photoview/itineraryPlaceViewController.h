//
//  itineraryPlaceViewController.h
//  Photoview
//
//  Created by Dan Jones on 9/18/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"
#import "vacationHelper.h"

@interface itineraryPlaceViewController : CoreDataTableViewController

@property (nonatomic, strong) NSString *placeSelected;

@end
