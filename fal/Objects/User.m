//
//  User.m
//  BauPhi
//
//  Created by oyku suyun on 5.04.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize userName;
@synthesize userId;
@synthesize userSignMethod;
@synthesize userEmail;
@synthesize userPhone;
@synthesize userSurname;

+ (instancetype)user
{
    static User *_user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _user = [[User alloc] init];
    });
    
    return _user;
}

-(id) init {
    self = [super init];
    userName = @"";
    userId = @"";
    userSignMethod= @"";
    userEmail=@"";
    userPhone=@"";
    userSurname=@"";
    return self;
}

-(void)logoutUser{
    userName = nil;
    userId = nil;
    userSignMethod=nil;
    userEmail=nil;
    userPhone=nil;
    userSurname=nil;
    [[FIRAuth auth] signOut:nil];
    
}

@end


