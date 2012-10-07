//
//  vacationHelper.m
//  Photoview
//
//  Created by Dan Jones on 9/18/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import "vacationHelper.h"

@implementation vacationHelper

@synthesize vacationDatabase = _vacationDatabase;


- (void)setVacationDatabase:(UIManagedDocument *)vacationDatabase
{
    if (_vacationDatabase != vacationDatabase) {
        _vacationDatabase = vacationDatabase;
        //[self useDocument];
    }
}





+ (void)openVacation:(NSString *)vacationName
          usingBlock:(completion_block_t)completionBlock
{
    
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    url = [url URLByAppendingPathComponent:vacationName];
    UIManagedDocument *doc = [[UIManagedDocument alloc] initWithFileURL:url];
    if (![[NSFileManager defaultManager] fileExistsAtPath:[url path]]) {
        // does not exist on disk, so create it
        [doc saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success){
            NSLog(@"created new doc");
            completionBlock(doc);
        }];
    } else if (doc.documentState == UIDocumentStateClosed) {
        // exists on disk, but we need to open it
        [doc openWithCompletionHandler:^(BOOL success) {
            NSLog(@"closed, need to open");
            completionBlock(doc);
        }];
    } else if (doc.documentState == UIDocumentStateNormal) {
        NSLog(@"open, need to use");
        completionBlock(doc);
        // already open and ready to use
    }

}



@end
