//
//  itineraryPlaceViewController.m
//  Photoview
//
//  Created by Dan Jones on 9/18/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import "itineraryPlaceViewController.h"
#import "Photo+Flickr.h"
#import "vacationImageViewController.h"
#import "Photo.h"
#import "Place.h"
#import "Place+Create.h"
#import "itineraryPhotoViewController.h"

@interface itineraryPlaceViewController ()
@property (nonatomic, strong) NSArray *fetchArray;
@property (nonatomic, strong) NSMutableArray *placesSet;
@end

@implementation itineraryPlaceViewController

@synthesize fetchArray = _fetchArray;
@synthesize placesSet = _placesSet;
@synthesize placeSelected = _placeSelected;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [vacationHelper openVacation:VACATION_NAME usingBlock:^(UIManagedDocument *vacation) {
        //[Photo returnPhotos];
        [self setupFetchWithDoc:vacation];
    }];
    
}

- (void)setupFetchWithDoc:(UIManagedDocument *)doc
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Place"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    // no predicate because we want ALL the Photographers
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:doc.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    NSLog(@"fetch resl %@", self.fetchedResultsController);
}

- (void)setPlacesSet:(NSMutableArray *)placesSet
{
    if(_placesSet != placesSet)
    {
        _placesSet = placesSet;
    }
}

- (NSMutableArray *)placesSet
{
    if (_placesSet == nil) _placesSet = [[NSMutableArray alloc] init];
    return _placesSet;
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"itineraryPlace";
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Place *place = [self.fetchedResultsController objectAtIndexPath:indexPath];
    // ask NSFetchedResultsController for the NSMO at the row in question
    if(!([self.placesSet containsObject:place.name]))
    {
        [self.placesSet addObject:place.name];
        //photoz = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        cell.textLabel.text = place.name;
    }
    NSLog(@" palce set %@", self.placesSet);
    //Photo *photoz = [self.placesSet objectAtIndex:indexPath];
    NSLog(@"photoz %@", place.name);
    // Then configure the cell using it ...

   // cell.detailTextLabel.text = [NSString stringWithFormat:@"%d photos", [photographer.photos count]];
    // Configure the cell...
    
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    self.placeSelected = [self.placesSet objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"itineraryPhotosForPlace" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"itineraryPhotosForPlace"])
    {
        NSLog(@"places selected %@", self.placeSelected);
        [segue.destinationViewController setPlaceString:self.placeSelected];
    }
}

@end
