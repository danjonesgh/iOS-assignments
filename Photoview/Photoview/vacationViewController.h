//
//  vacationViewController.h
//  Photoview
//
//  Created by Dan Jones on 9/16/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@interface vacationViewController : CoreDataTableViewController

@property (nonatomic, strong) UIManagedDocument *vacationDatabase;

@end
