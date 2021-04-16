//
//  SignUpViewController.m
//  BauPhi
//
//  Created by oyku suyun on 7.03.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import "SignUpViewController.h"
#import "Config.h"
#import "TimeLineViewController.h"
#import "ViewPresenter.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    UIView *yellowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 3*GRID_LAYOUT_HEIGTH)];
    yellowView.backgroundColor = COLOR_ONE;
    [self.view addSubview: yellowView];
    
    backView = [[UIView alloc] initWithFrame:CGRectMake(GRID_LAYOUT, 2*GRID_LAYOUT_HEIGTH, 8*GRID_LAYOUT, 7*GRID_LAYOUT_HEIGTH)];
    backView.backgroundColor = [UIColor clearColor];
    
    UILabel *welcomeLbl = [[UILabel alloc] initWithFrame:CGRectMake(GRID_LAYOUT, GRID_LAYOUT, SCREEN_WIDTH-4*GRID_LAYOUT, 2*GRID_LAYOUT)];
    welcomeLbl.font = TITLE_FONT;
    welcomeLbl.textColor = [UIColor whiteColor];
    welcomeLbl.textAlignment = NSTextAlignmentLeft;
    welcomeLbl.text = @"BauPhi'ye Hoşgeldiniz";
    welcomeLbl.alpha =1;
    welcomeLbl.numberOfLines = 0;
    [yellowView addSubview:welcomeLbl];

    UILabel *welcomeLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(GRID_LAYOUT, 3*GRID_LAYOUT, SCREEN_WIDTH-2*GRID_LAYOUT, 2*GRID_LAYOUT)];
    welcomeLbl2.font = TITLE_FONT_SMALL;
    welcomeLbl2.textColor = [UIColor whiteColor];
    welcomeLbl2.textAlignment = NSTextAlignmentLeft;
    welcomeLbl2.text = @"Lütfen devam etmek için kaydolun";
    welcomeLbl2.alpha =1;
    welcomeLbl2.numberOfLines = 0;
    [yellowView addSubview:welcomeLbl2];
    
    UIView *emailView = [[UIView alloc] initWithFrame:CGRectMake(GRID_LAYOUT, 2*GRID_LAYOUT_HEIGTH, 6*GRID_LAYOUT, GRID_LAYOUT)];
    emailView.backgroundColor = WHITE_COLOR_ALPHA_LIGHT;
    emailView.layer.cornerRadius = 20;
    emailField = [[UITextField alloc] initWithFrame:CGRectMake(GRID_LAYOUT, 2*GRID_LAYOUT_HEIGTH, 6*GRID_LAYOUT, GRID_LAYOUT)];
    emailField.placeholder = @"E-mail";
    emailField.font = BODY_FONT;
    emailField.textColor = TEXT_COLOR;
    emailField.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:emailView];
    [backView addSubview:emailField];
    
    UIView *passwordView = [[UIView alloc] initWithFrame:CGRectMake(GRID_LAYOUT, 2*GRID_LAYOUT_HEIGTH+GRID_LAYOUT+10, 6*GRID_LAYOUT, GRID_LAYOUT)];
    passwordView.backgroundColor = WHITE_COLOR_ALPHA_LIGHT;
    passwordView.layer.cornerRadius = 20;
    passwordField = [[UITextField alloc] initWithFrame:CGRectMake(GRID_LAYOUT, 2*GRID_LAYOUT_HEIGTH+GRID_LAYOUT+10, 6*GRID_LAYOUT, GRID_LAYOUT)];
    passwordField.placeholder = @"Şifre";
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
    nameField.placeholder = @"Ad";
    nameField.font = BODY_FONT;
    nameField.textColor = TEXT_COLOR;
    nameField.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:nickNameView];
    [backView addSubview:nameField];
    
    UIView *surnameView = [[UIView alloc] initWithFrame:CGRectMake(GRID_LAYOUT, 2*GRID_LAYOUT_HEIGTH+3*GRID_LAYOUT+10, 6*GRID_LAYOUT, GRID_LAYOUT)];
    surnameView.backgroundColor = WHITE_COLOR_ALPHA_LIGHT;
    surnameView.layer.cornerRadius = 20;
    surnameField = [[UITextField alloc] initWithFrame:CGRectMake(GRID_LAYOUT, 2*GRID_LAYOUT_HEIGTH+3*GRID_LAYOUT+10, 6*GRID_LAYOUT, GRID_LAYOUT)];
    surnameField.placeholder = @"Soyad";
    surnameField.font = BODY_FONT;
    surnameField.textColor = TEXT_COLOR;
    surnameField.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:surnameView];
    [backView addSubview:surnameField];
    
    UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(GRID_LAYOUT, 2*GRID_LAYOUT_HEIGTH+4*GRID_LAYOUT+10, 6*GRID_LAYOUT, GRID_LAYOUT)];
    phoneView.backgroundColor = WHITE_COLOR_ALPHA_LIGHT;
    phoneView.layer.cornerRadius = 20;
    phoneField = [[UITextField alloc] initWithFrame:CGRectMake(GRID_LAYOUT, 2*GRID_LAYOUT_HEIGTH+4*GRID_LAYOUT+10, 6*GRID_LAYOUT, GRID_LAYOUT)];
    phoneField.placeholder = @"Telefon Numarası";
    phoneField.font = BODY_FONT;
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    phoneField.textColor = TEXT_COLOR;
    phoneField.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:phoneView];
    [backView addSubview:phoneField];
    
    
    signInBtn = [[UIButton alloc] initWithFrame:CGRectMake(2*GRID_LAYOUT, 5*GRID_LAYOUT_HEIGTH, 4*GRID_LAYOUT, GRID_LAYOUT_HEIGTH/2)];
    [signInBtn setTitle:@"Giriş Yap" forState:UIControlStateNormal];
    [signInBtn setTitleColor:BODY_TEXT_COLOR forState:UIControlStateNormal];
    [signInBtn.titleLabel setFont:TITLE_FONT_SMALL];
    signInBtn.backgroundColor = COLOR_ONE;
    signInBtn.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    [signInBtn addTarget:self action:@selector(signUpBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
//    [backView addSubview:signInBtn];

    
    [self.view addSubview:backView];
}

- (void) signUpBtnTapped:(id)sender{
    
    TimeLineViewController *moreVc=[[TimeLineViewController alloc]init];
    [self.navigationController pushViewController:moreVc animated:YES];
    
}
-(void)changePage{
    
}

- (void) backBtnTapped:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)dismissKeyboard{
    [emailField resignFirstResponder];
    [passwordField resignFirstResponder];
    [nameField resignFirstResponder];
}



@end
