//
//  ViewPresenter.h
//  BauPhi
//
//  Created by oyku suyun on 3.04.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataManager.h"

NS_ASSUME_NONNULL_BEGIN


@protocol ViewPresenterDelegate;

@interface ViewPresenter : NSObject<DataManagerDelegate>{
    id<ViewPresenterDelegate> delegate;
    ServiceType currentCallType;
}

@property (nonatomic, retain) id<ViewPresenterDelegate> delegate;

+ (instancetype)sharedManager;
-(void) signInUser: (NSDictionary *)paramDic;
-(void)createUser: (NSDictionary *)paramDic;

@end

@protocol ViewPresenterDelegate <NSObject>

@optional

-(void)changePage;

@end

NS_ASSUME_NONNULL_END


