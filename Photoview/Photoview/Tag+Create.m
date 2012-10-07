//
//  Tag+Create.m
//  Photoview
//
//  Created by Dan Jones on 9/19/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import "Tag+Create.h"

@implementation Tag (Create)

+ (NSSet *)tagWithName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context
{
    Tag *tag = nil;
    NSMutableSet *tagSet = [NSMutableSet set];
    NSArray *array = [name componentsSeparatedByString:@" "];
    NSSet *set = [NSSet setWithArray:array];
    
    // add distinct tags into database
    for (NSString *aString in set){
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
        request.predicate = [NSPredicate predicateWithFormat:@"tagname = %@", aString];
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"tagname" ascending:YES];
        request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
        NSError *error = nil;
        NSArray *tags = [context executeFetchRequest:request error:&error];
    
        if (!tags || ([tags count] > 1)) {
        // handle error
        } else if (![tags count]) {
            tag = [NSEntityDescription insertNewObjectForEntityForName:@"Tag"
                                              inManagedObjectContext:context];
            tag.tagname = aString;
            tag.tagcount = [NSNumber numberWithInt:1];
        
        } else {
            tag = [tags lastObject];
            tag.tagcount = [NSNumber numberWithInt:[tag.tagcount intValue]+1];
        }
        [tagSet addObject:tag];
    }
    NSLog(@"tagset %@", tagSet);
    return tagSet;
}

@end
