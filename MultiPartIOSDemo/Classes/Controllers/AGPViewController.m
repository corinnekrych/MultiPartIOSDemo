//  AGPViewController.m
//
//  Generated by the the JBoss AeroGear Xcode Project Template on 9/12/13.
//  See Project's web site for more details http://www.aerogear.org
//

#import "AGPViewController.h"
#import "MultiPartIOSDemoAPIClient.h"

@implementation AGPViewController 

- (void)viewDidLoad {
    [super viewDidLoad];

    // access the singleton instance that holds our pipes
    MultiPartIOSDemoAPIClient *apiClient = [MultiPartIOSDemoAPIClient sharedInstance];
    
    // the files to be uploaded
    NSURL *file1 = [[NSBundle mainBundle] URLForResource:@"jboss" withExtension:@"jpg"];
    NSURL *file2 = [[NSBundle mainBundle] URLForResource:@"jboss2" withExtension:@"jpg"];

    // construct the data to sent with the files addes
    NSDictionary *dict = @{@"somekey": @"somevalue", @"jboss.jpg":file1, @"jboss2.jpg":file2 };
    
    // set an (optional) progress block
    [[apiClient uploadPipe] setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        NSLog(@"UPLOADPIPE Sent bytesWritten=%d totalBytesWritten=%qi of totalBytesExpectedToWrite=%qi bytes", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
    }];
    
    // upload data
    [[apiClient uploadPipe] save:dict success:^(id responseObject) {
        NSLog(@"Successfully uploaded!");

    } failure:^(NSError *error) {
        NSLog(@"An error has occured during read! \n%@", error);
    }];
}

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