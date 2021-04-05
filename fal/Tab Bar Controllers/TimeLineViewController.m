//
//  TimeLineViewController.m
//  BauPhi
//
//  Created by oyku suyun on 7.03.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import "TimeLineViewController.h"
#import "Config.h"
#import "TimeLineTableViewCell.h"

@interface TimeLineViewController ()

@end

@implementation TimeLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@"1" forKey:@"user_id"];
    [self setPageTitle:@"Anasayfa"];
    [self generateTabbar];
    citiesArr=[[NSMutableArray alloc] initWithObjects:@"Adana", @"Ankara" ,@"İstanbul",nil]; //dummy data
    categoryArr=[[NSMutableArray alloc] initWithObjects:@"Ev", @"Eşya Yardımı" ,@"Hayvan Bakımı",nil];
    distanceArr=[[NSMutableArray alloc] initWithObjects:@"0-5 Km", @"5-10 Km" ,@"10-15 Km",@"15-20 Km",nil];
    
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, (2*GRID_LAYOUT_HEIGTH), SCREEN_WIDTH, SCREEN_HEIGHT-3*GRID_LAYOUT_HEIGTH)];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    int btnSize = GRID_LAYOUT_HEIGTH/2;
    filterBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, (3*GRID_LAYOUT_HEIGTH)/2, btnSize, btnSize)];
    UIImage *btnImage = [UIImage imageNamed:@"filter.png"];
    [filterBtn setImage:btnImage forState:UIControlStateNormal];
    [filterBtn addTarget:self action:@selector(filterBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:filterBtn];
    
    filterView = [[UIView alloc] initWithFrame:CGRectMake(0, (3*GRID_LAYOUT_HEIGTH)/2-10, SCREEN_WIDTH, 0)];
    filterView.backgroundColor = LIGHT_BACKGROUND_COLOR;
    filterView.hidden = YES;
    [self.view addSubview:filterView];
    
    cityBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, GRID_LAYOUT_HEIGTH, SCREEN_WIDTH-20, GRID_LAYOUT_HEIGTH/2)];
    cityBtn.backgroundColor =WHITE_COLOR;
    cityBtn.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    [cityBtn setTitle:@"Şehir" forState:UIControlStateNormal];
    [cityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cityBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    cityBtn.tag = 0;
    [cityBtn addTarget:self action:@selector(subFilterBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [filterView addSubview:cityBtn];
    
    categoryBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, (3*GRID_LAYOUT_HEIGTH)/2+10, SCREEN_WIDTH-20, GRID_LAYOUT_HEIGTH/2)];
    categoryBtn.backgroundColor =WHITE_COLOR;
    categoryBtn.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    [categoryBtn setTitle:@"Kategori" forState:UIControlStateNormal];
    [categoryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    categoryBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    categoryBtn.tag = 1;
    [categoryBtn addTarget:self action:@selector(subFilterBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [filterView addSubview:categoryBtn];
    
    distanceBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 2*GRID_LAYOUT_HEIGTH+20, SCREEN_WIDTH-20, GRID_LAYOUT_HEIGTH/2)];
    distanceBtn.backgroundColor =WHITE_COLOR;
    distanceBtn.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    [distanceBtn setTitle:@"Uzaklık" forState:UIControlStateNormal];
    [distanceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    distanceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    distanceBtn.tag = 2;
    [distanceBtn addTarget:self action:@selector(subFilterBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [filterView addSubview:distanceBtn];
    
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
    else if(subFilterBtnTag == 2){ return [distanceArr count]; }
    else{ return 0; }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(subFilterBtnTag == 0){ return [citiesArr objectAtIndex:row]; }
    else if(subFilterBtnTag == 1){ return [categoryArr objectAtIndex:row]; }
    else if(subFilterBtnTag == 2){ return [distanceArr objectAtIndex:row]; }
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
        else if(subFilterBtnTag == 2){
            [distanceBtn setTitle:distanceArr[pickerSelected] forState:UIControlStateNormal];
        }
    }
}

- (void) filterBtnTapped:(id)sender{
    NSLog(@"filterBtnTapped");
    
    if(filterView.isHidden){
        filterView.hidden = NO;
        [self.view bringSubviewToFront:filterView];
        [self.view bringSubviewToFront:filterBtn];
        [UIView animateKeyframesWithDuration:.5
                                       delay:0.0
                                      options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                                   animations:^{

            self->filterView.frame = CGRectMake(0, (3*GRID_LAYOUT_HEIGTH)/2-10, SCREEN_WIDTH, (GRID_LAYOUT_HEIGTH*3));

                                   } completion:^(BOOL finished){
                                
        }];
    }else if(!filterView.isHidden){
        [self.view bringSubviewToFront:filterView];
        [UIView animateKeyframesWithDuration:.5
                                       delay:0.0
                                      options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                                   animations:^{

            self->filterView.frame = CGRectMake(0, (3*GRID_LAYOUT_HEIGTH)/2-10, SCREEN_WIDTH, 0);

                                   } completion:^(BOOL finished){
                                       self->filterView.hidden = YES;
        }];
        
    }
   
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cell";
    TimeLineTableViewCell *cell = (TimeLineTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil){        
        cell = [[TimeLineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 2*GRID_LAYOUT_HEIGTH;
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{


}

@end
