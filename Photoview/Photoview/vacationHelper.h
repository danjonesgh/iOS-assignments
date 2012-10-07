//
//  vacationHelper.h
//  Photoview
//
//  Created by Dan Jones on 9/18/12.
//  Copyright (c) 2012 Dan Jones. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^completion_block_t)(UIManagedDocument *vacation);

@interface vacationHelper : NSObject


@property (nonatomic, strong) UIManagedDocument *vacationDatabase;

+ (void)openVacation:(NSString *)vacationName
          usingBlock:(completion_block_t)completionBlock;

@end
