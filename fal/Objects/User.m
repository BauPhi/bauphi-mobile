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
    return self;
}

-(void)logoutUser{
    userName = nil;
    userId = nil;
    userSignMethod=nil;
    [[FIRAuth auth] signOut:nil];
    
}

@end


