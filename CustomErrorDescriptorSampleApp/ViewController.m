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
    
    
     
     //Uncomment this section to add a custom error Description for error code -1003
    NSDictionary *errors = @{@-1003:@"Are you sure about that URL?", @-1009:@"Internet is gone!"};
     [ErrorDescriptor addCustomErrorDescriptions:errors];
    
}

-(void)connectToSite
{
    
    // Set up NSURLSession to connect to google.com, except the URL is wrong so we will get an error!
    NSURL *url = [NSURL URLWithString:@"http://www.google.comaaa"];
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
            
            // We add a UIAlertController to display the message to the User which has to be called on the main queue or it will cause weird errors
            
            dispatch_async(dispatch_get_main_queue(), ^{
            
                // Just for demonstration purposes, I am making the alertController Title our Custom Message and the message the standard localizedDescription. You can adjust these any way you prefer.
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:[ErrorDescriptor description:error]
                                                                               message:[error localizedDescription]
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * action) {}];
                
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
            });
        }
        
    }];
    
    [postDataTask resume];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
