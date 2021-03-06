//
//  AddEventViewController.h
//  BauPhi
//
//  Created by oyku suyun on 26.03.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "QBImagePickerController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddEventViewController : ViewController<UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,QBImagePickerControllerDelegate,UIScrollViewDelegate>{
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
    AVCaptureVideoPreviewLayer *videoPreviewLayer;
    AVCaptureStillImageOutput *stillImageOutput;
    AVCaptureSession *captureSession;
    PHImageRequestOptions *requestOptions;
    
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
@property (nonatomic, retain) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, retain) AVCaptureStillImageOutput *stillImageOutput;
@property (nonatomic, retain) AVCaptureSession *captureSession;
@property (nonatomic, retain) PHImageRequestOptions *requestOptions;

@end

NS_ASSUME_NONNULL_END
