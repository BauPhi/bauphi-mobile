//
//  AddEventViewController.m
//  BauPhi
//
//  Created by oyku suyun on 26.03.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import "AddEventViewController.h"
#import "Config.h"

@interface AddEventViewController ()

@end

@implementation AddEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setPageTitle:@"Anasayfa"];
    [self generateTabbar];
    double grid = GRID_LAYOUT_HEIGTH/2;
    double spaceBetweenForms = GRID_LAYOUT_HEIGTH/4;
    
    citiesArr=[[NSMutableArray alloc] initWithObjects:@"Adana", @"Ankara" ,@"İstanbul",nil]; //dummy data
    categoryArr=[[NSMutableArray alloc] initWithObjects:@"Ev", @"Eşya Yardımı" ,@"Hayvan Bakımı",nil];
    
    cityBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 4*grid, SCREEN_WIDTH-20,grid)];
    cityBtn.backgroundColor =LIGHT_BACKGROUND_COLOR;
    cityBtn.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    [cityBtn setTitle:@"Şehir" forState:UIControlStateNormal];
    [cityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cityBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    cityBtn.tag = 0;
    [cityBtn addTarget:self action:@selector(subFilterBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cityBtn];
    
    categoryBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, (5*grid)+spaceBetweenForms, SCREEN_WIDTH-20, grid)];
    categoryBtn.backgroundColor =LIGHT_BACKGROUND_COLOR;
    categoryBtn.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    [categoryBtn setTitle:@"Kategori" forState:UIControlStateNormal];
    [categoryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    categoryBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    categoryBtn.tag = 1;
    [categoryBtn addTarget:self action:@selector(subFilterBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:categoryBtn];
    
    picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-GRID_LAYOUT*4, SCREEN_WIDTH, GRID_LAYOUT*4)];
    picker.backgroundColor = BACKGROUND_COLOR;
    picker.layer.cornerRadius = 10;
    picker.hidden = YES;
    [picker setDataSource: self];
    [picker setDelegate: self];
    pickerBtn =[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100, picker.frame.origin.y, 100, 20)];
    pickerBtn.titleLabel.font = BODY_FONT;
    [pickerBtn setTitleColor:COLOR_ONE forState:UIControlStateNormal];
    [pickerBtn setTitle:@"Tamam" forState:UIControlStateNormal];
    pickerBtn.hidden = YES;
    [pickerBtn addTarget:self action:@selector(pickerBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:picker];
    [self.view addSubview:pickerBtn];
    
    eventNameField = [[UITextField alloc] initWithFrame:CGRectMake(10, (7*grid), SCREEN_WIDTH-20, grid)];
    eventNameField.backgroundColor =LIGHT_BACKGROUND_COLOR;
    eventNameField.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    eventNameField.placeholder = @"İlan İsmi";
    [self.view addSubview:eventNameField];
    
    contactNumberField = [[UITextField alloc] initWithFrame:CGRectMake(10, (8*grid)+spaceBetweenForms, SCREEN_WIDTH-20, grid)];
    contactNumberField.backgroundColor =LIGHT_BACKGROUND_COLOR;
    contactNumberField.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    contactNumberField.placeholder = @"İletişim Numarası";
    contactNumberField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:contactNumberField];
    
    notesTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, (10*grid), SCREEN_WIDTH-20, 4*grid)];
    notesTextView.backgroundColor =LIGHT_BACKGROUND_COLOR;
    notesTextView.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    [self.view addSubview:notesTextView];
    
    double photoImageViewSize = ((SCREEN_WIDTH -30)/2)* .75;
    photo1View = [[UIImageView alloc] initWithFrame:CGRectMake(10, 14*grid+spaceBetweenForms, photoImageViewSize, photoImageViewSize)];
    photo1View.backgroundColor =LIGHT_BACKGROUND_COLOR;
    photo1View.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    [self.view addSubview:photo1View];
    
    photo2View = [[UIImageView alloc] initWithFrame:CGRectMake(20+photoImageViewSize, 14*grid+spaceBetweenForms, photoImageViewSize, photoImageViewSize)];
    photo2View.backgroundColor =LIGHT_BACKGROUND_COLOR;
    photo2View.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    [self.view addSubview:photo2View];
}

#pragma mark - Picker View Activity Handlers

