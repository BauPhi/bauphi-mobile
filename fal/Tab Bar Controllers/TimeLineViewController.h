//
//  TimeLineViewController.h
//  BauPhi
//
//  Created by oyku suyun on 7.03.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import "ViewController.h"
#import "DataManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface TimeLineViewController : ViewController<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,DataManagerDelegate>{
    UITableView *table;
    UIView *filterView;
    UIPickerView *picker;
    NSDictionary *dataDic;
    UIButton *filterBtn;
    UIButton *pickerBtn;
    UIButton *cityBtn;
    UIButton *categoryBtn;
    UIButton *distanceBtn;
    NSMutableArray *citiesArr;
    NSMutableArray *categoryArr;
    NSMutableArray *distanceArr;
    NSMutableArray *tableArr;
    int pickerSelected;
    int subFilterBtnTag;
}
@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) UIView *filterView;
@property (nonatomic, retain) UIPickerView *picker;
@property (nonatomic, retain) NSDictionary *dataDic;
@property (nonatomic, retain) UIButton *filterBtn;
@property (nonatomic, retain) UIButton *pickerBtn;
@property (nonatomic, retain) UIButton *cityBtn;
@property (nonatomic, retain) UIButton *categoryBtn;
@property (nonatomic, retain) UIButton *distanceBtn;
@property (nonatomic, retain) NSMutableArray *citiesArr;
@property (nonatomic, retain) NSMutableArray *categoryArr;
@property (nonatomic, retain) NSMutableArray *distanceArr;
@property (nonatomic, retain) NSMutableArray *tableArr;

@end

NS_ASSUME_NONNULL_END
