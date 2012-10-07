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
#import "mapViewController.h"
#import "photoAnnotation.h"


@interface topPlacesController () 
@property (nonatomic, strong) NSDictionary *photosForPlace;
@end


@implementation topPlacesController

@synthesize places = _places;
@synthesize chosenDictionary = _chosenDictionary;
@synthesize photosForPlace = _photosForPlace;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)updatePhotosByPlace
{
    NSMutableDictionary *photosByPlace = [NSMutableDictionary dictionary];
    for (NSDictionary *photo in self.places) {
        NSString *place = [photo objectForKey:FLICKR_PLACE_NAME];
        NSArray *arrayStr = [place componentsSeparatedByString:@","];
        NSString *finalPlace = [arrayStr lastObject];
        //NSLog(@"final place %@", finalPlace);
        NSMutableArray *photos = [photosByPlace objectForKey:finalPlace];
        if (!photos) {
            photos = [NSMutableArray array];
            [photosByPlace setObject:photos forKey:finalPlace];
        }
        [photos addObject:photo];
    }
    self.photosForPlace = photosByPlace;
    //NSLog(@"self.phoots for place %@", self.photosForPlace);
}

- (void)setPlaces:(NSArray *)places
{
    if (_places != places) {
        _places = places;
        // Model changed, so update our View (the table)
        if (self.tableView.window){
            
            [self updatePhotosByPlace];
            [self.tableView reloadData];
        }
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // get flickr top places in separate thread, set places array
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
    //return YES;
   // return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

#pragma mark - Table view data source

- (NSString *)placeForSection:(NSInteger)section
{
    return [[self.photosForPlace allKeys] objectAtIndex:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self placeForSection:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.photosForPlace count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.

    //return [self.places count];
    NSString *place = [self placeForSection:section];
    //NSLog(@"place in numrow %@", place);
    NSArray *photosByPlace = [self.photosForPlace objectForKey:place];
    return [photosByPlace count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Top Places cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    
    // set text of cell based on index of array, add comma to country/state string
    
   // NSLog(@"self.phoots for place %@", self.photosForPlace);
    
    
    NSString *ourPlace = [self placeForSection:indexPath.section];
    NSArray *places = [self.photosForPlace valueForKey:ourPlace];
    NSDictionary *photo = [places objectAtIndex:indexPath.row];
    //NSDictionary *photo = [self.places objectAtIndex:indexPath.row];
   // NSLog(@"photo %@", photo);
    NSString *titleStr = [photo valueForKey:FLICKR_PLACE_NAME];
    NSArray *arrayStr = [titleStr componentsSeparatedByString:@","];
    //cell.textLabel.text = titleStr;
    cell.textLabel.text = [arrayStr objectAtIndex:0];
    NSString *subString = [arrayStr objectAtIndex:1];
    if(arrayStr.count > 2){
        subString = [subString stringByAppendingString:@","];
        subString = [subString stringByAppendingString:[arrayStr objectAtIndex:2]];
    }
    cell.detailTextLabel.text = subString;
   // NSString *place = [photo objectForKey:FLICKR_PLACE_NAME];
   // NSArray *again = [place componentsSeparatedByString:@","];
   // NSString *finalPlace = [again lastObject];
   // cell.detailTextLabel.text = finalPlace;
     
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
    // set dictionary to cell we chose, this is the top place selected
    
    
    NSString *ourPlace = [self placeForSection:indexPath.section];
    NSArray *places = [self.photosForPlace valueForKey:ourPlace];
    
    //self.chosenDictionary = [self.places objectAtIndex:indexPath.row];
    self.chosenDictionary = [places objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"photosForPlace" sender:self];
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


- (IBAction)mapPressed:(id)sender {
    [self performSegueWithIdentifier:@"placesToMap" sender:self];
    
    
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"photosForPlace"])
    {
        // get the photos for a top place in a separate thread, send them in the segue
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
    else if([segue.identifier isEqualToString:@"placesToMap"])
    {
        
        id map = segue.destinationViewController;
        if([map isKindOfClass:[mapViewController class]])
        {
           // mapViewController *mapvc = (mapViewController *)map;
            //mapvc.delegate = self;
        }
        [segue.destinationViewController setMapPlaces:[self mapAnnotations]];
    }
}



- (NSArray *)mapAnnotations
{
    NSMutableArray *annotations = [NSMutableArray arrayWithCapacity:[self.places count]];
    for (NSDictionary *place in self.places) {
        [annotations addObject:[photoAnnotation annotationForPhoto:place]];
    }
    return annotations;
}








@end
