//
//  SignInViewController.h
//  BauPhi
//
//  Created by oyku suyun on 7.03.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import "ViewController.h"


@interface SignInViewController : ViewController<UITextFieldDelegate>{
    UIView *emailView;
    UIView *holder;
    UIView *lightBGView;
    UIView *backView;
    
    UITextField *emailField;
    UITextField *passwordField;
    UILabel *titleLbl;
    
    UIButton *signInBtn;
    UIButton *backBtn;
    UIButton *facebookBtn;
    UIButton *googleBtn;
    
    NSString *emailStr;
    NSString *passStr;
    
    
}
@property (nonatomic, retain) UIView *emailView;
@property (nonatomic, retain) UITextField *emailField;
@property (nonatomic, retain) UITextField *passwordField;
@property (nonatomic, retain) UIButton *signInBtn;
@property (nonatomic, retain) UILabel *titleLbl;
@property (nonatomic, retain) UIView *holder;
@property (nonatomic, retain) UIView *lightBGView;
@property (nonatomic, retain) UIView *backView;
@property (nonatomic, retain) UIButton *backBtn;
@property (nonatomic, retain) NSString *emailStr;
@property (nonatomic, retain) NSString *passStr;

@end