- (void) subFilterBtnTapped:(id)sender{
    UIButton *senderBtn = (UIButton *)sender;
    subFilterBtnTag=(int)senderBtn.tag;
    NSLog(@"subFilterBtnTapped function called with button tag: %ld", senderBtn.tag);
    
    if(picker.isHidden == YES){
        picker.hidden = NO;
        pickerBtn.hidden = NO;
        [picker reloadAllComponents];
    }
}

- (void)pickerView:(UIPickerView *)pV didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    pickerSelected=(int)row;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSLog(@"numberOfRowsInComponent");
    if(subFilterBtnTag == 0){ return [citiesArr count]; }
    else if(subFilterBtnTag == 1){ return [categoryArr count]; }
    else{ return 0; }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(subFilterBtnTag == 0){ return [citiesArr objectAtIndex:row]; }
    else if(subFilterBtnTag == 1){ return [categoryArr objectAtIndex:row]; }
    else{ return 0; }
}
- (NSInteger)selectedRowInComponent:(NSInteger)component{
    NSLog(@"%d",component);
    return component;
}
- (void) pickerBtnTapped:(id)sender{
    if(picker.isHidden == NO){
        picker.hidden = YES;
        pickerBtn.hidden = YES;
        if(subFilterBtnTag == 0){
            [cityBtn setTitle:citiesArr[pickerSelected] forState:UIControlStateNormal];
        }
        else if(subFilterBtnTag == 1){
            [categoryBtn setTitle:categoryArr[pickerSelected] forState:UIControlStateNormal];
        }
    }
}


#pragma mark - Photo Activity Handlers


-(void)showCameraWithFrontCamera:(BOOL)flag {
    self.captureSession = [[AVCaptureSession alloc]init];
    self.captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
    AVCaptureDevice *captureDevice;
    if(flag)  {
      captureDevice= [self frontCamera];
    }
    else {
      captureDevice= [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    NSError *error = nil;
    AVCaptureDeviceInput *input =   [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    

    [self.captureSession addInput:input];
    self.stillImageOutput = [AVCaptureStillImageOutput new];
    self.stillImageOutput.outputSettings = @{AVVideoCodecKey:AVVideoCodecJPEG};
    [self.captureSession addOutput: self.stillImageOutput];
    self.videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];

    self.videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.videoPreviewLayer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
    [self.viewCamera.layer addSublayer:self.videoPreviewLayer];
    [self.captureSession startRunning];
    self.videoPreviewLayer.frame = self.viewCamera.bounds;
    
//    [imageHiddenView addSubview:viewCamera];
}


- (AVCaptureDevice *)frontCamera {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == AVCaptureDevicePositionFront) {
            return device;
        }
    }
    return nil;
}


- (void)btnCaptureImagePressed:(id)sender {

    AVCaptureConnection * videoConnection =  [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];

    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef  _Nullable sampleBuffer, NSError * _Nullable error) {
        NSData *imageData =  [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:sampleBuffer];
        [self setImageToView:imageData];
//        self.videoPreviewLayer.hidden = YES;

    }];

}

-(void)setImageToView:(NSData *)imageData{
    UIImage *fullBtnImage = [UIImage imageNamed:@"refresh.png"];
}


- (void)selectPhoto:(UIButton *)sender {
    QBImagePickerController *imagePickerController = [QBImagePickerController new];
    imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.maximumNumberOfSelection = 4;
    imagePickerController.showsNumberOfSelectedAssets = YES;

    [self presentViewController:imagePickerController animated:YES completion:NULL];
   
}

- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets {
    self.requestOptions = [[PHImageRequestOptions alloc] init];
    self.requestOptions.resizeMode   = PHImageRequestOptionsResizeModeExact;
    self.requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    self.requestOptions.synchronous = YES;
    
    PHImageManager *manager = [PHImageManager defaultManager];
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:[assets count]];
     __block UIImage *ima;
    
    for (PHAsset *asset in assets) {
        // Do something with the asset
        [manager requestImageForAsset:asset
                           targetSize:PHImageManagerMaximumSize
                          contentMode:PHImageContentModeDefault
                              options:self.requestOptions
                        resultHandler:^void(UIImage *image, NSDictionary *info) {
                            ima = image;

                            [images addObject:ima];
                        }];
        NSLog(@"images: %@",images);
    }
    UIImage *fullBtnImage = [UIImage imageNamed:@"refresh.png"];
    for(UIImage *img in images){
        //TODO: images will be shown in imageview
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController {
    [self dismissViewControllerAnimated:YES completion:NULL];
}



@end
