//
//  SettingsViewController.h
//  BauPhi
//
//  Created by oyku suyun on 18.04.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettingsViewController : ViewController<UITextFieldDelegate>{
    UIView *emailView;
    UIView *holder;
    UIView *lightBGView;
    UIView *backView;
    UITextField *emailField;
    UITextField *passwordField;
    UITextField *nameField;
    UITextField *surnameField;
    UITextField *phoneField;
    UILabel *titleLbl;
    
    UIButton *signInBtn;
    UIButton *backBtn;
    UIButton *saveBtn;
    UIButton *deleteBtn;
    UIButton *shareLocationBtn;
    
    NSString *emailStr;
    NSString *passStr;
 
}

@property (nonatomic, retain) UIView *emailView;
@property (nonatomic, retain) UITextField *emailField;
@property (nonatomic, retain) UITextField *passwordField;
@property (nonatomic, retain) UIButton *signInBtn;
@property (nonatomic, retain) UILabel *titleLbl;
@property (nonatomic, retain) UIView *holder;
@property (nonatomic, retain) UIView *backView;
@property (nonatomic, retain) UITextField *nameField;
@property (nonatomic, retain) UITextField *surnameField;
@property (nonatomic, retain) UITextField *phoneField;
@property (nonatomic, retain) UIView *lightBGView;
@property (nonatomic, retain) UIButton *backBtn;
@property (nonatomic, retain) UIButton *saveBtn;
@property (nonatomic, retain) UIButton *deleteBtn;
@property (nonatomic, retain) UIButton *shareLocationBtn;
@property (nonatomic, retain) NSString *emailStr;
@property (nonatomic, retain) NSString *passStr;
@property (nonatomic, retain) UITextField *nickField;
@end


NS_ASSUME_NONNULL_END
