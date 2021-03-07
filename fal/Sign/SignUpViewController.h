//
//  SignUpViewController.h
//  BauPhi
//
//  Created by oyku suyun on 7.03.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SignUpViewController : ViewController<UITextFieldDelegate>{
    UIView *emailView;
    UIView *holder;
    UIView *lightBGView;
    UIView *backView;
    UITextField *emailField;
    UITextField *passwordField;
    UITextField *nickField;
    UILabel *titleLbl;
    
    UIButton *signInBtn;
    UIButton *backBtn;
    
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
@property (nonatomic, retain) UIView *lightBGView;
@property (nonatomic, retain) UIButton *backBtn;
@property (nonatomic, retain) NSString *emailStr;
@property (nonatomic, retain) NSString *passStr;
@property (nonatomic, retain) UITextField *nickField;
@end


NS_ASSUME_NONNULL_END
