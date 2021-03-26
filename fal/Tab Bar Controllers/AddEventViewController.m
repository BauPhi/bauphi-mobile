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
    
    citiesArr=[[NSMutableArray alloc] initWithObjects:@"Adana", @"Ankara" ,@"İstanbul",nil]; //dummy data
    categoryArr=[[NSMutableArray alloc] initWithObjects:@"Ev", @"Eşya Yardımı" ,@"Hayvan Bakımı",nil];
    
    cityBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 2*GRID_LAYOUT_HEIGTH, SCREEN_WIDTH-20, GRID_LAYOUT_HEIGTH/2)];
    cityBtn.backgroundColor =LIGHT_BACKGROUND_COLOR;
    cityBtn.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    [cityBtn setTitle:@"Şehir" forState:UIControlStateNormal];
    [cityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cityBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    cityBtn.tag = 0;
    [cityBtn addTarget:self action:@selector(subFilterBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cityBtn];
    
    categoryBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, (5*GRID_LAYOUT_HEIGTH)/2+10, SCREEN_WIDTH-20, GRID_LAYOUT_HEIGTH/2)];
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



@end
