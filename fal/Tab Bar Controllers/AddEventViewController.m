//
//  AddEventViewController.m
//  BauPhi
//
//  Created by oyku suyun on 26.03.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import "AddEventViewController.h"
#import "Config.h"
#import "ViewPresenter.h"
#import "TimeLineViewController.h"

@interface AddEventViewController ()

@end

@implementation AddEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    addHomeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    addEventView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    addHomeView.hidden = YES;
    addEventView.hidden = YES;
    [self.view addSubview:addHomeView];
    [self.view addSubview:addEventView];
    
    [self setPageTitle:@"İlan Ekle"];
    [self generateTabbar];
    
    citiesArr=[[NSMutableArray alloc] initWithObjects:@"Adana", @"Ankara" ,@"İstanbul",nil]; //dummy data
    categoryArr=[[NSMutableArray alloc] initWithObjects:@"Ev", @"Etkinlik",nil];
    
    int btnSize = self.view.frame.size.width/4;

    categoryBtn1 = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width/4)-(btnSize/2), (self.view.frame.size.height/2)-(btnSize/2), btnSize, btnSize)];
    UIImage *btnImage = [UIImage imageNamed:@"ftab1.png"];
    categoryBtn1.layer.cornerRadius = 30;
    categoryBtn1.backgroundColor = LIGHT_BACKGROUND_COLOR;
    [categoryBtn1 setImage:btnImage forState:UIControlStateNormal];
    categoryBtn1.imageView.contentMode = UIViewContentModeScaleAspectFit;
    categoryBtn1.tag=0;
    [categoryBtn1 addTarget:self action:@selector(categoryBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:categoryBtn1];

    categoryBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(3*(self.view.frame.size.width/4)-(btnSize/2), (self.view.frame.size.height/2)-(btnSize/2), btnSize, btnSize)];
    UIImage *btnImage2 = [UIImage imageNamed:@"donation.png"];
    categoryBtn2.layer.cornerRadius = 30;
    categoryBtn2.backgroundColor = LIGHT_BACKGROUND_COLOR;
    [categoryBtn2 setImage:btnImage2 forState:UIControlStateNormal];
    categoryBtn2.imageView.contentMode = UIViewContentModeScaleAspectFit;
    categoryBtn2.tag=1;
    [categoryBtn2 addTarget:self action:@selector(categoryBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:categoryBtn2];
    
}

-(void) categoryBtnTapped:(id)sender{
    UIButton *senderBtn = (UIButton *)sender;
    if(senderBtn.tag == 0){ //category1Btn -> add home
        addHomeView.hidden = NO;
        [categoryBtn1 setSelected:YES];
        categoryBtn1.hidden = YES;
        categoryBtn2.hidden = YES;
        [self setAddHomeScreen];
    }else if(senderBtn.tag == 1){ //category2Btn -> add event
        addEventView.hidden = NO;
        [categoryBtn2 setSelected:YES];
        categoryBtn1.hidden = YES;
        categoryBtn2.hidden = YES;
        [self setAddEventScreen];
    }
}

