//
//  TimeLineTableViewCell.h
//  BauPhi
//
//  Created by oyku suyun on 23.03.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimeLineTableViewCell : UITableViewCell{
    UILabel *titleLbl;
    UILabel *firstDescription;
    UILabel *secondDescription;
}
@property (nonatomic, retain) UILabel *titleLbl;
@property (nonatomic, retain) UILabel *firstDescription;
@property (nonatomic, retain) UILabel *secondDescription;

@end

NS_ASSUME_NONNULL_END
