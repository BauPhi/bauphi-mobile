//
//  AddEventViewController.h
//  BauPhi
//
//  Created by oyku suyun on 26.03.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddEventViewController : ViewController<UIPickerViewDelegate,UIPickerViewDataSource>{
    UIImageView *photo1View;
    UIImageView *photo2View;
    UIPickerView *picker;
    UIButton *cityBtn;
    UIButton *categoryBtn;
    UIButton *pickerBtn;
    UITextField *eventNameField;
    UITextField *contactNumberField;
    UITextView *notesTextView;
    NSMutableArray *citiesArr;
    NSMutableArray *categoryArr;
    int pickerSelected;
    int subFilterBtnTag;
}
@property (nonatomic, retain) UIImageView *photo1View;
@property (nonatomic, retain) UIImageView *photo2View;
@property (nonatomic, retain) UIPickerView *picker;
@property (nonatomic, retain) UIButton *cityBtn;
@property (nonatomic, retain) UIButton *categoryBtn;
@property (nonatomic, retain) UIButton *pickerBtn;
@property (nonatomic, retain) UITextField *eventNameField;
@property (nonatomic, retain) UITextField *contactNumberField;
@property (nonatomic, retain) UITextView *notesTextView;
@property (nonatomic, retain) NSMutableArray *citiesArr;
@property (nonatomic, retain) NSMutableArray *categoryArr;

@end

NS_ASSUME_NONNULL_END