-(void)setAddHomeScreen{
    
    double grid = GRID_LAYOUT_HEIGTH/2;
    double spaceBetweenForms = GRID_LAYOUT_HEIGTH/4;
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,(3*GRID_LAYOUT_HEIGTH)/2-10, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollView.scrollEnabled=YES;
    scrollView.contentSize=CGSizeMake(SCREEN_WIDTH, (SCREEN_HEIGHT/4)+SCREEN_HEIGHT);
    scrollView.delegate=self;
    scrollView.backgroundColor = WHITE_COLOR;
    [addHomeView addSubview:scrollView];
    
    eventNameField = [[UITextField alloc] initWithFrame:CGRectMake(10, grid, SCREEN_WIDTH-20,grid)];
    eventNameField.backgroundColor =LIGHT_BACKGROUND_COLOR;
    eventNameField.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    eventNameField.placeholder = @"İlan İsmi";
    [scrollView addSubview:eventNameField];
    
    countryField = [[UITextField alloc] initWithFrame:CGRectMake(10, eventNameField.frame.origin.y+eventNameField.frame.size.height+grid, SCREEN_WIDTH-20,grid)];
    countryField.backgroundColor =LIGHT_BACKGROUND_COLOR;
    countryField.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    countryField.placeholder = @"Ülke(Varsayılan: Türkiye)";
    [scrollView addSubview:countryField];
    
    stateField = [[UITextField alloc] initWithFrame:CGRectMake(10, countryField.frame.origin.y+countryField.frame.size.height+grid, SCREEN_WIDTH-20,grid)];
    stateField.backgroundColor =LIGHT_BACKGROUND_COLOR;
    stateField.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    stateField.placeholder = @"Bölge";
    [scrollView addSubview:stateField];
    
    cityField = [[UITextField alloc] initWithFrame:CGRectMake(10, stateField.frame.origin.y+stateField.frame.size.height+grid, SCREEN_WIDTH-20,grid)];
    cityField.backgroundColor =LIGHT_BACKGROUND_COLOR;
    cityField.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    cityField.placeholder = @"Şehir";
    [scrollView addSubview:cityField];
    
    neighbourhoodField = [[UITextField alloc] initWithFrame:CGRectMake(10, cityField.frame.origin.y+cityField.frame.size.height+grid, SCREEN_WIDTH-20,grid)];
    neighbourhoodField.backgroundColor =LIGHT_BACKGROUND_COLOR;
    neighbourhoodField.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    neighbourhoodField.placeholder = @"Açık Adres";
    [scrollView addSubview:neighbourhoodField];
    
    //isVisibleBtn UI
    UIView *backViewForVisibleBtn = [[UIView alloc] initWithFrame:CGRectMake(10,neighbourhoodField.frame.origin.y+neighbourhoodField.frame.size.height+grid, SCREEN_WIDTH/2+2*grid, grid)];
    backViewForVisibleBtn.backgroundColor = LIGHT_BACKGROUND_COLOR;
    [scrollView addSubview:backViewForVisibleBtn];

    UILabel *visibleBtnTitle = [[UILabel alloc] initWithFrame:CGRectMake(10,0, SCREEN_WIDTH-20/2, grid)];
    visibleBtnTitle.text = @"Görünürlük Durumu";
    visibleBtnTitle.textColor = PLACEHOLDER_COLOR;
    [backViewForVisibleBtn addSubview:visibleBtnTitle];

    isVisibleBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+grid/2, grid/2-grid/4, grid/2,grid/2)];
    isVisibleBtn.backgroundColor =WHITE_COLOR;
    isVisibleBtn.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    isVisibleBtn.tag=0;
    [isVisibleBtn addTarget:self action:@selector(checkBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [backViewForVisibleBtn addSubview:isVisibleBtn];
    
    //isPetAllowed UI
    UIView *backViewForPetBtn = [[UIView alloc] initWithFrame:CGRectMake(10,backViewForVisibleBtn.frame.origin.y+backViewForVisibleBtn.frame.size.height+grid, SCREEN_WIDTH/2+2*grid, grid)];
    backViewForPetBtn.backgroundColor = LIGHT_BACKGROUND_COLOR;
    [scrollView addSubview:backViewForPetBtn];

    UILabel *petBtnTitle = [[UILabel alloc] initWithFrame:CGRectMake(10,0, SCREEN_WIDTH-20/2, grid)];
    petBtnTitle.text = @"Evcil Hayvan Kabul Edilir";
    petBtnTitle.textColor = PLACEHOLDER_COLOR;
    [backViewForPetBtn addSubview:petBtnTitle];

    isPetAllowed = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+grid/2, grid/2-grid/4, grid/2,grid/2)];
    isPetAllowed.backgroundColor =WHITE_COLOR;
    isPetAllowed.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    isPetAllowed.tag=1;
    [isPetAllowed addTarget:self action:@selector(checkBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [backViewForPetBtn addSubview:isPetAllowed];
    
    saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(2*GRID_LAYOUT, backViewForPetBtn.frame.origin.y+backViewForPetBtn.frame.size.height+grid, 4*GRID_LAYOUT, GRID_LAYOUT_HEIGTH/2)];
    [saveBtn setTitle:@"Kaydet" forState:UIControlStateNormal];
    [saveBtn setTitleColor:BODY_TEXT_COLOR forState:UIControlStateNormal];
    [saveBtn.titleLabel setFont:TITLE_FONT_SMALL];
    saveBtn.backgroundColor = COLOR_ONE;
    saveBtn.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    [saveBtn addTarget:self action:@selector(saveBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:saveBtn];
}
-(void)setAddEventScreen{
    
    double grid = GRID_LAYOUT_HEIGTH/2;
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,(3*GRID_LAYOUT_HEIGTH)/2-10, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollView.scrollEnabled=YES;
    scrollView.contentSize=CGSizeMake(SCREEN_WIDTH, 2*SCREEN_HEIGHT);
    scrollView.delegate=self;
    scrollView.backgroundColor = WHITE_COLOR;
    [addEventView addSubview:scrollView];
    
    eventNameField = [[UITextField alloc] initWithFrame:CGRectMake(10, grid, SCREEN_WIDTH-20,grid)];
    eventNameField.backgroundColor =LIGHT_BACKGROUND_COLOR;
    eventNameField.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    eventNameField.placeholder = @"İlan İsmi";
    [scrollView addSubview:eventNameField];
    
    countryField = [[UITextField alloc] initWithFrame:CGRectMake(10, eventNameField.frame.origin.y+eventNameField.frame.size.height+grid, SCREEN_WIDTH-20,grid)];
    countryField.backgroundColor =LIGHT_BACKGROUND_COLOR;
    countryField.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    countryField.placeholder = @"Ülke(Varsayılan: Türkiye)";
    [scrollView addSubview:countryField];
    
    stateField = [[UITextField alloc] initWithFrame:CGRectMake(10, countryField.frame.origin.y+countryField.frame.size.height+grid, SCREEN_WIDTH-20,grid)];
    stateField.backgroundColor =LIGHT_BACKGROUND_COLOR;
    stateField.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    stateField.placeholder = @"Bölge";
    [scrollView addSubview:stateField];
    
    cityField = [[UITextField alloc] initWithFrame:CGRectMake(10, stateField.frame.origin.y+stateField.frame.size.height+grid, SCREEN_WIDTH-20,grid)];
    cityField.backgroundColor =LIGHT_BACKGROUND_COLOR;
    cityField.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    cityField.placeholder = @"Şehir";
    [scrollView addSubview:cityField];
    
    neighbourhoodField = [[UITextField alloc] initWithFrame:CGRectMake(10, cityField.frame.origin.y+cityField.frame.size.height+grid, SCREEN_WIDTH-20,grid)];
    neighbourhoodField.backgroundColor =LIGHT_BACKGROUND_COLOR;
    neighbourhoodField.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    neighbourhoodField.placeholder = @"Açık Adres";
    [scrollView addSubview:neighbourhoodField];
    
    //datePicker UI
    UIView *backViewForDatePicker = [[UIView alloc] initWithFrame:CGRectMake(10, neighbourhoodField.frame.origin.y+neighbourhoodField.frame.size.height+grid, SCREEN_WIDTH-20,3*grid+grid/2)];
    backViewForDatePicker.backgroundColor = BACKGROUND_COLOR;
    [scrollView addSubview:backViewForDatePicker];

    UILabel *datePickerTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, grid/2)];
    datePickerTitle.text = @"Uygunluk tarihi";
    datePickerTitle.textColor = PLACEHOLDER_COLOR;
    [backViewForDatePicker addSubview:datePickerTitle];

    UILabel *beginDatePickerTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, grid/2+5, SCREEN_WIDTH/3, grid)];
    beginDatePickerTitle.text = @"Başlangıç tarihi";
    beginDatePickerTitle.textColor = PLACEHOLDER_COLOR;
    [backViewForDatePicker addSubview:beginDatePickerTitle];

    UILabel *endDatePickerTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 2*grid, SCREEN_WIDTH/3, grid)];
    endDatePickerTitle.text = @"Bitiş tarihi";
    endDatePickerTitle.textColor = PLACEHOLDER_COLOR;
    [backViewForDatePicker addSubview:endDatePickerTitle];

    beginDatePicker =[[UIDatePicker alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3,grid/2+5, (SCREEN_WIDTH)/3, grid)];
    beginDatePicker.layer.cornerRadius = 10;
    [beginDatePicker addTarget:self action:@selector(displayDay:) forControlEvents:UIControlEventValueChanged];
    [backViewForDatePicker addSubview:beginDatePicker];

    endDatePicker =[[UIDatePicker alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3,2*grid, (SCREEN_WIDTH)/3, grid)];
    endDatePicker.layer.cornerRadius = 10;
    [endDatePicker addTarget:self action:@selector(displayDay:) forControlEvents:UIControlEventValueChanged];
    [backViewForDatePicker addSubview:endDatePicker];
    
    //isEmergencyBtn UI
    UIView *backViewForEmergencyBtn = [[UIView alloc] initWithFrame:CGRectMake(10,backViewForDatePicker.frame.origin.y+backViewForDatePicker.frame.size.height+grid, SCREEN_WIDTH/2+2*grid, grid)];
    backViewForEmergencyBtn.backgroundColor = LIGHT_BACKGROUND_COLOR;
    [scrollView addSubview:backViewForEmergencyBtn];

    UILabel *emergencyBtnTitle = [[UILabel alloc] initWithFrame:CGRectMake(10,0, SCREEN_WIDTH-20/2, grid)];
    emergencyBtnTitle.text = @"Görünürlük Durumu";
    emergencyBtnTitle.textColor = PLACEHOLDER_COLOR;
    [backViewForEmergencyBtn addSubview:emergencyBtnTitle];

    emergencyBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+grid/2, grid/2-grid/4, grid/2,grid/2)];
    emergencyBtn.backgroundColor =WHITE_COLOR;
    emergencyBtn.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    emergencyBtn.tag=2;
    [emergencyBtn addTarget:self action:@selector(checkBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [backViewForEmergencyBtn addSubview:emergencyBtn];

    notesTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, backViewForEmergencyBtn.frame.origin.y+backViewForEmergencyBtn.frame.size.height+grid, SCREEN_WIDTH-20, 4*grid)];
    notesTextView.backgroundColor =LIGHT_BACKGROUND_COLOR;
    notesTextView.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    [scrollView addSubview:notesTextView];
    
    currencyField = [[UITextField alloc] initWithFrame:CGRectMake(10, notesTextView.frame.origin.y+notesTextView.frame.size.height+grid, SCREEN_WIDTH-20,grid)];
    currencyField.backgroundColor =LIGHT_BACKGROUND_COLOR;
    currencyField.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    currencyField.placeholder = @"Bağış Para Birimi (Varsayılan: TL)";
    [scrollView addSubview:currencyField];
    
    amountField = [[UITextField alloc] initWithFrame:CGRectMake(10, currencyField.frame.origin.y+currencyField.frame.size.height+grid, SCREEN_WIDTH-20,grid)];
    amountField.backgroundColor =LIGHT_BACKGROUND_COLOR;
    amountField.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    amountField.placeholder = @"Bağış Alt Miktarı";
    [scrollView addSubview:amountField];
    
    saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(2*GRID_LAYOUT, amountField.frame.origin.y+amountField.frame.size.height+grid, 4*GRID_LAYOUT, GRID_LAYOUT_HEIGTH/2)];
    [saveBtn setTitle:@"Kaydet" forState:UIControlStateNormal];
    [saveBtn setTitleColor:BODY_TEXT_COLOR forState:UIControlStateNormal];
    [saveBtn.titleLabel setFont:TITLE_FONT_SMALL];
    saveBtn.backgroundColor = COLOR_ONE;
    saveBtn.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    [saveBtn addTarget:self action:@selector(saveBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:saveBtn];
    
//
//    picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-GRID_LAYOUT*4, SCREEN_WIDTH, GRID_LAYOUT*4)];
//    picker.backgroundColor = BACKGROUND_COLOR;
//    picker.layer.cornerRadius = 10;
//    picker.hidden = YES;
//    [picker setDataSource: self];
//    [picker setDelegate: self];
//    pickerBtn =[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100, picker.frame.origin.y, 100, 20)];
//    pickerBtn.titleLabel.font = BODY_FONT;
//    [pickerBtn setTitleColor:COLOR_ONE forState:UIControlStateNormal];
//    [pickerBtn setTitle:@"Tamam" forState:UIControlStateNormal];
//    pickerBtn.hidden = YES;
//    [pickerBtn addTarget:self action:@selector(pickerBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:picker];
//    [scrollView addSubview:pickerBtn];
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

#pragma mark -Date Picker View Activity Handlers
- (void)displayDay:(id)sender {
    if([sender isEqual:endDatePicker]){
        
    }

    NSDate *chosen = [endDatePicker date];
      NSLog(@"%@",chosen);
}

#pragma mark - Button Activity Handlers

- (void)checkBtnTapped:(id)sender {
    if(!emergencyBtn.selected){emergencyBtn.backgroundColor = [UIColor blackColor];}
    if(emergencyBtn.selected){emergencyBtn.backgroundColor = [UIColor whiteColor];}
    emergencyBtn.selected = !emergencyBtn.selected;
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

- (void)saveBtnTapped:(id)sender {
    
    if([categoryBtn.titleLabel.text isEqual:@"Ev"]){
        //home
        NSDictionary *paramsForHome = @{@"home_name": eventNameField.text,
                   @"isVisible": @(isVisibleBtn.isSelected),
                   @"country": countryField.text,
                   @"state": stateField.text,
                   @"city":cityField.text,
                   @"neighbourhood":neighbourhoodField.text,
                   @"latitude": @"42.2548",
                   @"longitude":@"34.5897",
                   @"is_pets_allowed": @(isPetAllowed.isSelected)};
        [[ViewPresenter sharedManager] addHome:paramsForHome];
    }else{
        //event
        NSDictionary *paramsForEvent = @{@"start_time": beginDate,
                   @"end_time": endDate,
                   @"type": @"Meeting",
                   @"title": eventNameField.text,
                   @"description": notesTextView.text,
                   @"is_emergency": @(emergencyBtn.isSelected),
                   @"country": countryField.text,
                   @"state": stateField.text,
                   @"city":cityField.text,
                   @"neighbourhood":neighbourhoodField.text,
                   @"latitude": @"42.2548",
                   @"longitude":@"34.5897",
                   @"currency":currencyField.text,
                   @"amount": amountField.text};
        [[ViewPresenter sharedManager] addEvent:paramsForEvent];
    }
    
}

-(void)changePage{
    TimeLineViewController *moreVc=[[TimeLineViewController alloc]init];
    [self.navigationController pushViewController:moreVc animated:YES];
}



@end
