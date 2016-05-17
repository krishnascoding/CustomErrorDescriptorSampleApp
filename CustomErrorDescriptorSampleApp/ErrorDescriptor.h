//  Create Custom Error Descriptions/Messages
//  ErrorDescriptor.h
//
//  Created by Krishna Ramachandran on 4/29/16.
//  Copyright © 2016 Krishna Ramachandran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ErrorDescriptor : NSObject

// Method to return the error description for a particular NSError
+(NSString*)description:(NSError*)error;

// Add new custom error descriptions through NSDictionary: Key(Error.code) : Value(Error description)
+(void)addCustomErrorDescriptions:(NSDictionary *)dictionary;

// Returns NSDictionary of the custom error codes and descriptions currently in this class
+(NSDictionary *)listErrorDescriptions;

+(void)displayUIAlertControllerWithError:(NSError*)error onViewController:(id)vc;

@end
