//
//  topPlacesController.m
//  Photoview
//
//  Created by Dan Jones on 8/19/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import "topPlacesController.h"
#import "topPlacePhotosViewController.h"
#import "FlickrFetcher.h"

//@interface topPlacesController ()

//@end


@implementation topPlacesController

@synthesize places = _places;
@synthesize chosenDictionary = _chosenDictionary;
//synthesize spinner = _spinner;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setPlaces:(NSArray *)places
{
    if (_places != places) {
        _places = places;
        // Model changed, so update our View (the table)
        if (self.tableView.window) [self.tableView reloadData];
    }
}
/*
- (UIActivityIndicatorView *)spinner
{
    if(!_spinner)
    {
         _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _spinner;
}
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    dispatch_queue_t downloadQueue = dispatch_queue_create("flickr downloader", NULL);
    dispatch_async(downloadQueue, ^{
        NSArray *places = [FlickrFetcher topPlaces];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.places = places;
        });
    });
    dispatch_release(downloadQueue);
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.

    return [self.places count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Top Places cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    NSDictionary *photo = [self.places objectAtIndex:indexPath.row];
    NSString *titleStr = [photo valueForKey:@"_content"];
    NSArray *arrayStr = [titleStr componentsSeparatedByString:@","];
    cell.textLabel.text = [arrayStr objectAtIndex:0];
    NSString *subString = [arrayStr objectAtIndex:1];
    if(arrayStr.count > 2){
        subString = [subString stringByAppendingString:@","];
        subString = [subString stringByAppendingString:[arrayStr objectAtIndex:2]];
    }
    cell.detailTextLabel.text = subString; 
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
    
    self.chosenDictionary = [self.places objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"photosForPlace" sender:self];
    
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
 
    dispatch_queue_t downloadQueueWhat = dispatch_queue_create("flickr downloaderyo", NULL);
    dispatch_async(downloadQueueWhat, ^{
        NSArray *photos = [FlickrFetcher photosInPlace:self.chosenDictionary maxResults:50];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([segue.identifier isEqualToString:@"photosForPlace"]) {
                [segue.destinationViewController setPhotoArray:photos];
            }
        });
    });
    dispatch_release(downloadQueueWhat);
}

@end
