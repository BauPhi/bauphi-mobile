//
//  SettingsViewController.m
//  BauPhi
//
//  Created by oyku suyun on 18.04.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import "SettingsViewController.h"
#import "Config.h"
#import "User.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPageTitle:@"Profil Ayarları"];
    [self generateTabbar];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    backView = [[UIView alloc] initWithFrame:CGRectMake(GRID_LAYOUT, 2*GRID_LAYOUT_HEIGTH, 8*GRID_LAYOUT, 7*GRID_LAYOUT_HEIGTH)];
    backView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:backView];
    
    UIView *emailView = [[UIView alloc] initWithFrame:CGRectMake(GRID_LAYOUT, 2*GRID_LAYOUT_HEIGTH, 6*GRID_LAYOUT, GRID_LAYOUT)];
    emailView.backgroundColor = WHITE_COLOR_ALPHA_LIGHT;
    emailView.layer.cornerRadius = 20;
    emailField = [[UITextField alloc] initWithFrame:CGRectMake(GRID_LAYOUT, 2*GRID_LAYOUT_HEIGTH, 6*GRID_LAYOUT, GRID_LAYOUT)];
    emailField.placeholder = [User user].userEmail;
    emailField.font = BODY_FONT;
    emailField.textColor = TEXT_COLOR;
    emailField.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:emailView];
    [backView addSubview:emailField];
    
    UIView *passwordView = [[UIView alloc] initWithFrame:CGRectMake(GRID_LAYOUT, 2*GRID_LAYOUT_HEIGTH+GRID_LAYOUT+10, 6*GRID_LAYOUT, GRID_LAYOUT)];
    passwordView.backgroundColor = WHITE_COLOR_ALPHA_LIGHT;
    passwordView.layer.cornerRadius = 20;
    passwordField = [[UITextField alloc] initWithFrame:CGRectMake(GRID_LAYOUT, 2*GRID_LAYOUT_HEIGTH+GRID_LAYOUT+10, 6*GRID_LAYOUT, GRID_LAYOUT)];
    passwordField.placeholder = @"şifre güncelle";
    passwordField.font = BODY_FONT;
    passwordField.textColor = TEXT_COLOR;
    passwordField.secureTextEntry = true;
    passwordField.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:passwordView];
    [backView addSubview:passwordField];
    
    UIView *nickNameView = [[UIView alloc] initWithFrame:CGRectMake(GRID_LAYOUT, 2*GRID_LAYOUT_HEIGTH+2*GRID_LAYOUT+10, 6*GRID_LAYOUT, GRID_LAYOUT)];
    nickNameView.backgroundColor = WHITE_COLOR_ALPHA_LIGHT;
    nickNameView.layer.cornerRadius = 20;
    nameField = [[UITextField alloc] initWithFrame:CGRectMake(GRID_LAYOUT, 2*GRID_LAYOUT_HEIGTH+2*GRID_LAYOUT+10, 6*GRID_LAYOUT, GRID_LAYOUT)];
    nameField.placeholder = [User user].userName;
    nameField.font = BODY_FONT;
    nameField.textColor = TEXT_COLOR;
    nameField.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:nickNameView];
    [backView addSubview:nameField];
    
    UIView *surnameView = [[UIView alloc] initWithFrame:CGRectMake(GRID_LAYOUT, 2*GRID_LAYOUT_HEIGTH+3*GRID_LAYOUT+10, 6*GRID_LAYOUT, GRID_LAYOUT)];
    surnameView.backgroundColor = WHITE_COLOR_ALPHA_LIGHT;
    surnameView.layer.cornerRadius = 20;
    surnameField = [[UITextField alloc] initWithFrame:CGRectMake(GRID_LAYOUT, 2*GRID_LAYOUT_HEIGTH+3*GRID_LAYOUT+10, 6*GRID_LAYOUT, GRID_LAYOUT)];
    surnameField.placeholder =[User user].userSurname;
    surnameField.font = BODY_FONT;
    surnameField.textColor = TEXT_COLOR;
    surnameField.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:surnameView];
    [backView addSubview:surnameField];
    
    UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(GRID_LAYOUT, 2*GRID_LAYOUT_HEIGTH+4*GRID_LAYOUT+10, 6*GRID_LAYOUT, GRID_LAYOUT)];
    phoneView.backgroundColor = WHITE_COLOR_ALPHA_LIGHT;
    phoneView.layer.cornerRadius = 20;
    phoneField = [[UITextField alloc] initWithFrame:CGRectMake(GRID_LAYOUT, 2*GRID_LAYOUT_HEIGTH+4*GRID_LAYOUT+10, 6*GRID_LAYOUT, GRID_LAYOUT)];
    phoneField.placeholder = [User user].userPhone;
    phoneField.font = BODY_FONT;
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    phoneField.textColor = TEXT_COLOR;
    phoneField.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:phoneView];
    [backView addSubview:phoneField];
    
    //isVisibleBtn UI
    int grid = 20;
    UIView *backViewForVisibleBtn = [[UIView alloc] initWithFrame:CGRectMake(10,phoneView.frame.origin.y+phoneView.frame.size.height+grid, SCREEN_WIDTH/2+2*grid, grid)];
    backViewForVisibleBtn.backgroundColor = LIGHT_BACKGROUND_COLOR;
    [backView addSubview:backViewForVisibleBtn];

    UILabel *visibleBtnTitle = [[UILabel alloc] initWithFrame:CGRectMake(10,0, SCREEN_WIDTH-20/2, grid)];
    visibleBtnTitle.text = @"Konum Paylaş";
    visibleBtnTitle.textColor = PLACEHOLDER_COLOR;
    [backViewForVisibleBtn addSubview:visibleBtnTitle];

    shareLocationBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+grid/2, grid/2-grid/4, grid/2,grid/2)];
    shareLocationBtn.backgroundColor =WHITE_COLOR;
    shareLocationBtn.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    shareLocationBtn.tag=0;
    [shareLocationBtn addTarget:self action:@selector(checkBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [backViewForVisibleBtn addSubview:shareLocationBtn];
    
    saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, backViewForVisibleBtn.frame.origin.y+backViewForVisibleBtn.frame.size.height+30, (backView.frame.size.width-40)/2, GRID_LAYOUT_HEIGTH/2)];
    [saveBtn setTitle:@"Güncelle" forState:UIControlStateNormal];
    [saveBtn setTitleColor:BODY_TEXT_COLOR forState:UIControlStateNormal];
    [saveBtn.titleLabel setFont:TITLE_FONT_SMALL];
    saveBtn.backgroundColor = COLOR_ONE;
    saveBtn.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    [saveBtn addTarget:self action:@selector(saveBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:saveBtn];
    
    deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(20+(SCREEN_WIDTH-40)/2, backViewForVisibleBtn.frame.origin.y+backViewForVisibleBtn.frame.size.height+30, (backView.frame.size.width-40)/2, GRID_LAYOUT_HEIGTH/2)];
    [deleteBtn setTitle:@"Hesabı Sil" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:BODY_TEXT_COLOR forState:UIControlStateNormal];
    [deleteBtn.titleLabel setFont:TITLE_FONT_SMALL];
    deleteBtn.backgroundColor = COLOR_ONE;
    deleteBtn.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    [deleteBtn addTarget:self action:@selector(deleteBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:deleteBtn];
}


@end
