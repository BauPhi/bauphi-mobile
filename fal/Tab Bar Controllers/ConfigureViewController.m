//
//  ConfigureViewController.m
//  BauPhi
//
//  Created by oyku suyun on 18.04.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import "ConfigureViewController.h"
#import "Config.h"
#import "ViewPresenter.h"
#import "TimeLineViewController.h"

@interface ConfigureViewController ()

@end

@implementation ConfigureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
}

-(void)setAddHomeScreen{
    
    addHomeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    addEventView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    addEventView.hidden = YES;
    [self.view addSubview:addHomeView];
    [self.view addSubview:addEventView];
    
    [self setPageTitle:@"İlan Güncelle"];
    [self generateTabbar];
    
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
    eventNameField.placeholder =[dataDic objectForKey:@"home_name"];
    [scrollView addSubview:eventNameField];
    
    countryField = [[UITextField alloc] initWithFrame:CGRectMake(10, eventNameField.frame.origin.y+eventNameField.frame.size.height+grid, SCREEN_WIDTH-20,grid)];
    countryField.backgroundColor =LIGHT_BACKGROUND_COLOR;
    countryField.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    countryField.placeholder =[dataDic objectForKey:@"country"];
    [scrollView addSubview:countryField];
    
    stateField = [[UITextField alloc] initWithFrame:CGRectMake(10, countryField.frame.origin.y+countryField.frame.size.height+grid, SCREEN_WIDTH-20,grid)];
    stateField.backgroundColor =LIGHT_BACKGROUND_COLOR;
    stateField.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    stateField.placeholder = [dataDic objectForKey:@"state"];
    [scrollView addSubview:stateField];
    
    cityField = [[UITextField alloc] initWithFrame:CGRectMake(10, stateField.frame.origin.y+stateField.frame.size.height+grid, SCREEN_WIDTH-20,grid)];
    cityField.backgroundColor =LIGHT_BACKGROUND_COLOR;
    cityField.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    cityField.placeholder = [dataDic objectForKey:@"city"];
    [scrollView addSubview:cityField];
    
    neighbourhoodField = [[UITextField alloc] initWithFrame:CGRectMake(10, cityField.frame.origin.y+cityField.frame.size.height+grid, SCREEN_WIDTH-20,grid)];
    neighbourhoodField.backgroundColor =LIGHT_BACKGROUND_COLOR;
    neighbourhoodField.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    neighbourhoodField.placeholder = [dataDic objectForKey:@"neighbourhood"];
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
    
    saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, backViewForPetBtn.frame.origin.y+backViewForPetBtn.frame.size.height+grid, (SCREEN_WIDTH-40)/2, GRID_LAYOUT_HEIGTH/2)];
    [saveBtn setTitle:@"Güncelle" forState:UIControlStateNormal];
    [saveBtn setTitleColor:BODY_TEXT_COLOR forState:UIControlStateNormal];
    [saveBtn.titleLabel setFont:TITLE_FONT_SMALL];
    saveBtn.backgroundColor = COLOR_ONE;
    saveBtn.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    [saveBtn addTarget:self action:@selector(saveBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:saveBtn];
    
    deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(30+(SCREEN_WIDTH-40)/2, backViewForPetBtn.frame.origin.y+backViewForPetBtn.frame.size.height+grid, (SCREEN_WIDTH-40)/2, GRID_LAYOUT_HEIGTH/2)];
    [deleteBtn setTitle:@"Sil" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:BODY_TEXT_COLOR forState:UIControlStateNormal];
    [deleteBtn.titleLabel setFont:TITLE_FONT_SMALL];
    deleteBtn.backgroundColor = COLOR_ONE;
    deleteBtn.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    [deleteBtn addTarget:self action:@selector(saveBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:deleteBtn];
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
-(void)setData:(NSDictionary *)paramDic{
    dataDic = [[NSMutableDictionary alloc] init];
    dataDic=paramDic.mutableCopy;
    [self setAddHomeScreen];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
