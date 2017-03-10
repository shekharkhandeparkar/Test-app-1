//
//  LoginViewController.m
//  Test app 1
//
//  Created by Mobile Developer on 3/6/17.
//  Copyright © 2017 Mobile Developer. All rights reserved.
//

#import "LoginViewController.h"
#import "CollectionViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController {
    NSMutableData *mutableData;
    NSString *serverResponse;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CollectionViewController *back=[[CollectionViewController alloc] initWithNibName:nil bundle:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:back animated:YES completion:nil];
        
    });
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)userSwitch:(id)sender {
    UISwitch *mySwitch = (UISwitch *)sender;
    if ([mySwitch isOn]) {
        NSLog(@"its on!");
    } else {
        NSLog(@"its off!");
    }
}

- (IBAction)loginClicked:(id)sender {
    NSLog(@"its on!");
    [self sendDataToServer :@"POST"];
}



-(void) sendDataToServer : (NSString *) method{
    
    NSString *usrname  = _usern.text;
    NSString *pass = _passw.text;
    
    if(usrname.length > 0 && pass.length > 0){
        
        serverResponse = @"Getting response from server...";
        
        NSURL *url = nil;
        NSMutableURLRequest *request = nil;
        
        // Only Difference between POST and GET is only in the way they send parameters
        
        if([method isEqualToString:@"GET"]){
            
            NSString *getURL = [NSString stringWithFormat:@"%@?username=%@&password=%@", @"http://13.76.222.174/MobileScripts_LupinUAT/configurator.php", usrname, pass ];
            url = [NSURL URLWithString: getURL];
            request = [NSMutableURLRequest requestWithURL:url];
            
        }else{  // POST
            
            NSString *parameter = [NSString stringWithFormat:@"username=%@&password=%@",usrname, pass ];
            NSData *parameterData = [parameter dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            ;
            url = [NSURL URLWithString: @"http://13.76.222.174/MobileScripts_LupinUAT/configurator.php"];
            request = [NSMutableURLRequest requestWithURL:url];
            [request setHTTPBody:parameterData];
            
        }
        
        [request setHTTPMethod:method];
        [request addValue: @"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        if( connection )
        {
            
            mutableData = [NSMutableData new];
            
        }else{
            
            serverResponse = @"NO_CONNECTION";
            
        }
        
    }else{
        
        serverResponse = @"NO_VALUES";
        
    }
    
//    NSString *jsonFileUrl = [NSString stringWithFormat:@"%@?username=%@&password=%@", @"http://13.76.222.174/MobileScripts_LupinUAT/configurator.php", usrname, pass ];
//    
//    NSURL *url = [NSURL URLWithString:jsonFileUrl];
//    NSURLSession *session = [NSURLSession sharedSession];
//    [[session dataTaskWithURL:url
//            completionHandler:^(NSData *data,
//                                NSURLResponse *response,
//                                NSError *error) {
//                
//                NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                // handle response
//                NSLog(@"its onnnnnn! %@", string);
//                
//                NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
//                NSInteger statusCode = [HTTPResponse statusCode];
//                // handle response
//                NSLog(@"its onnnnnn! %ld", (long)statusCode);
//                
//                if(statusCode == 200) {
//                    NSMutableArray *groups = [[NSMutableArray alloc] init];
//                    NSError *localError = nil;
//                    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
//                    
//                    NSArray *results = [parsedObject valueForKey:@"Configurator_data"];
//                    NSLog(@"Count %lu", (unsigned long)results.count);
//                    
//                    for (NSDictionary *groupDic in results) {
//                        
//                        
//                        NSMutableArray *group = [[NSMutableArray alloc] init];
//
//                        for (NSString *key in groupDic) {
//                            if ([group respondsToSelector:NSSelectorFromString(key)]) {
//                                [group setValue:[groupDic valueForKey:key] forKey:key];
//                            }
//                        }
//
//                        [groups addObject:group];
//                    }
//                    
//                }
//                
//            }] resume];
    
//    NSError *error;
//    
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURL *url = [NSURL URLWithString:@"http://13.76.222.174/MobileScripts_LupinUAT/configurator.php"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
//                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
//                                                       timeoutInterval:60.0];
//    
//    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    
//    [request setHTTPMethod:@"POST"];
//    NSDictionary *mapData = [[NSDictionary alloc] initWithObjectsAndKeys:
//                             @"crmtest7", @"username", @"Welcome@1234", @"password",
//                             nil];
//    NSData *postData = [NSJSONSerialization dataWithJSONObject:mapData options:0 error:&error];
//    [request setHTTPBody:postData];
//    
//    
//    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                        // handle response
//                        NSLog(@"its onnnnnn! %@", string);
//        
//                        NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
//                        NSInteger statusCode = [HTTPResponse statusCode];
//                        // handle response
//                        NSLog(@"its onnnnnn! %ld", (long)statusCode);
//    }];
//    
//    [postDataTask resume];
//    
//    NSURLSessionConfiguration *configuration2 = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session2 = [NSURLSession sessionWithConfiguration:configuration2];
//    
//    NSMutableURLRequest *request2 = [[NSMutableURLRequest alloc] init];
//    [request2 setHTTPMethod:@"POST"];
//
//    // choose the right type for your value.
//    NSDictionary *postDict = @{@"username": @"crmtest7", @"password": @"Welcome@1234"};
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:postDict
//                                                       options:NSJSONWritingPrettyPrinted
//                                                         error:nil];
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//    NSData *postData2 = [NSJSONSerialization dataWithJSONObject:postDict options:0 error:nil];
//    [request2 setURL:[NSURL URLWithString:@"http://13.76.222.174/MobileScripts_LupinUAT/configurator.php"]];
////    [request2 setHTTPBody:postData2];
//    NSString *postString = jsonString;
//    NSData *data2 = [postString dataUsingEncoding:NSUTF8StringEncoding];
//    [request2 setHTTPBody:data2];
//    [request2 setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[data2 length]] forHTTPHeaderField:@"Content-Length"];
//    [request2 setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    
//    [NSURLConnection connectionWithRequest:request2 delegate:self];
//    NSData *retData=    [NSURLConnection sendSynchronousRequest:request2 returningResponse:nil error:nil];
//    
//    NSString *retDataStr=[[NSString alloc] initWithData:retData encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",retDataStr);
//    
////    NSString *postString = @"username=crmtest7&password=Welcome@1234";
////    [request2 setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
////    
////     NSURLSessionDataTask *postDataTask2 = [session2 dataTaskWithRequest:request2 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
////         NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
////         // handle response
////         NSLog(@"its onnnnnn! %@", string);
////         
////         NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
////         NSInteger statusCode = [HTTPResponse statusCode];
////         // handle response
////         NSLog(@"its onnnnnn! %ld", (long)statusCode);
////
////    }];
////     [postDataTask2 resume];

    
//    NSDictionary *d = @{ @"login":@"myLogin", @"udid":@"myUDID" };
//    
//    NSError *error = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:d
//                                                       options:NSJSONWritingPrettyPrinted
//                                                         error:&error];
//    
//    NSHTTPRequest *request = [NSHTTPRequest requestWithURLString:@"http://moscow2013.hol.es/test.php"];
//    
//    [request setHeaderWithName:@"content-type" value:@"application/json; charset=utf-8"];
//    
//    request.rawPOSTData = jsonData;
//    
//    request.completionBlock=^(NSDictionary *headers, NSString *body) {
//        NSLog(@"Body: %@", body);
//    };
//    
//    request.errorBlock=^(NSError *error) {
//        NSLog(@"Error: %@", [error localizedDescription]);
//    };
//    
//    [request startAsynchronous];
    
//    NSDictionary* mainJSON = [NSDictionary dictionaryWithObjectsAndKeys:
//                              @"crmtest7",@"username",
//                              @"Welcome@1234",@"password",
//                              nil];
//    
//    NSError * err;
//    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mainJSON options:NSJSONWritingPrettyPrinted error:&err];
//    NSString * prams = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSString *urlString=@"http://13.76.222.174/MobileScripts_LupinUAT/configurator.php";
//    prams = [prams stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
//    
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
//    NSData *requestData = [prams dataUsingEncoding:NSUTF8StringEncoding];
//    
//    if (prams.length>0) {
//        [urlRequest setHTTPMethod:@"POST"];
//        [urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//        [urlRequest setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
//        [urlRequest setHTTPBody: requestData];
//    }
//    
//    NSURLSessionDataTask * dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        //NSLog(@"data=%@",data);
//        
//        if (data.length>0 && error==nil) {
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
//            NSLog(@"Dict=%@",dict);
//            
//            
//        }
//        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        //         // handle response
//        NSLog(@"its onnnnnn! %@", string);
//
//    }];
//    [dataTask resume];
    
//    NSString*username = @"crmtest7";
//    NSString*password = @"Welcome@1234";
//    NSString*post = [NSString stringWithFormat:@"username=%@&password=%@" ,usrname,pass];
//    NSString *username = @"admin";
//    NSString *password = @"admin";
    //got the format from postman by having a key and a value for the username and password
    NSString *post = [NSString stringWithFormat:@"username=%@&password=%@",usrname, @"Welcome@1234"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu" , (unsigned long)[postData length]];
    NSURL *url = [NSURL URLWithString:@"http://13.76.222.174/MobileScripts_LupinUAT/configurator.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    //got the value for the Content-Type from postman
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                  
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      
//                                      if (error) {
//                                          // Handle error...
//                                          return;
//                                      }
                                      
                                      if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                          NSLog(@"Response HTTP Status code: %ld\n", (long)[(NSHTTPURLResponse *)response statusCode]);
                                          NSLog(@"Response HTTP Headers:\n%@\n", [(NSHTTPURLResponse *)response allHeaderFields]);
                                      }
                                      
                                      NSString* body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                      NSLog(@"Response Body:\n%@\n", body);
                                      NSMutableArray *groups = [[NSMutableArray alloc] init];
                                      NSError *localError = nil;
                                      NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
                  
                                      NSDictionary *results = [parsedObject valueForKey:@"code"];
                                      NSLog(@"Response results code :\n%@\n", [results valueForKey:@"code"]);
                                      
                                      NSString *code_Str = [NSString stringWithFormat:@"%@",[results objectForKey:@"code"]];
                                      
                                      if ([code_Str isEqualToString:@"0"]){
//                                          if([code isEqualToString:@"0"]) {
                                          CollectionViewController *back=[[CollectionViewController alloc] initWithNibName:nil bundle:nil];
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              [self presentViewController:back animated:YES completion:nil];
                                              
                                          });
                                      }
                                  }];
    [task resume];
}

#pragma mark NSURLConnection delegates

-(void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *)response
{
    [mutableData setLength:0];
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [mutableData appendData:data];
}

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    serverResponse = @"NO_CONNECTION";
    return;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *responseStringWithEncoded = [[NSString alloc] initWithData: mutableData encoding:NSUTF8StringEncoding];
    //NSLog(@"Response from Server : %@", responseStringWithEncoded);
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[responseStringWithEncoded dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    serverResponse = [NSString stringWithFormat:@"%@", attrStr];
}
@end
