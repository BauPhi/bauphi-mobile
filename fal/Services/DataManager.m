//
//  DataManager.m
//  BauPhi
//
//  Created by oyku suyun on 3.04.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager
@synthesize delegate;
@synthesize session;

+ (instancetype)sharedManager{
    static DataManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[DataManager alloc] init];
    });
    
    return _sharedClient;
}

- (id)init {
    self = [super init];
    
    if (nil != self)
    {
        
        self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]
                                                     delegate:self
                                                delegateQueue:NSOperationQueue.mainQueue];
    }
    return self;
}

@end
