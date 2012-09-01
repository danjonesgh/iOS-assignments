//
//  topPlacesController.h
//  Photoview
//
//  Created by Dan Jones on 8/19/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface topPlacesController : UITableViewController
@property (nonatomic, strong) NSArray *places; // of Flickr photo dictionaries
@property (nonatomic, weak) NSDictionary *chosenDictionary;
//@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@end


