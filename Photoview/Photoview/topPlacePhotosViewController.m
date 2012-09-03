//
//  topPlacePhotosViewController.m
//  Photoview
//
//  Created by Dan Jones on 8/21/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import "topPlacePhotosViewController.h"
#import "imageViewController.h"
#import "FlickrFetcher.h"

@interface topPlacePhotosViewController () 

@end

@implementation topPlacePhotosViewController

@synthesize photoArray = _photoArray;
@synthesize spinner = _spinner;
@synthesize imageWeSelected = _imageWeSelected;
@synthesize imageTitle = _imageTitle;
@synthesize arrayOfRecents = _arrayOfRecents;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (NSArray *)arrayOfRecents
{
    if (_arrayOfRecents == nil) _arrayOfRecents = [[NSArray alloc] init];
    return _arrayOfRecents;
}



- (void)setPhotoArray:(NSArray *)photoArray
{
    if (_photoArray != photoArray) {
        _photoArray = photoArray;
        // Model changed, so update our View (the table)
        if (self.tableView.window) [self.tableView reloadData];
        
    }
}

- (UIActivityIndicatorView *)spinner
{
    if(!_spinner)
    {
        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _spinner;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.spinner startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.spinner];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //return YES;
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;

}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.photoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Top Photos cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
   
    // Configure the cell...
    NSDictionary *photo = [self.photoArray objectAtIndex:indexPath.row];
  
    // if the title isn't empty use that value, otherwise use the description, otherwise use unknown
    // once these are loaded stop the spinner
    if(![[photo valueForKeyPath:@"title"] isEqualToString:@""])
    {
        cell.textLabel.text = [photo valueForKeyPath:@"title"];
    }
    else if( ![[photo valueForKeyPath:@"description._content"] isEqualToString:@""] && ![[[photo valueForKeyPath:@"description._content"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
    {
        cell.textLabel.text = [photo valueForKeyPath:@"description._content"];
    }
    else 
    {
        cell.textLabel.text = @"Unknown";
    }
    [self.spinner stopAnimating];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSURL *url =  [FlickrFetcher urlForPhoto:[self.photoArray objectAtIndex:indexPath.row] format:2];
    UIImage *imageSelected = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
 
    self.imageWeSelected = imageSelected;
    self.imageTitle = [[self.photoArray objectAtIndex:indexPath.row] valueForKey:@"title"]; 
    
    // get copy of recents, if not in the list add it, if list is 20 remove the oldest, add one
    NSMutableArray *recentsCopy = [self.arrayOfRecents mutableCopy];
    if(![recentsCopy containsObject:[self.photoArray objectAtIndex:indexPath.row]])
    {
        if([recentsCopy count] == 20)
        {
            [recentsCopy removeObjectAtIndex:0];
        }
        
        [recentsCopy addObject:[self.photoArray objectAtIndex:indexPath.row]];
        self.arrayOfRecents = recentsCopy;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:self.arrayOfRecents forKey:@"array of recents"];

    
   // [self performSegueWithIdentifier:@"imageSelected" sender:self];
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"imageSelected"])
    {
        // send image and title in segue
        [segue.destinationViewController setImageToUse:self.imageWeSelected];
        [segue.destinationViewController setTitleOfImage:self.imageTitle];
    }
}




@end
