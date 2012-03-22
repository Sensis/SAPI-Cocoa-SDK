//
//  SAPIResult.m
//  Sensis SAPI
//
//  Created by Mark Aufflick on 21/03/12.
//  Copyright (c) 2012 Pumptheory Pty Ltd. All rights reserved.
//

#import "SAPIResult.h"
#import "SAPIPrivate.h"

const NSInteger SAPIResultSuccess = 200;
const NSInteger SAPIResultQueryModified = 206;
const NSInteger SAPIResultValidationError = 400;

@implementation SAPIResult

@synthesize time;
@synthesize code;
@synthesize details;

+ (SAPIResult *)resultWithJSONDictionary:(NSDictionary *)jsonDictionary
{
    return [[[self alloc] initWithJSONDictionary:jsonDictionary] autorelease];
}

- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary
{
    if ((self = [self init]))
    {
        [jsonDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
         {
            if ([self respondsToSelector:NSSelectorFromString(key)])
            {
                NSLog(@"key: %@", key);
                [self setValue:obj forKey:key];
            }
        }];
    }
    
    return self;
}

- (void)setNilValueForKey:(NSString *)theKey
{
    // Zero is probably a reasonable default for scalar values
    // This general method wouldn't work if we had to deal with structs
    // as well as numberical scalars, but we don't for the time being.
    [self setValue:[NSNumber numberWithInt:0] forKey:theKey];
}

@end
