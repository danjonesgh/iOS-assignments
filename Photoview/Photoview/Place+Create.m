//
//  Place+Create.m
//  Photoview
//
//  Created by Dan Jones on 9/19/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import "Place+Create.h"


@implementation Place (Create)

+ (Place *)placeWithName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context
{
    Place *place = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Place"];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *places = [context executeFetchRequest:request error:&error];
    
    if (!places || ([places count] > 1)) {
        // handle error
    } else if (![places count]) {
        place = [NSEntityDescription insertNewObjectForEntityForName:@"Place"
                                                     inManagedObjectContext:context];
        place.name = name;
        NSLog(@"just name %@", name);
        NSLog(@"place name %@", place.name);
        
    } else {
        place = [places lastObject];
    }
    
    return place;
}
@end
