//
//  User.h
//  BauPhi
//
//  Created by oyku suyun on 5.04.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Firebase;
@import FirebaseAuth;

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject {
    
    NSString *userName;
    NSString *userSignMethod;
    NSString *userId;
    
}
@property (nonatomic,retain) NSString *userName;
@property (nonatomic,retain) NSString *userSignMethod;
@property (nonatomic,retain) NSString *userId;

+(instancetype)user;
-(void)logoutUser;


@end

NS_ASSUME_NONNULL_END


