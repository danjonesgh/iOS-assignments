//
//  topPlacePhotosViewController.h
//  Photoview
//
//  Created by Dan Jones on 8/21/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface topPlacePhotosViewController : UITableViewController
@property (nonatomic, strong) NSArray *photoArray;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@property (nonatomic, strong) UIImage *imageWeSelected;
@property (nonatomic, strong) NSString *imageTitle;
@property (nonatomic, strong) NSArray *arrayOfRecents;
@end
