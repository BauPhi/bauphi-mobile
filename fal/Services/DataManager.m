//
//  DataManager.m
//  BauPhi
//
//  Created by oyku suyun on 3.04.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import "DataManager.h"
#import "AFNetworking.h"
#import "AFNetworking/AFNetworking.h"

#define DOKTAR_TOKEN                @"admin"
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
    NSDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *methodFormat = @"POST";
    NSMutableDictionary *bodyParams = [[NSMutableDictionary alloc] init];
    BOOL isHeaderNeeded = YES;

    switch (currentCallType){
            
        case API_POST_USER_SIGNUP:{
            methodFormat = @"POST";
            path = [NSString stringWithFormat:@"https://bauphi-api.herokuapp.com/api/users"];
            params = @{@"name":[paramDic objectForKey:@"name"],
                       @"surname": [paramDic objectForKey:@"surname"],
                       @"email": [paramDic objectForKey:@"email"],
                       @"password": [paramDic objectForKey:@"password"],
                       @"phone": [paramDic objectForKey:@"phone"]};
            break;
        }
        case API_POST_USER_OAUTH:{
            methodFormat = @"POST";
            path = [NSString stringWithFormat:@"https://bauphi-api.herokuapp.com/api/users/google-auth"];
            params = @{@"access_token":[paramDic objectForKey:@"access_token"]};
            break;
        }
        case API_POST_USER_SIGNIN:{
            methodFormat = @"POST";
            path = [NSString stringWithFormat:@"https://bauphi-api.herokuapp.com/api/users/login"];
            params = @{@"email": [paramDic objectForKey:@"email"],@"password": [paramDic objectForKey:@"password"]};
            break;
        }
        case API_PATCH_USER_UPDATE:{
            methodFormat = @"PATCH";
            NSString *pathStr = [NSString stringWithFormat:@"%s%@","https://bauphi-api.herokuapp.com/api/users/",
                                 [paramDic objectForKey:@"user_id"]];
            path = pathStr;
            params = @{@"name": [paramDic objectForKey:@"name"],
                       @"surname": [paramDic objectForKey:@"surname"],
                       @"password": [paramDic objectForKey:@"password"],
                       @"email": [paramDic objectForKey:@"email"],
                       @"phone": [paramDic objectForKey:@"phone"]};
            break;
        }
            
        case API_PATCH_USER_DELETE: {
            methodFormat = @"DELETE";
            NSString *pathStr = [NSString stringWithFormat:@"%s%@","https://bauphi-api.herokuapp.com/api/users/",
                                 [paramDic objectForKey:@"user_id"]];
            path = pathStr;
            break;
        }
            
        case API_GET_HOME:{
            methodFormat = @"GET";
            path = @"https://bauphi-api.herokuapp.com/api/generic/all-homes";
            break;
        }
            
        case API_GET_HOME_CLOSE: {
            methodFormat = @"POST";
            path = @"https://bauphi-api.herokuapp.com/api/generic/get-close-homes";
            
            params = @{@"latitude": [paramDic objectForKey:@"latitude"],
                       @"longitude": [paramDic objectForKey:@"longitude"]};
            break;
        }
            
        case API_POST_HOME_ADD:{
            methodFormat = @"POST";
            NSString *pathStr = [NSString stringWithFormat:@"%s%@%s","https://bauphi-api.herokuapp.com/api/users/",
                                 [paramDic objectForKey:@"user_id"],"/homes"];
            path = pathStr;
            
            params = @{@"home_name": [paramDic objectForKey:@"home_name"],
                       @"isVisible": [paramDic objectForKey:@"isVisible"],
                       @"country": [paramDic objectForKey:@"country"],
                       @"state": [paramDic objectForKey:@"state"],
                       @"city": [paramDic objectForKey:@"city"],
                       @"neighbourhood": [paramDic objectForKey:@"neighbourhood"],
                       @"latitude": [paramDic objectForKey:@"latitude"],
                       @"longitude": [paramDic objectForKey:@"longitude"],
                       @"is_pets_allowed": [paramDic objectForKey:@"is_pets_allowed"]};
            break;
        }
            
        case API_POST_HOME_AUTOLOCATION:break;
            
        case API_DELETE_HOME: {
            methodFormat = @"DELETE";
            NSString *pathStr = [NSString stringWithFormat:@"%s%@%s","https://bauphi-api.herokuapp.com/api/users/",
                                 [paramDic objectForKey:@"user_id"],"/homes"];
            path = pathStr;
            break;
        }
            
        case API_PATCH_HOME_UPDATE: {
            methodFormat = @"PATCH";
            NSString *pathStr = [NSString stringWithFormat:@"%s%@%s","https://bauphi-api.herokuapp.com/api/users/",
                                 [paramDic objectForKey:@"user_id"],"/homes"];
            path = pathStr;
            
            params = @{@"home_name": [paramDic objectForKey:@"home_name"],
                       @"isVisible": [paramDic objectForKey:@"isVisible"],
                       @"country": [paramDic objectForKey:@"country"],
                       @"state": [paramDic objectForKey:@"state"],
                       @"city": [paramDic objectForKey:@"city"],
                       @"neighbourhood": [paramDic objectForKey:@"neighbourhood"],
                       @"latitude": [paramDic objectForKey:@"latitude"],
                       @"longitude": [paramDic objectForKey:@"longitude"],
                       @"is_pets_allowed": [paramDic objectForKey:@"is_pets_allowed"]};
            
            break;
        }
            
        case API_POST_OFFER_SEND:{
            methodFormat = @"POST";
            NSString *pathStr = [NSString stringWithFormat:@"%s%@%s","https://bauphi-api.herokuapp.com/api/users/",
                                 [paramDic objectForKey:@"user_id"],"/interactions/send-request"];
            path = pathStr;
            params = @{@"home": [paramDic objectForKey:@"home"],
                       @"home_owner": [paramDic objectForKey:@"home_owner"],
                       @"description": [paramDic objectForKey:@"description"]};
            break;
        }
            
        case API_PATCH_OFFER_ACCEPT: {
            methodFormat = @"PATCH";
            NSString *pathStr = [NSString stringWithFormat:@"%s%@%s","https://bauphi-api.herokuapp.com/api/users/",
                                 [paramDic objectForKey:@"user_id"],"/interactions/accept-request"];
            
            path = pathStr;
            params = @{@"victim": [paramDic objectForKey:@"victim"],
                       @"home": [paramDic objectForKey:@"home"]};
            
            break;
            
        }
            
        case API_PATCH_OFFER_REJECT: {
            methodFormat = @"PATCH";
            NSString *pathStr = [NSString stringWithFormat:@"%s%@%s","https://bauphi-api.herokuapp.com/api/users/",
                                 [paramDic objectForKey:@"user_id"],"/interactions/reject-request"];
            
            path = pathStr;
            params = @{@"victim": [paramDic objectForKey:@"victim"],
                       @"home": [paramDic objectForKey:@"home"]};
            
            break;
        }
        case API_GET_EVENT_CLOSE: {
            methodFormat = @"POST";
            path = @"https://bauphi-api.herokuapp.com/api/generic/get-close-homes";
            
            params = @{@"latitude": [paramDic objectForKey:@"latitude"],
                       @"longitude": [paramDic objectForKey:@"longitude"]};
            break;
        }
            
        case API_DELETE_OFFER: {
            methodFormat = @"DELETE";
            NSString *pathStr = [NSString stringWithFormat:@"%s%@%s%@","https://bauphi-api.herokuapp.com/api/users/",
                                 [paramDic objectForKey:@"user_id"],"/interactions/delete-request",[paramDic objectForKey:@"id"]];
            
            path = pathStr;
            break;
            
        }
            
        case API_GET_OFFER_SENT: {
            methodFormat = @"GET";
            NSString *pathStr = [NSString stringWithFormat:@"%s%@%s","https://bauphi-api.herokuapp.com/api/users/",
                                 [paramDic objectForKey:@"user_id"],"/interactions/sent-request-list"];
            
            path = pathStr;
            break;
        }
            
        case API_GET_OFFER_RECEIVED:{
            methodFormat = @"GET";
            NSString *pathStr = [NSString stringWithFormat:@"%s%@%s","https://bauphi-api.herokuapp.com/api/users/",
                                 [paramDic objectForKey:@"user_id"],"/interactions/received-request-list"];
            path = pathStr;
            break;
        }
            
        case API_GET_ALLEVENTS_USER: {
            methodFormat = @"GET";
            NSString *pathStr = [NSString stringWithFormat:@"%s%@%s","https://bauphi-api.herokuapp.com/api/users/",
                                 [paramDic objectForKey:@"user_id"],"/events"];
            path = pathStr;
            break;
        }
            
        case API_GET_EVENT_USER:{
            methodFormat = @"GET";
            NSString *pathStr = [NSString stringWithFormat:@"%s%@%s%@","https://bauphi-api.herokuapp.com/api/users/",
                                 [paramDic objectForKey:@"user_id"],"/events/",[paramDic objectForKey:@"id"]];
            path = pathStr;
            break;
        }
            
        case API_POST_EVENT_ADD:{
            methodFormat = @"POST";
            NSString *pathStr = [NSString stringWithFormat:@"%s%@%s","https://bauphi-api.herokuapp.com/api/users/",
                                 [paramDic objectForKey:@"user_id"],"/events"];
            path = pathStr;
            params = @{@"start_time": [paramDic objectForKey:@"start_time"],
                       @"end_time": [paramDic objectForKey:@"end_time"],
                       @"type": [paramDic objectForKey:@"type"],
                       @"title": [paramDic objectForKey:@"title"],
                       @"description": [paramDic objectForKey:@"description"],
                       @"is_emergency": [paramDic objectForKey:@"is_emergency"],
                       @"country": [paramDic objectForKey:@"country"],
                       @"state": [paramDic objectForKey:@"state"],
                       @"city": [paramDic objectForKey:@"city"],
                       @"neighbourhood": [paramDic objectForKey:@"neighbourhood"],
                       @"latitude": [paramDic objectForKey:@"latitude"],
                       @"longitude": [paramDic objectForKey:@"longitude"],
                       @"currency": [paramDic objectForKey:@"currency"],
                       @"amount": [paramDic objectForKey:@"amount"]};
            break;
        }
        
            
        case API_DELETE: {
            // MARK: CHECK LATER!
        }
            
        case API_PATCH_EVENT_UPDATE: {
            methodFormat = @"PATCH";
            NSString *pathStr = [NSString stringWithFormat:@"%s%@%s","https://bauphi-api.herokuapp.com/api/users/",
                                 [paramDic objectForKey:@"user_id"],"/events"];
            path = pathStr;
            
            params = @{@"start_time": [paramDic objectForKey:@"start_time"],
                       @"end_time": [paramDic objectForKey:@"end_time"],
                       @"type": [paramDic objectForKey:@"type"],
                       @"title": [paramDic objectForKey:@"title"],
                       @"description": [paramDic objectForKey:@"description"],
                       @"is_emergency": [paramDic objectForKey:@"is_emergency"],
                       @"country": [paramDic objectForKey:@"country"],
                       @"state": [paramDic objectForKey:@"state"],
                       @"city": [paramDic objectForKey:@"city"],
                       @"neighbourhood": [paramDic objectForKey:@"neighbourhood"],
                       @"latitude": [paramDic objectForKey:@"latitude"],
                       @"longitude": [paramDic objectForKey:@"longitude"],
                       @"currency": [paramDic objectForKey:@"currency"],
                       @"amount": [paramDic objectForKey:@"amount"]};
            break;
        }
        
        case API_POST_EVENT_JOIN: {
            methodFormat = @"POST";
            NSString *pathStr = [NSString stringWithFormat:@"%s%@%s","https://bauphi-api.herokuapp.com/api/users/",
                                 [paramDic objectForKey:@"user_id"],"/interactions/join-event"];
            path = pathStr;
            params = @{@"event": [paramDic objectForKey:@"event"],
                       @"comment": [paramDic objectForKey:@"comment"]};
            
            break;
        }
        
        case API_DELETE_EVENT: {
            methodFormat = @"DELETE";
            NSString *pathStr = [NSString stringWithFormat:@"%s%@%s%@","https://bauphi-api.herokuapp.com/api/users/",
                                 [paramDic objectForKey:@"user_id"],"/events",[paramDic objectForKey:@"id"]];
            
            path = pathStr;
            break;
        }
            
        case API_GET_ANNOUNCEMENT_USER:{
            methodFormat = @"GET";
            NSString *pathStr = [NSString stringWithFormat:@"%s%@%s","https://bauphi-api.herokuapp.com/api/users/",
                                 [paramDic objectForKey:@"user_id"],"/announcements"];
            path = pathStr;
            break;
        }
            
        case API_GET_ANNOUNCEMENT:{
            methodFormat = @"GET";
            NSString *pathStr = [NSString stringWithFormat:@"%s%@%s%@","https://bauphi-api.herokuapp.com/api/users/",
                                 [paramDic objectForKey:@"user_id"],"/announcements",[paramDic objectForKey:@"id"]];
            path = pathStr;
            break;
        }
            
        case API_POST_ANNOUNCEMENT_ADD:{
            methodFormat = @"POST";
            NSString *pathStr = [NSString stringWithFormat:@"%s%@%s","https://bauphi-api.herokuapp.com/api/users/",
                                 [paramDic objectForKey:@"user_id"],"/announcements"];
            path = pathStr;
            params = @{@"session_key": [paramDic objectForKey:@"session_key"],
                       @"image": [paramDic objectForKey:@"image"],
                       @"phone": [paramDic objectForKey:@"phone"],
                       @"title": [paramDic objectForKey:@"title"],
                       @"description": [paramDic objectForKey:@"description"],
                       @"isHuman": [paramDic objectForKey:@"isHuman"]};
            break;
        }
        case API_DELETE_ANNOUNCEMENT: {
            methodFormat = @"DELETE";
            NSString *pathStr = [NSString stringWithFormat:@"%s%@%s%@","https://bauphi-api.herokuapp.com/api/users/",
                                 [paramDic objectForKey:@"user_id"],"/announcements",[paramDic objectForKey:@"id"]];
            path = pathStr;
            
            break;
        }
        case API_PATCH_ANNOUNCEMENT: {
            methodFormat = @"PATCH";
            NSString *pathStr = [NSString stringWithFormat:@"%s%@%s%@","https://bauphi-api.herokuapp.com/api/users/",
                                 [paramDic objectForKey:@"user_id"],"/announcements",[paramDic objectForKey:@"id"]];
            path = pathStr;
            
            params = @{@"session_key": [paramDic objectForKey:@"session_key"],
                       @"image": [paramDic objectForKey:@"image"],
                       @"phone": [paramDic objectForKey:@"phone"],
                       @"title": [paramDic objectForKey:@"title"],
                       @"description": [paramDic objectForKey:@"description"],
                       @"isHuman": [paramDic objectForKey:@"isHuman"]};
            break;
        }

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
    }else if([methodFormat isEqualToString:@"POST"]) {
  
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        if(isHeaderNeeded){
            [manager.requestSerializer setValue:@"admin" forHTTPHeaderField:@"session_key"];
        }
        
        [manager POST:path parameters:params success:^(NSURLSessionTask *task, id responseObject) {
  
            // Login response validation
            if (responseObject == [NSNull null]) {
                
            }else {
                //NSError *error = nil;
                NSLog(@"response type : %@", NSStringFromClass([responseObject class]));
                //NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
                [self->delegate callReturn:responseObject fromService:self->currentCallType];
            }

        } failure:^(NSURLSessionTask *task, NSError *error) {

            NSLog(@"AFHTTPSession Failure : %@", [error localizedDescription]);
            [self->delegate callFail:nil fromService:self->currentCallType];
        }];
        
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
