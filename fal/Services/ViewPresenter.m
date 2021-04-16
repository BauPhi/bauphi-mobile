//
//  ViewPresenter.m
//  BauPhi
//
//  Created by oyku suyun on 3.04.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import "ViewPresenter.h"

@implementation ViewPresenter
@synthesize delegate;

+ (instancetype)sharedManager{
    static ViewPresenter *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[ViewPresenter alloc] init];
    });
    
    return _sharedClient;
}

- (id)init {
    self = [super init];
    
    if (nil != self) {
        [DataManager sharedManager].delegate = self;
    }
    return self;
}

-(void) createUser: (NSDictionary *)paramDic{
    NSDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@"email" forKey:@"email"];
    [params setValue:@"password" forKey:@"password"];
    [[DataManager sharedManager] callMethod:API_POST_USER_SIGNIN withParams:params];
}

- (void) callReturn:(NSDictionary *)returnDic fromService:(ServiceType)callType{
    NSLog(@"callReturn ServiceType: %lu and returnDic: %@",(unsigned long)callType,returnDic);
    currentCallType = callType;
    switch (currentCallType){
            
        case API_POST_USER_SIGNUP:{
            [self->delegate changePage];
            break;
        }
        case API_POST_USER_SIGNIN:{
            [self->delegate changePage];
            break;
        }
        case API_PATCH_USER_UPDATE:{

            break;
        }
            
        case API_PATCH_USER_DELETE: {

            break;
        }
            
        case API_GET_HOME:{

            break;
        }
            
        case API_GET_HOME_CLOSE: {
            
            break;
        }
            
        case API_POST_HOME_ADD:{

        }
            
        case API_POST_HOME_AUTOLOCATION:break;
            
        case API_DELETE_HOME: {

            break;
        }
            
        case API_PATCH_HOME_UPDATE: {

            
            break;
        }
            
        case API_POST_OFFER_SEND:{

            break;
        }
            
        case API_PATCH_OFFER_ACCEPT: {
            
            break;
            
        }
            
        case API_PATCH_OFFER_REJECT: {
            
            break;
        }
            
        case API_DELETE_OFFER: {
            break;
            
        }
            
        case API_GET_OFFER_SENT: {
            break;
        }
            
        case API_GET_OFFER_RECEIVED:{
            break;
        }
            
        case API_GET_ALLEVENTS_USER: {
            break;
        }
            
        case API_GET_EVENT_USER:{
            break;
        }
            
        case API_POST_EVENT_ADD:{
            break;
        }
        
            
        case API_DELETE: {
        }
            
        case API_PATCH_EVENT_UPDATE: {
            break;
        }
        
        case API_POST_EVENT_JOIN: {
            
            break;
        }
        
        case API_DELETE_EVENT: {
            break;
        }
            
        case API_GET_ANNOUNCEMENT_USER:{
            break;
        }
            
        case API_GET_ANNOUNCEMENT:{
            break;
        }
            
        case API_POST_ANNOUNCEMENT_ADD:{
            break;
        }
        case API_DELETE_ANNOUNCEMENT: {
            
            break;
        }
        case API_PATCH_ANNOUNCEMENT: {
            break;
        }
    }
}

- (void) callFail:(NSDictionary *)returnDic fromService:(ServiceType)callType{
    NSLog(@"callFail ServiceType: %lu and returnDic: %@",(unsigned long)callType,returnDic);
    switch (currentCallType){
            
        case API_POST_USER_SIGNUP:{

            break;
        }
        case API_POST_USER_SIGNIN:{

            break;
        }
        case API_PATCH_USER_UPDATE:{

            break;
        }
            
        case API_PATCH_USER_DELETE: {

            break;
        }
            
        case API_GET_HOME:{

            break;
        }
            
        case API_GET_HOME_CLOSE: {
            
            break;
        }
            
        case API_POST_HOME_ADD:{

        }
            
        case API_POST_HOME_AUTOLOCATION:break;
            
        case API_DELETE_HOME: {

            break;
        }
            
        case API_PATCH_HOME_UPDATE: {

            
            break;
        }
            
        case API_POST_OFFER_SEND:{

            break;
        }
            
        case API_PATCH_OFFER_ACCEPT: {
            
            break;
            
        }
            
        case API_PATCH_OFFER_REJECT: {
            
            break;
        }
            
        case API_DELETE_OFFER: {
            break;
            
        }
            
        case API_GET_OFFER_SENT: {
            break;
        }
            
        case API_GET_OFFER_RECEIVED:{
            break;
        }
            
        case API_GET_ALLEVENTS_USER: {
            break;
        }
            
        case API_GET_EVENT_USER:{
            break;
        }
            
        case API_POST_EVENT_ADD:{
            break;
        }
        
            
        case API_DELETE: {
        }
            
        case API_PATCH_EVENT_UPDATE: {
            break;
        }
        
        case API_POST_EVENT_JOIN: {
            
            break;
        }
        
        case API_DELETE_EVENT: {
            break;
        }
            
        case API_GET_ANNOUNCEMENT_USER:{
            break;
        }
            
        case API_GET_ANNOUNCEMENT:{
            break;
        }
            
        case API_POST_ANNOUNCEMENT_ADD:{
            break;
        }
        case API_DELETE_ANNOUNCEMENT: {
            
            break;
        }
        case API_PATCH_ANNOUNCEMENT: {
            break;
        }
    }
}

@end
