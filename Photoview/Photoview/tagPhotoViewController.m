//
//  tagPhotoViewController.m
//  Photoview
//
//  Created by Dan Jones on 9/18/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import "tagPhotoViewController.h"
#import "Photo+Flickr.h"
#import "Photo.h"
#import "Tag+Create.h"
#import "Tag.h"
#import "FlickrFetcher.h"
#import "vacationHelper.h"
#import "vacationImageViewController.h"

@interface tagPhotoViewController ()

@end

@implementation tagPhotoViewController

@synthesize tagName = _tagName;
@synthesize tagImage = _tagImage;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setTagName:(NSString *)tagName
{
    if(_tagName != tagName)
    {
        _tagName = tagName;
    }
}

- (void)setTagImage:(UIImage *)tagImage
{
    if(_tagImage != tagImage)
    {
        _tagImage = tagImage;
    }
}

- (void)setupFetchWithDoc:(UIManagedDocument *)doc
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    // no predicate because we want ALL the Photographers
    NSLog(@"this was tagname %@", self.tagName);
    request.predicate = [NSPredicate predicateWithFormat:@"%@ in tags.tagname", self.tagName];
    
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
    NSLog(@"did get out ");
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"in hre!!");
    static NSString *CellIdentifier = @"tagPhotoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSLog(@"photo title %@", photo.title);
    cell.textLabel.text = photo.title;
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
    
    Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSURL *url = [NSURL URLWithString:photo.imageurl];
    
    UIImage *imageSelected = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    self.tagImage = imageSelected;
    [self performSegueWithIdentifier:@"showTagPhoto" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showTagPhoto"])
    {
        
        [segue.destinationViewController setImageToUse:self.tagImage];
    }
}



@end
