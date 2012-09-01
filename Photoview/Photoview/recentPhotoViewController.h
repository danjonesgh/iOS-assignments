//
//  recentPhotoViewController.h
//  Photoview
//
//  Created by Dan Jones on 8/19/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface recentPhotoViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *arrayOfPhotos;
@property (nonatomic, strong) UIImage *imageWeSelected;
@property (nonatomic, strong) NSString *imageTitle;
@end
