//
//  ProfileViewController.m
//  BauPhi
//
//  Created by oyku suyun on 26.03.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import "ProfileViewController.h"
#import "Config.h"
#import "TimeLineTableViewCell.h"
#import "ViewPresenter.h"
#import "User.h"
#import "ConfigureViewController.h"
#import "SettingsViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setPageTitle:@"Profil"];
    [self generateTabbar];
    
    [ViewPresenter sharedManager].delegate =self;
    NSMutableDictionary *paramDic= [NSMutableDictionary dictionaryWithObjectsAndKeys:
                            @"2", @"user_id",nil];
    [[ViewPresenter sharedManager] getUsersHome:paramDic];
    
    double btnSize = GRID_LAYOUT_HEIGTH/2;
    settingsBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-btnSize-10, GRID_LAYOUT_HEIGTH/2, btnSize, btnSize)];
    UIImage *btnImage2 = [UIImage imageNamed:@"settings.png"];
    settingsBtn.layer.cornerRadius = 30;
    [settingsBtn setImage:btnImage2 forState:UIControlStateNormal];
    settingsBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    settingsBtn.tag=1;
    [settingsBtn addTarget:self action:@selector(settingsBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingsBtn];
    
}

-(void)setPage: (NSArray *)paramArr{
    dataArr = paramArr.mutableCopy;
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, (2*GRID_LAYOUT_HEIGTH), SCREEN_WIDTH, SCREEN_HEIGHT-3*GRID_LAYOUT_HEIGTH)];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArr count];
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
    NSMutableDictionary *paramDic= [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    [dataArr[indexPath.row] objectForKey:@"home_name"], @"home_name",
                                    [dataArr[indexPath.row] objectForKey:@"city"], @"city",
                                    [dataArr[indexPath.row] objectForKey:@"neighbourhood"], @"neighbourhood",nil];
    [cell setData:paramDic];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ConfigureViewController *moreVc=[[ConfigureViewController alloc]init];
    [moreVc setData:dataArr[indexPath.row]];
    [self.navigationController pushViewController:moreVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 2*GRID_LAYOUT_HEIGTH;
}

-(void) settingsBtnTapped:(id)sender{
    SettingsViewController *moreVc=[[SettingsViewController alloc]init];
    [self.navigationController pushViewController:moreVc animated:YES];
}


@end
