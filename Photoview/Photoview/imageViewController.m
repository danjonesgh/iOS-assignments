//
//  imageViewController.m
//  Photoview
//
//  Created by Dan Jones on 8/24/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import "imageViewController.h"

@interface imageViewController () <UIScrollViewDelegate, UISplitViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation imageViewController
@synthesize scrollView = _scrollView;
@synthesize imageView = _imageView;

@synthesize imageToUse = _imageToUse;
@synthesize titleOfImage = _titleOfImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setImageToUse:(UIImage *)imageToUse
{
    if (_imageToUse != imageToUse) {
        _imageToUse = imageToUse;
        // Model changed, so update our View (the table)
       // if (self.tableView.window) [self.tableView reloadData];
        
    }
}

- (void)setTitleOfImage:(NSString *)titleOfImage
{
    if (_titleOfImage != titleOfImage) {
        _titleOfImage = titleOfImage;
        // Model changed, so update our View (the table)
        // if (self.tableView.window) [self.tableView reloadData];
        
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}



- (void)viewWillAppear:(BOOL)animated
{
    
    CGFloat widthRatio = self.scrollView.bounds.size.width / self.imageView.image.size.width;
    //NSLog(@"width rat %f", widthRatio);
    CGFloat heightRatio = self.scrollView.bounds.size.height / self.imageView.image.size.height;

    self.scrollView.zoomScale = MAX(widthRatio, heightRatio);
     
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView.delegate  = self;
    self.splitViewController.delegate = self;
    [self.imageView setImage:self.imageToUse];
  
    self.scrollView.contentSize = self.imageView.image.size;
    
    self.imageView.frame = CGRectMake(0, 0, self.imageView.image.size.width, self.imageView.image.size.height);
    self.title = self.titleOfImage;
    
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setScrollView:nil];
    [self setScrollView:nil];
    [self setImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
