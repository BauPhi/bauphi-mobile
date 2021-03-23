//
//  TimeLineViewController.h
//  BauPhi
//
//  Created by oyku suyun on 7.03.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TimeLineViewController : ViewController<UITableViewDelegate,UITableViewDataSource>{
    UITableView *table;
    NSDictionary *dataDic;
}
@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
