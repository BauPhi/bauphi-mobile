//
//  AppDelegate.h
//  work
//
//  Created by Öykü on 1.10.2019.
//  Copyright © 2019 Öykü. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleSignIn;

@interface AppDelegate : UIResponder <UIApplicationDelegate,GIDSignInDelegate>{
    UITabBarController *tabBarController;
}

@property (strong, nonatomic) UIWindow *window;



@end

