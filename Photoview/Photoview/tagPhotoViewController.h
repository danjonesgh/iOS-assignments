//
//  tagPhotoViewController.h
//  Photoview
//
//  Created by Dan Jones on 9/18/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@interface tagPhotoViewController : CoreDataTableViewController

@property (nonatomic, strong) NSString *tagName;
@property (nonatomic, strong) UIImage *tagImage;
@end
