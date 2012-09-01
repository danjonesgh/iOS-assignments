//
//  recentImageSelectedViewController.m
//  Photoview
//
//  Created by Dan Jones on 9/1/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import "recentImageSelectedViewController.h"

@interface recentImageSelectedViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *recentImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *recentScrollView;

@end

@implementation recentImageSelectedViewController
@synthesize recentImageView = _recentImageView;
@synthesize recentScrollView = _recentScrollView;


@synthesize imageOfRecent = _imageOfRecent;
@synthesize titleOfRecent = _titleOfRecent;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)setImageOfRecent:(UIImage *)imageOfRecent
{
    if (_imageOfRecent != imageOfRecent) {
        _imageOfRecent = imageOfRecent;
        
    }
}

- (void)setTitleOfRecent:(NSString *)titleOfRecent
{
    if (_titleOfRecent != titleOfRecent) {
        _titleOfRecent = titleOfRecent;
        
    }
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.recentImageView;
}



- (void)viewWillAppear:(BOOL)animated
{
    CGFloat widthRatio = self.recentScrollView.bounds.size.width / self.recentImageView.image.size.width;
   
    CGFloat heightRatio = self.recentScrollView.bounds.size.height / self.recentImageView.image.size.height;
   
    self.recentScrollView.zoomScale = MAX(widthRatio, heightRatio);
    
    //CGRect visibleRect = [self.recentScrollView convertRect:self.recentScrollView.bounds toView:self.recentImageView];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.recentScrollView.delegate  = self;
    
    [self.recentImageView setImage:self.imageOfRecent];
    
    self.recentScrollView.contentSize = self.recentImageView.image.size;
    
    self.recentImageView.frame = CGRectMake(0, 0, self.recentImageView.image.size.width, self.recentImageView.image.size.height);
    self.title = self.titleOfRecent;
    
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setRecentImageView:nil];
    [self setRecentScrollView:nil];
    [self setRecentImageView:nil];
    [self setRecentScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
