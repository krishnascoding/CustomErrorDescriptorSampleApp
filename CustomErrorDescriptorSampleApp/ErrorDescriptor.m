//  Create Custom Error Descriptions/Messages
//  ErrorDescriptor.m
//
//  Created by Krishna Ramachandran on 4/29/16.
//  Copyright © 2016 Krishna Ramachandran. All rights reserved.
//

#import "ErrorDescriptor.h"

@implementation ErrorDescriptor
static NSMutableDictionary *_errors;

+(NSMutableDictionary *)errors
{
    _errors = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        _errors = [NSMutableDictionary dictionary];
        
        // You can also directly adjust the Custom Error Messages here if you do not want to do it using the addCustomErrorDescriptions: method. Simply continue in the same way as below - set messages for the object and error codes as the keys
        [_errors setObject:@"You aren't connected to the Internet!" forKey:@-1009];
        [_errors setObject:@"We couldn't connect to the server" forKey:@-1001];
        
    });
    
    return _errors;
}

+(NSString *)description:(NSError*)error
{
    NSString *errorDescription = [_errors objectForKey:[NSNumber numberWithLong:error.code]];
    
    if (errorDescription) {
        
        return errorDescription;
    }
    
    return [error localizedDescription];
}

+(void)addCustomErrorDescriptions:(NSDictionary *)dictionary
{
    if (!_errors) {
        
        [self errors];
    }
    
    [_errors addEntriesFromDictionary:dictionary];
}

+(NSDictionary *)listErrorDescriptions
{
    if (!_errors) {
        
        [self errors];
    }
    
    return _errors;
}

@end
