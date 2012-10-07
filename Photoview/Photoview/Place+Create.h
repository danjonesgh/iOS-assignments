//
//  Place+Create.h
//  Photoview
//
//  Created by Dan Jones on 9/19/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import "Place.h"

@interface Place (Create)


+ (Place *)placeWithName:(NSString *)name
                inManagedObjectContext:(NSManagedObjectContext *)context;



@end
