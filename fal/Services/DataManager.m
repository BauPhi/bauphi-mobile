//
//  DataManager.m
//  BauPhi
//
//  Created by oyku suyun on 3.04.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import "DataManager.h"

#define DOKTAR_TOKEN                    @"admin"
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
    NSString *methodFormat = @"POST";
    NSMutableDictionary *bodyParams = [[NSMutableDictionary alloc] init];
    BOOL isHeaderNeeded = YES;

    switch (currentCallType){
            
        case API_POST_USER_SIGNUP:{
            methodFormat = @"POST";
            path = @"https://bauphi-api.herokuapp.com/api/users";
            [bodyParams setObject:[paramDic objectForKey:@"name"] forKey:@"name"];
            [bodyParams setObject:[paramDic objectForKey:@"surname"] forKey:@"surname"];
            [bodyParams setObject:[paramDic objectForKey:@"password"] forKey:@"password"];
            [bodyParams setObject:[paramDic objectForKey:@"email"] forKey:@"email"];
            [bodyParams setObject:[paramDic objectForKey:@"phone"] forKey:@"phone"];
            break;
        }
        case API_POST_USER_SIGNIN:
        case API_PATCH_USER_UPDATE:
        case API_PATCH_USER_DELETE:
        case API_GET_HOME:{
            methodFormat = @"GET";
            NSString *pathStr = [NSString stringWithFormat:@"%s%@%s","https://bauphi-api.herokuapp.com/api/users/",[paramDic objectForKey:@"user_id"],"/homes"];
            path = pathStr;
            break;
        }
        case API_GET_HOME_CLOSE:break;
        case API_POST_HOME_ADD:break;
        case API_POST_HOME_AUTOLOCATION:break;
        case API_DELETE_HOME:break;
        case API_PATCH_HOME_UPDATE:break;
        case API_POST_OFFER_SEND:break;
        case API_PATCH_OFFER_ACCEPT:break;
        case API_PATCH_OFFER_REJECT:break;
        case API_DELETE_OFFER:break;
        case API_GET_OFFER_SENT:break;
        case API_GET_OFFER_RECEIVED:break;
        case API_GET_ALLEVENTS_USER:break;
        case API_GET_EVENT_USER:break;
        case API_POST_EVENT_ADD:break;
        case API_DELETE:break;
        case API_PATCH_EVENT_UPDATE:break;
        case API_POST_EVENT_JOIN:break;
        case API_DELETE_EVENT:break;
        case API_GET_ANNOUNCEMENT_USER:break;
        case API_GET_ANNOUNCEMENT:break;
        case API_POST_ANNOUNCEMENT_ADD:break;
        case API_DELETE_ANNOUNCEMENT:break;
        case API_PATCH_ANNOUNCEMENT:break;

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
            [rq setValue:@"admin" forHTTPHeaderField:@"session_key"];
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
                        } else{
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
    }else {
        
        NSError *error;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:params
                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        [rq setHTTPMethod:@"POST"];
        
        [rq setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [rq setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [rq setValue:@"b19d9e8cec264cb183cb2eb2a971e02b" forHTTPHeaderField:@"Ocp-Apim-Subscription-Key"];
        [rq setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[postData length]] forHTTPHeaderField:@"Content-Length"];
        [rq setHTTPBody:postData];
        
        [[session dataTaskWithRequest:rq
                    completionHandler:^(NSData *data,
                                        NSURLResponse *response,
                                        NSError *error) {
                        if (data) {
                            if (data.length > 0 && error == nil)
                            {
                                
                                id dataDic = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:0
                                                                               error:NULL];
                                
                                if (dataDic) {
                                    [self->delegate callReturn:dataDic fromService:self->currentCallType];
                                }else{
                                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                                    [dic setObject:@"error" forKey:@"error"];
                                    [self->delegate callReturn:dic fromService:self->currentCallType];
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
                        
                        if (error) {
                            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                            [dic setObject:error forKey:@"error"];
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
