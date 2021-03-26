//
//  ProfileViewController.h
//  BauPhi
//
//  Created by oyku suyun on 26.03.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : ViewController<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>{
    UITableView *table;
    NSDictionary *dataDic;
}
@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
