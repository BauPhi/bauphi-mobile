//
//  ViewController.m
//  fal
//
//  Created by Öykü on 20.03.2020.
//  Copyright © 2020 Öykü. All rights reserved.
//

#import "ViewController.h"
#import "SignInViewController.h"
#import "LoadingViewController.h"
#import "Config.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}

-(void)setPageTitle:(NSString *)pageTitle{
    yellowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, (3*GRID_LAYOUT_HEIGTH)/2)];
    yellowView.backgroundColor = COLOR_ONE;
    [self.view addSubview: yellowView];
    pageTitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, (3*GRID_LAYOUT_HEIGTH)/2)];
    pageTitleLbl.font = TITLE_FONT;
    pageTitleLbl.text=@"Anasayfa";
    pageTitleLbl.textAlignment = NSTextAlignmentCenter;
    pageTitleLbl.textColor = WHITE_COLOR;
    [yellowView addSubview:pageTitleLbl];
}


@end
