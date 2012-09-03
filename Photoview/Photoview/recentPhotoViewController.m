//
//  recentPhotoViewController.m
//  Photoview
//
//  Created by Dan Jones on 8/19/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import "recentPhotoViewController.h"
#import "FlickrFetcher.h"
#import "imageViewController.h"

@interface recentPhotoViewController ()

@end

@implementation recentPhotoViewController
@synthesize arrayOfPhotos = _arrayOfPhotos;
@synthesize imageTitle = _imageTitle;
@synthesize imageWeSelected = _imageWeSelected;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSMutableArray *)arrayOfPhotos
{
    if (_arrayOfPhotos == nil) _arrayOfPhotos = [[NSMutableArray alloc] init];
    return _arrayOfPhotos;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //if (self.tableView.window) [self.tableView reloadData];
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
    return [[[NSUserDefaults standardUserDefaults] arrayForKey:@"array of recents"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Recent Photos cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    // set cell text to item at object in ns user defaults
    self.arrayOfPhotos = [[NSUserDefaults standardUserDefaults] objectForKey:@"array of recents"];
    
    cell.textLabel.text = [[self.arrayOfPhotos objectAtIndex:indexPath.row] valueForKey:@"title"]; 
   
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
   
    // get the url of the selected image, turn it into an image, and get the title
    NSURL *url =  [FlickrFetcher urlForPhoto:[self.arrayOfPhotos objectAtIndex:indexPath.row] format:2];
    UIImage *imageSelected = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    
    self.imageWeSelected = imageSelected;
    self.imageTitle = [[self.arrayOfPhotos objectAtIndex:indexPath.row] valueForKey:@"title"];
    
    //[self performSegueWithIdentifier:@"recentImageSelected" sender:self];
    
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
    // send image and title in segue
    if([segue.identifier isEqualToString:@"recentImageSelected"])
    {
        [segue.destinationViewController setImageToUse:self.imageWeSelected];
        
        [segue.destinationViewController setTitleOfImage:self.imageTitle];
    }
}

@end
