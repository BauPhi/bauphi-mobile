//
//  ViewPresenter.h
//  BauPhi
//
//  Created by oyku suyun on 3.04.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ViewPresenterDelegate;

@interface ViewPresenter : NSObject{
    id<ViewPresenterDelegate> delegate;
}

@property (nonatomic, retain) id<ViewPresenterDelegate> delegate;

+ (instancetype)sharedManager;
-(void)createUser: (NSDictionary *)paramDic :(void(^)(NSDictionary *result, NSError *error))callback;

@end

@protocol ViewPresenterDelegate <NSObject>

@optional


@end

NS_ASSUME_NONNULL_END


