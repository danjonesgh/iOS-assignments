//
//  itineraryPhotoViewController.m
//  Photoview
//
//  Created by Dan Jones on 9/19/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import "itineraryPhotoViewController.h"
#import "Photo+Flickr.h"
#import "vacationImageViewController.h"
#import "Photo.h"
#import "Place.h"
#import "Place+Create.h"
#import "vacationHelper.h"
#import "FlickrFetcher.h"
#import "imageViewController.h"

@interface itineraryPhotoViewController ()

@end

@implementation itineraryPhotoViewController

@synthesize placeString = _placeString;
@synthesize vacationImage = _vacationImage;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setPlaceString:(NSString *)placeString
{
    if(_placeString != placeString)
    {
        _placeString = placeString;
    }
}

- (void)setupFetchWithDoc:(UIManagedDocument *)doc
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"inplace.name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    // no predicate because we want ALL the Photographers
    
    request.predicate = [NSPredicate predicateWithFormat:@"inplace.name = %@", self.placeString];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:doc.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    NSLog(@"fetch resl %@", self.fetchedResultsController);
}

- (void)viewDidLoad
{
    [super viewDidLoad];

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

- (void)viewWillAppear:(BOOL)animated
{
    [vacationHelper openVacation:VACATION_NAME usingBlock:^(UIManagedDocument *vacation) {
        //[Photo returnPhotos];
        [self setupFetchWithDoc:vacation];
    }];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"itineraryPlacePhoto";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Photo *photoz = [self.fetchedResultsController objectAtIndexPath:indexPath];
    if([photoz.inplace.name isEqualToString:self.placeString])
    {
        cell.textLabel.text = photoz.title;
    }
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
    
    
    Photo *photoz = [self.fetchedResultsController objectAtIndexPath:indexPath];
 
    NSURL *url = [NSURL URLWithString:photoz.imageurl];
        // NSLog(@"not cached");
   // NSDictionary *tempDict = [NSDictionary dictionaryWithObject:photoz.imageurl forKey:<#(id)#>]
   // NSURL *url =  [FlickrFetcher urlForPhoto:photoz.imageurl format:FlickrPhotoFormatLarge];
       UIImage *imageSelected = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    self.vacationImage = imageSelected;
    [self performSegueWithIdentifier:@"showVacationImage" sender:self];
  //      imageSelected = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
   //     [newcache cachePhoto:[NSData dataWithContentsOfURL:url] andWithPhotoDict:[self.photoArray objectAtIndex:indexPath.row]];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showVacationImage"])
    {
        
        [segue.destinationViewController setImageToUse:self.vacationImage];
    }
}



@end
