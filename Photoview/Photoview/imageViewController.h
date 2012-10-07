//
//  imageViewController.h
//  Photoview
//
//  Created by Dan Jones on 8/24/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface imageViewController : UIViewController <UISplitViewControllerDelegate>
@property (nonatomic, strong) UIImage *imageToUse;
@property (nonatomic, strong) NSString *titleOfImage;
@property (nonatomic, strong) NSString *imageID;
@property (nonatomic, strong) UIBarButtonItem *splitViewBarButtonItem;
@property (nonatomic, strong) NSDictionary *photo;
@end
