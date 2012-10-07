//
//  imageViewController.m
//  Photoview
//
//  Created by Dan Jones on 8/24/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import "imageViewController.h"

@interface imageViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation imageViewController

@synthesize toolbar = _toolbar;
@synthesize imageView = _imageView;
@synthesize scrollView = _scrollView;
@synthesize splitViewBarButtonItem = _splitViewBarButtonItem;
@synthesize imageToUse = _imageToUse;
@synthesize titleOfImage = _titleOfImage;
@synthesize photo = _photo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //[self setup];
    }
    return self;
}
/*
- (void)setup
{
    self.imageView.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib
{
    [self setup];
}
*/
- (void)setImageToUse:(UIImage *)imageToUse
{
    if (_imageToUse != imageToUse) {
        _imageToUse = imageToUse;
        // Model changed, so update our View (the table)
       // if (self.tableView.window) [self.tableView reloadData];
        
    }
    NSLog(@"get image to use ");
    //[self.scrollView setNeedsDisplay];
    

    [self refreshImage];

    [self.imageView setNeedsDisplay];
}

- (void)setTitleOfImage:(NSString *)titleOfImage
{
    if (_titleOfImage != titleOfImage) {
        _titleOfImage = titleOfImage;
        // Model changed, so update our View (the table)
        // if (self.tableView.window) [self.tableView reloadData];
        
    }
    NSLog(@"get in set title of image");
    //[self.scrollView setNeedsDisplay];
    [self refreshImage];
    [self.imageView setNeedsDisplay];
}

- (void)setImageID:(NSString *)imageID
{
    if (_imageID != imageID) {
        _imageID = imageID;
        // Model changed, so update our View (the table)
        // if (self.tableView.window) [self.tableView reloadData];
        
    }
}

- (void)setPhoto:(NSDictionary *)photo
{
    if (_photo != photo) {
        _photo = photo;
        // Model changed, so update our View (the table)
        // if (self.tableView.window) [self.tableView reloadData];
        
    }
}


- (void)refreshImage
{
    
    self.title = self.titleOfImage;
    
    CGFloat widthRatio = self.scrollView.bounds.size.width / self.imageView.image.size.width;
    //NSLog(@"width rat %f", widthRatio);
    CGFloat heightRatio = self.scrollView.bounds.size.height / self.imageView.image.size.height;
    
    self.scrollView.zoomScale = MAX(widthRatio, heightRatio);
    
    [self.imageView setImage:self.imageToUse];
    
    self.scrollView.contentSize = self.imageView.image.size;
    
    self.imageView.frame = CGRectMake(0, 0, self.imageView.image.size.width, self.imageView.image.size.height);
}


- (void)setSplitViewBarButtonItem:(UIBarButtonItem *)splitViewBarButtonItem
{
    if (splitViewBarButtonItem != _splitViewBarButtonItem) {
       // self.navigationItem.leftBarButtonItem =
        NSMutableArray *toolbarItems = [self.toolbar.items mutableCopy];
        if (_splitViewBarButtonItem) [toolbarItems removeObject:_splitViewBarButtonItem];
        if (splitViewBarButtonItem) [toolbarItems insertObject:splitViewBarButtonItem atIndex:0];
        self.toolbar.items = toolbarItems;
        _splitViewBarButtonItem = splitViewBarButtonItem;
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


- (void)splitViewController:(UISplitViewController *)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)pc
{
   
    barButtonItem.title = aViewController.title;
    [self setSplitViewBarButtonItem:barButtonItem];
    //self.navigationItem.leftBarButtonItem = barButtonItem;
   
    
}



- (void)splitViewController:(UISplitViewController *)svc
     willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    
    [self setSplitViewBarButtonItem:nil];
}


- (void)viewDidUnload
{
    
    [self setToolbar:nil];
    [self setImageView:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}


 - (BOOL)splitViewController:(UISplitViewController *)svc
 shouldHideViewController:(UIViewController *)vc
 inOrientation:(UIInterfaceOrientation)orientation
 {
 // return YES;
 return [self.splitViewController.viewControllers lastObject] ? UIInterfaceOrientationIsPortrait(orientation) : NO;
    
 }
  



@end
