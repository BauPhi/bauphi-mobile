//
//  ConfigureViewController.h
//  BauPhi
//
//  Created by oyku suyun on 18.04.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConfigureViewController : ViewController<UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UIScrollViewDelegate>{
    UIView *addHomeView;
    UIView *addEventView;
    UIView *viewCamera;
    UIScrollView *scrollView;
    UIDatePicker *beginDatePicker;
    UIDatePicker *endDatePicker;
    NSDate *beginDate;
    NSDate *endDate;
    UIImageView *photo1View;
    UIImageView *photo2View;
    UIPickerView *picker;
    UIButton *categoryBtn1;
    UIButton *categoryBtn2;
    UIButton *cityBtn;
    UIButton *categoryBtn;
    UIButton *pickerBtn;
    UIButton *emergencyBtn;
    UIButton *isVisibleBtn;
    UIButton *isPetAllowed;
    UIButton *saveBtn;
    UIButton *deleteBtn;
    UITextField *eventNameField;
    UITextField *contactNumberField;
    UITextField *countryField;
    UITextField *stateField;
    UITextField *cityField;
    UITextField *neighbourhoodField;
    UITextField *currencyField;
    UITextField *amountField;
    UITextView *notesTextView;
    NSMutableArray *citiesArr;
    NSMutableArray *categoryArr;
    NSMutableDictionary *dataDic;
    
    int pickerSelected;
    int subFilterBtnTag;
}
@property (nonatomic, retain) UIView *viewCamera;
@property (nonatomic, retain) UIView *addHomeView;
@property (nonatomic, retain) UIView *addEventView;
@property (nonatomic, retain) UIDatePicker *beginDatePicker;
@property (nonatomic, retain) UIDatePicker *endDatePicker;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIImageView *photo1View;
@property (nonatomic, retain) UIImageView *photo2View;
@property (nonatomic, retain) UIPickerView *picker;
@property (nonatomic, retain) UIButton *cityBtn;
@property (nonatomic, retain) UIButton *categoryBtn;
@property (nonatomic, retain) UIButton *pickerBtn;
@property (nonatomic, retain) UIButton *emergencyBtn;
@property (nonatomic, retain) UIButton *isVisibleBtn;
@property (nonatomic, retain) UIButton *saveBtn;
@property (nonatomic, retain) UIButton *categoryBtn1;
@property (nonatomic, retain) UIButton *categoryBtn2;
@property (nonatomic, retain) UIButton *isPetAllowed;
@property (nonatomic, retain) UITextField *eventNameField;
@property (nonatomic, retain) UITextField *contactNumberField;
@property (nonatomic, retain) UITextView *notesTextView;
@property (nonatomic, retain) NSMutableArray *citiesArr;
@property (nonatomic, retain) NSMutableArray *categoryArr;
@property (nonatomic, retain) NSMutableDictionary *dataDic;

-(void)setData:(NSDictionary *)paramDic;

@end

NS_ASSUME_NONNULL_END

