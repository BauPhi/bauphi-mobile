//
//  DataManager.m
//  BauPhi
//
//  Created by oyku suyun on 3.04.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import "DataManager.h"

#define DOKTAR_TOKEN                    @"Lpiw9fAVF9maOYYHYqRW1g=="
#define GET_HOME                    @"https://bauphi-api.herokuapp.com/api/users/:user_id/homes"

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

- (void) callMethod:(ServiceType)callType withParams:(NSDictionary *)paramDic{
    currentCallType = callType;
    
    NSString *path = @"";
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *headerParams = [[NSMutableDictionary alloc] init];
    [headerParams setObject:@"session_key" forKey:@"admin"];
    NSString *methodFormat = @"POST";
    BOOL isHeaderNeeded = YES;

    switch (currentCallType){
            
        case API_GET_HOME:
            methodFormat = @"GET";
            path = GET_HOME;
            [params setObject:[paramDic objectForKey:@"user_id"] forKey:@"user_id"];
            break;
    }
    
    NSURL *callURL = [NSURL URLWithString:path];
    NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:callURL cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:NSTimeIntervalSince1970];
    
    [rq setHTTPMethod:methodFormat];
    
    if ([methodFormat isEqualToString:@"GET"]) {
        NSData *postData = [self encodeDictionary:params];

        [rq setValue:@"*/*" forHTTPHeaderField:@"Accept"];
        [rq setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
        [rq setValue:@"Accept-Language" forHTTPHeaderField:@"en-us"];
        
        if (isHeaderNeeded) {
            [rq setValue:DOKTAR_TOKEN forHTTPHeaderField:@"token"];
        }
        
        [rq setHTTPBody:postData];
        
        [[session dataTaskWithRequest:rq
                    completionHandler:^(NSData *data,
                                        NSURLResponse *response,
                                        NSError *error) {
            if (!error) {
                if (data) {
                    if (data.length > 0)
                    {
                        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data
                                                                                options:0
                                                                                  error:NULL];
                        
                        if (dataDic) {
                            
                            [self->delegate callReturn:dataDic fromService:self->currentCallType];
                        }else{
                            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                            [dic setObject:@"error" forKey:@"error"];
                            [self->delegate callFail:dic fromService:self->currentCallType];
                        }
                    }else{
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                        [dic setObject:@"error" forKey:@"error"];
                        [self->delegate callFail:dic fromService:self->currentCallType];
                    }
                }else{
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                    [dic setObject:@"error" forKey:@"error"];
                    [self->delegate callFail:dic fromService:self->currentCallType];
                }
            }else{
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setObject:@"error" forKey:@"error"];
                [self->delegate callFail:dic fromService:self->currentCallType];
            }
        }] resume];
    }
}

- (NSData*)encodeDictionary:(NSDictionary*)dictionary
{
    
    NSMutableArray *parts = [[NSMutableArray alloc] init];
    for (NSString *key in dictionary) {
        NSString *encodedValue = [[dictionary objectForKey:key] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSString *encodedKey = [key stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSString *part = [NSString stringWithFormat: @"%@=%@", encodedKey, encodedValue];
        [parts addObject:part];
    }
    NSString *encodedDictionary = [parts componentsJoinedByString:@"&"];
    
    return [encodedDictionary dataUsingEncoding:NSUTF8StringEncoding];
}


@end
