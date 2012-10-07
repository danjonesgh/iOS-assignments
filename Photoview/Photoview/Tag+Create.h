//
//  Tag+Create.h
//  Photoview
//
//  Created by Dan Jones on 9/19/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import "Tag.h"

@interface Tag (Create)


+ (NSSet *)tagWithName:(NSString *)name
  inManagedObjectContext:(NSManagedObjectContext *)context;



@end
