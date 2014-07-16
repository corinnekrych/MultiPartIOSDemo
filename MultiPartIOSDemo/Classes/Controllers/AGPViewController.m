//  AGPViewController.m
//
//  Generated by the the JBoss AeroGear Xcode Project Template on 9/12/13.
//  See Project's web site for more details http://www.aerogear.org
//

#import "AGPViewController.h"
#import "MultiPartIOSDemoAPIClient.h"

@implementation AGPViewController 

- (void)viewDidLoad {

    
    NSURL *file1 = [[NSBundle mainBundle] URLForResource:@"jboss" withExtension:@"jpg"];
    NSString *stringPath = [file1 absoluteString];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:stringPath]];
    
    NSURL *URL = [NSURL URLWithString:@"http://192.168.0.13:8080/aerogear-integration-tests-server/rest/upload"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod: @"POST"];
    
    NSString *boundary = @"YOUR_BOUNDARY_STRING";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];

    NSMutableData *body = [NSMutableData data];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"photo\"; filename=\"%@.jpg\"\r\n", @"jboss"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"message\"\r\n\r\n%@", @"some moooore test here"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user\"\r\n\r\n%d", 1] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //[request setHTTPBody:body];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request
                                                               fromData:body
                                                      completionHandler:
                                          ^(NSData *data, NSURLResponse *response, NSError *error) {
                                              NSLog(@"Uploading.....RESP::%@ ERROR::%@" , response, error);
                                          }];
    
    [uploadTask resume];
}
/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // access the singleton instance that holds our pipes
    MultiPartIOSDemoAPIClient *apiClient = [MultiPartIOSDemoAPIClient sharedInstance];
    
    // add local files
    NSURL *file1 = [[NSBundle mainBundle] URLForResource:@"jboss" withExtension:@"jpg"];
    NSURL *file2 = [[NSBundle mainBundle] URLForResource:@"jboss2" withExtension:@"jpg"];
    AGFilePart *filePart1 = [[AGFilePart alloc]initWithFileURL:file1 name:@"file1"];
    AGFilePart *filePart2 = [[AGFilePart alloc]initWithFileURL:file2 name:@"file2"];
    
    // add straight data objects
    
    // add simple text
    NSData *data1 = [@"Lorem ipsum dolor sit amet," dataUsingEncoding:NSUTF8StringEncoding];
    AGFileDataPart *dataPart1 = [[AGFileDataPart alloc] initWithFileData:data1
                                                                    name:@"data1"
                                                                fileName:@"data1.txt" mimeType:@"text/plain"];

    // add binary data
    NSData *data2 = [NSData dataWithContentsOfURL:file1];
    AGFileDataPart *dataPart2 = [[AGFileDataPart alloc] initWithFileData:data2
                                                                    name:@"data2"
                                                                fileName:@"data2.png" mimeType:@"image/jpeg"];
    
    // set up payload
    NSDictionary *dict = @{@"somekey": @"somevalue",
                           @"file1":filePart1,
                           @"file2":filePart2,
                           @"data1:": dataPart1,
                           @"data2:": dataPart2};
    
    // set an (optional) progress block
    [[apiClient uploadPipe] setUploadProgressBlock:^(NSURLSession *session, NSURLSessionTask *task, int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
        NSLog(@"UPLOADPIPE Sent bytesWritten=%lld totalBytesWritten=%qi of totalBytesExpectedToWrite=%qi bytes", bytesSent, totalBytesSent, totalBytesExpectedToSend);
    }];
    
    // upload data
    [[apiClient uploadPipe] save:dict success:^(id responseObject) {
        NSLog(@"%@", [responseObject description]);
//

    } failure:^(NSError *error) {
        NSLog(@"An error has occured during upload! \n%@", error);
    }];
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end