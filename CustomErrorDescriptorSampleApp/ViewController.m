//
//  ViewController.m
//  CustomErrorDescriptorSampleApp
//
//  Created by Krishna Ramachandran on 5/11/16.
//  Copyright © 2016 Krishna Ramachandran. All rights reserved.
//

#import "ViewController.h"
#import "ErrorDescriptor.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Add a UIButton to the center of our view
    UIButton *connectToWebsite = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [connectToWebsite setBackgroundColor:[UIColor blueColor]];
    [connectToWebsite setTitle:@"Connect" forState:UIControlStateNormal];
    [connectToWebsite setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    connectToWebsite.center = self.view.center;
    
    [self.view addSubview:connectToWebsite];
    
    [connectToWebsite addTarget:self action:@selector(connectToSite) forControlEvents:UIControlEventTouchUpInside];
    
     
     //This section adds custom error Descriptions for error code -1003 and -1009. These override the ones in the ErrorDescriptor class method +(NSMutableDictionary *)errors; You can add more Custom Error descriptors and their respective codes to the NSDictionary here, or you can add them directly in the +(NSMutableDictionary *)errors; method in the ErrorDescriptor.m file
    NSDictionary *errors = @{@-1003:@"Are you sure about that URL?", @-1009:@"Internet Connection Gone!"};
     [ErrorDescriptor addCustomErrorDescriptions:errors];
    
}

-(void)connectToSite
{
    
    // Set up NSURLSession to connect to google.com, except the URL is wrong so we will get an error!
    NSURL *url = [NSURL URLWithString:@"http://www.googl.caaaaaaa"];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"GET"];

    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            // Usually we would do stuff with the return data. Here, we just NSLog a message
            NSLog(@"Connected successfully");
            
        }
        else {
            // Here we NSLog the Error Code and Error description using our Custom Class
            NSLog(@"Error Code:%ld Description: %@" ,(long)error.code, [ErrorDescriptor description:error]);
            
            // This method creates and dispatches a UIAlertController when there is an error. The UIAlertController is created in the ErrorDescriptor class and dispatched on the ViewController calling it (ie. self). You can use this method anywhere you want a UIAlertController to appear when there is an error. You can configure the alert message and title in the method in ErrorDescriptor.m
            
            [ErrorDescriptor displayUIAlertControllerWithError:error onViewController:self];
            
        }
        
    }];
    
    [postDataTask resume];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
