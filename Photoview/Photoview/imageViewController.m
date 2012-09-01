//
//  imageViewController.m
//  Photoview
//
//  Created by Dan Jones on 8/24/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import "imageViewController.h"

@interface imageViewController () <UIScrollViewDelegate>
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
    //NSLog(@"height rat %f", heightRatio);
    //NSLog(@"new rat %f", widthRatio/heightRatio);
   // CGRect newRect = CGRectMake(0, 0, 652, 490 );
    //[self.scrollView zoomToRect:newRect animated:NO];
    self.scrollView.zoomScale = MAX(widthRatio, heightRatio);
    //NSLog(@"some img %f", self.imageView.image.size.width);
    //NSLog(@"some imgzz %f", self.imageView.image.size.height);
    CGRect visibleRect = [self.scrollView convertRect:self.scrollView.bounds toView:self.imageView];
    //NSLog(@"vis rect %@", NSStringFromCGRect(visibleRect));
    // self.imageView.image.
    
    //self.imageView.frame = CGRectMake(0, 0, self.imageView.image.size.width, self.imageView.image.size.height);
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView.delegate  = self;
    
    [self.imageView setImage:self.imageToUse];
  
    self.scrollView.contentSize = self.imageView.image.size;
   // self.scrollView.zoomScale = 4;
   // NSLog(@"crr bounds %@", NSStringFromCGRect(self.scrollView.bounds));
    self.imageView.frame = CGRectMake(0, 0, self.imageView.image.size.width, self.imageView.image.size.height);
    self.title = self.titleOfImage;
    //self.photoTitle.text = self.titleOfImage;
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
