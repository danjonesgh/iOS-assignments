//
//  Tag.h
//  Photoview
//
//  Created by Dan Jones on 9/25/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo;

@interface Tag : NSManagedObject

@property (nonatomic, retain) NSString * tagname;
@property (nonatomic, retain) NSNumber * tagcount;
@property (nonatomic, retain) NSSet *photo;
@end

@interface Tag (CoreDataGeneratedAccessors)

- (void)addPhotoObject:(Photo *)value;
- (void)removePhotoObject:(Photo *)value;
- (void)addPhoto:(NSSet *)values;
- (void)removePhoto:(NSSet *)values;

@end
