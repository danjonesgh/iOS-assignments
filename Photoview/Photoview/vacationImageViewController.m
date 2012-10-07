//
//  vacationImageViewController.m
//  Photoview
//
//  Created by Dan Jones on 9/18/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import "vacationImageViewController.h"
#import "vacationHelper.h"
#import "Photo+Flickr.h"


@interface vacationImageViewController ()

@property (nonatomic, strong) NSString *buttonText;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *visitButton;
@end

@implementation vacationImageViewController

@synthesize visitButton = _visitButton;
@synthesize buttonText = _buttonText;
@synthesize photo = _photo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setPhoto:(NSDictionary *)photo
{
    if (_photo != photo) {
        _photo = photo;
        //[self useDocument];
    }

    [vacationHelper openVacation:VACATION_NAME usingBlock:^(UIManagedDocument *vacation)
     {
         self.buttonText = [Photo checkPhotoExists:photo inContext:vacation.managedObjectContext];
         
         self.navigationItem.rightBarButtonItem.title = self.buttonText;
   
         
        // NSLog(@"button text on inside %@", self.buttonText);
     }];
      self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.buttonText style:UIBarButtonItemStyleBordered target:self action:@selector(visitButtonPressed)];
    
}



- (void)visitButtonPressed
{
    __block NSString *visitString;
    
  /*  if([self.navigationItem.rightBarButtonItem.title isEqualToString:@"Visit"])
    {
        NSLog(@"text is seen as visit");
  
        
        self.navigationItem.rightBarButtonItem.title = @"Unvisit";
    }
    else if([self.navigationItem.rightBarButtonItem.title isEqualToString:@"Unvisit"])
    {
        NSLog(@"text seen as unvisitttt");
    
        
        self.visitButton.title = @"Visit";
    }
    */
    
    [vacationHelper openVacation:VACATION_NAME usingBlock:^(UIManagedDocument *vacation)
     {
         
        // NSString *checkPhotoExistence = [Photo checkPhotoExists:self.photo inContext:vacation.managedObjectContext];
         if([self.navigationItem.rightBarButtonItem.title isEqualToString:@"Visit"])
         {
             
             [Photo photoWithFlickrInfo:self.photo inManagedObjectContext:vacation.managedObjectContext];
             [vacation saveToURL:vacation.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:NULL];
            // NSLog(@"text is seen as visit in blockkkkkk");
             visitString = @"Unvisit";
             self.buttonText = @"Unvisit";
             self.navigationItem.rightBarButtonItem.title = @"Unvisit";
             NSLog(@"managed object added %@", vacation);
         }
         else if([self.navigationItem.rightBarButtonItem.title isEqualToString:@"Unvisit"])
         {
            // NSLog(@"text seen as unvisit in blockkkk");
             visitString = @"Visit";
             self.buttonText = @"Visit";
             self.navigationItem.rightBarButtonItem.title = @"Visit";
             [Photo deletePhoto:self.photo inContext:vacation.managedObjectContext];
             NSLog(@"managed object %@", vacation);
         }
         
     }];
    
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSLog(@"button text %@", self.buttonText);

    // self.visitButton.title = self.buttonText;
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
