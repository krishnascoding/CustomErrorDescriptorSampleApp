# CustomErrorDescriptorSampleApp
Sample Project with Custom Class which allows you to create Custom Error Description messages in Objective C 

To Test the Sample Project Follow These Steps
- Download Zip file, uncompress and open project
- Make sure App Transport Security Settings in Info.plist has the Allows Arbitrary Loads set to YES
- Run the program and click the Blue Connect button on the screen. Our goal is to get a connection error. Since the URL in the app is not to a valid server hostname you should notice an Error message and have an alert pop up for trying to connect to a server hostname which can not be found. 
    NOTE: On particular WiFi connections, all unknown server hostnames will automatically redirect to a dnsrsearch.com website which will return a Successful Connection. If this happens you can test getting a different error by turning off your WiFi and re-running the app
- Look at the section in ViewDidLoad which has the custom Error Descriptions. You can adjust the messages as you like, run the program again. 
- If you did not set a custom error description message for a particular error code it will default to the error’s localizedDescription
- You can also edit the custom error description messages directly in the ErrorDescriptor.m class file in the +(NSMutableDictionary *)errors; method. You will see two custom error messages already there.


To Add This Class to your own project
- Add the ErrorDescriptor.h and ErrorDescriptor.m files to your project
- #import ErrorDescriptor.h into any appropriate files
- Then create an NSDictionary (errors) of custom error messages you want to have for your project. The Key should be the Error Code and the value should be the Message you want to display. 
- Call this method in ViewDidLoad to add your NSDictionary of custom Error messages to the project
[ErrorDescriptor addCustomErrorDescriptions:errors];
- If you do not want to do this in ViewDidLoad you can add the Custom Error Descriptions you want directly in the +(NSMutableDictionary *)errors; method in ErrorDescriptor.m
- That’s all to set up the custom error messages. Then anywhere you would potentially need to display an error in your app, you can call the following method [ErrorDescriptor description:error]; 
- That’s it! 


For more on NSErrors and a more complete list of Error Codes and their Descriptions I recommend this article http://nshipster.com/nserror/