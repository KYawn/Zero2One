//
//  ChangePwdTableViewController.m
//  Zero2One
//
//  Created by K.Yawn Xoan on 4/28/15.
//  Copyright (c) 2015 KevinHsiun. All rights reserved.
//

#import "ChangePwdTableViewController.h"

@interface ChangePwdTableViewController ()

@end

@implementation ChangePwdTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
#pragma mark - button action events
//cancel button clicked
- (IBAction)cancelBtnClicked:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
//cancel button clicked
- (IBAction)saveBtnClicked:(UIBarButtonItem *)sender {
    
    
    //pick the username from userdefault
    NSUserDefaults *UserDefault = [NSUserDefaults standardUserDefaults];
    NSLog(@"username=%@&password=%@",[UserDefault stringForKey:@"username"],_changePwdTextField.text);
    
    [SVProgressHUD showWithStatus:@"changing" maskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD setBackgroundColor:[UIColor grayColor]];
    NSURL *url = [NSURL URLWithString:@"http://www.azfs.com.cn/Login/changePwd.php"];
    NSString *post = [[NSString alloc]initWithFormat:@"username=%@&password=%@",[UserDefault stringForKey:@"username"],_changePwdTextField.text ];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:postData];
    [req setTimeoutInterval:10.0];
    
    NSOperationQueue *myQueue = [NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:req queue:myQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            
            NSLog(@"Http error:%@%ld",connectionError.localizedDescription,(long)connectionError.code);
            
        }else{
            
            [SVProgressHUD dismiss];
            NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
            NSString *responseString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"Http Response Code :%ld",(long)responseCode);
            NSLog(@"http Response String: %@",responseString);
            
            if ([responseString isEqualToString:@"success"]) {
                
                NSLog(@"change success ");
                [SVProgressHUD showSuccessWithStatus:@"change success, please relogin"];
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                id mainViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginView"];
                [self presentViewController:mainViewController animated:YES completion:^{
                }];
                
            }else{
                
                NSLog(@"change failed ");
                [SVProgressHUD showErrorWithStatus:@"change failed"];
            }
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 
 #pragma mark - Table view data source
 
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 #warning Potentially incomplete method implementation.
 // Return the number of sections.
 return 0;
 }
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 #warning Incomplete method implementation.
 // Return the number of rows in the section.
 return 0;
 }
 
 */

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

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
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
