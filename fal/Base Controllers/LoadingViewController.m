//
//  LoadingViewController.m
//  BauPhi
//
//  Created by oyku suyun on 7.03.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import "LoadingViewController.h"
#import "SignInViewController.h"
#import "User.h"
#import "TimeLineViewController.h"

@interface LoadingViewController ()

@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Userid: %@",[User user].userId);
    if(![[User user].userId isEqual:@""]){
        TimeLineViewController *moreVc=[[TimeLineViewController alloc]init];
        [self.navigationController pushViewController:moreVc animated:YES];
    }else{
        SignInViewController *moreVc=[[SignInViewController alloc]init];
        [self.navigationController pushViewController:moreVc animated:YES];
    }
}

- (void)notificationHandler:(NSNotification *)notif{

    if ([notif.name isEqualToString:@"OPEN_TAB_CONTENT"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            ViewController *view = (ViewController*)[[NSClassFromString([self->tabVCs objectAtIndex: [[notif.userInfo objectForKey:@"page"] intValue]]) alloc] init];
//            if([[notif.userInfo objectForKey:@"page"] intValue] == 4){
//                ProfileViewController *profile = [[ProfileViewController alloc] init];
//                [profile setUserId: [FIRAuth auth].currentUser.uid];
//                [self.navigationController pushViewController:profile animated:NO];
//            }
//            else{
                [self.navigationController pushViewController:view animated:NO];
 //           }
               
                
            
        });
    }

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
