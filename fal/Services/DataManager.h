//
//  DataManager.h
//  BauPhi
//
//  Created by oyku suyun on 3.04.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum ServiceType : NSUInteger {
    API_CONFIG,
    API_POST_USER_SIGNUP,
    API_POST_USER_SIGNIN,
    API_PATCH_USER_UPDATE,
    API_PATCH_USER_DELETE,
    API_GET_HOME,
    API_GET_HOME_CLOSE,
    API_POST_HOME_ADD,
    API_POST_HOME_AUTOLOCATION,
    API_DELETE_HOME,
    API_PATCH_HOME_UPDATE,
    API_POST_OFFER_SEND,
    API_PATCH_OFFER_ACCEPT,
    API_PATCH_OFFER_REJECT,
    API_DELETE_OFFER,
    API_GET_OFFER_SENT,
    API_GET_OFFER_RECEIVED,
    API_GET_ALLEVENTS_USER,
    API_GET_EVENT_USER,
    API_POST_EVENT_ADD,
    API_DELETE,
    API_PATCH_EVENT_UPDATE,
    API_POST_EVENT_JOIN,
    API_DELETE_EVENT,
    API_GET_ANNOUNCEMENT_USER,
    API_GET_ANNOUNCEMENT,
    API_POST_ANNOUNCEMENT_ADD,
    API_DELETE_ANNOUNCEMENT,
    API_PATCH_ANNOUNCEMENT
} ServiceType;

@protocol DataManagerDelegate;

@interface DataManager : NSObject<NSURLSessionDelegate>{
    id<DataManagerDelegate> delegate;
    ServiceType currentCallType;
}

@end

NS_ASSUME_NONNULL_END
