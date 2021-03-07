//
//  SignInViewController.m
//  BauPhi
//
//  Created by oyku suyun on 7.03.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import "SignInViewController.h"
#import "Config.h"
#import "TimeLineViewController.h"
#import "SignUpViewController.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

@synthesize emailField;
@synthesize passwordField;
@synthesize emailView;
@synthesize signInBtn;
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
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
    welcomeLbl2.text = @"Lütfen devam etmek için giriş yapın";
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
    
    UILabel *forgetPasswordLbl = [[UILabel alloc] initWithFrame:CGRectMake(GRID_LAYOUT, 2*GRID_LAYOUT_HEIGTH+2*GRID_LAYOUT+20,6*GRID_LAYOUT, GRID_LAYOUT/2)];
    forgetPasswordLbl.font = TITLE_FONT_SMALL;
    forgetPasswordLbl.textColor =PLACEHOLDER_COLOR;
    forgetPasswordLbl.textAlignment = NSTextAlignmentCenter;
    forgetPasswordLbl.text = @"Şifremi unuttum";
    forgetPasswordLbl.alpha =1;
    forgetPasswordLbl.numberOfLines = 0;
    [backView addSubview:forgetPasswordLbl];
    
    signInBtn = [[UIButton alloc] initWithFrame:CGRectMake(2*GRID_LAYOUT, 4*GRID_LAYOUT_HEIGTH, 4*GRID_LAYOUT, GRID_LAYOUT_HEIGTH/2)];
    [signInBtn setTitle:@"Giriş Yap" forState:UIControlStateNormal];
    [signInBtn setTitleColor:BODY_TEXT_COLOR forState:UIControlStateNormal];
    [signInBtn.titleLabel setFont:TITLE_FONT_SMALL];
    signInBtn.backgroundColor = COLOR_ONE;
    signInBtn.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    [signInBtn addTarget:self action:@selector(signInBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:signInBtn];
    
    
    UIButton *signUpBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 6*GRID_LAYOUT_HEIGTH, 8*GRID_LAYOUT, GRID_LAYOUT_HEIGTH/2)];
    [signUpBtn setTitle:@"Hesabınız yok mu? Kaydolun" forState:UIControlStateNormal];
    [signUpBtn setTitleColor:PLACEHOLDER_COLOR forState:UIControlStateNormal];
    [signUpBtn.titleLabel setFont:TITLE_FONT_SMALL];
    signUpBtn.layer.cornerRadius = GRID_LAYOUT_HEIGTH/10;
    [signUpBtn addTarget:self action:@selector(signUpBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:signUpBtn];
    
    [self.view addSubview:backView];


}

- (void) signUpBtnTapped:(id)sender{
    
    SignUpViewController *moreVc=[[SignUpViewController alloc]init];
    [self.navigationController pushViewController:moreVc animated:YES];
    
}
- (void) signInBtnTapped:(id)sender{
    emailStr = emailField.text;
    passStr = passwordField.text;
    
    TimeLineViewController *moreVc=[[TimeLineViewController alloc]init];
    [self.navigationController pushViewController:moreVc animated:YES];
    
}

- (void) backBtnTapped:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)dismissKeyboard{
    [emailField resignFirstResponder];
    [passwordField resignFirstResponder];
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

