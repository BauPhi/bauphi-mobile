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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:@"OPEN_TAB_CONTENT" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:@"TAB_BAR_STATE" object:nil];
    
    tabVCs = [[NSMutableArray alloc] init];
    [tabVCs addObject:@"TimeLineViewController"];
    [tabVCs addObject:@"AddEventViewController"];
    [tabVCs addObject:@"ProfileViewController"];
    gap = 10;
    currPage = NSStringFromClass([self class]);
    
    
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

//TABBAR GENERATOR

- (void) notificationHandler:(NSNotification*)notif{

    if ([notif.name isEqualToString:@"TAB_BAR_STATE"]) {
        NSDictionary *userInfo = notif.userInfo;
        if ([[userInfo objectForKey:@"tabbarState"] isEqualToString:@"HIDDEN"]) {
            // HİDDEN
            //pageScroll.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }else{
            // SHOWN
            float tabHeight = 80;
        }
    }
}

- (void) generateTabbar{
    
    NSMutableArray *namesArray = [[NSMutableArray alloc] init];
    [namesArray addObject:@"HABERLER"];
    [namesArray addObject:@"KAMPANYALAR"];
    [namesArray addObject:@"BANKACILIK"];
    
    CGFloat gap = 50;
    CGFloat lblY = gap-70;
    
    [tabVCs addObject:@"TimeLineViewController"];
    [tabVCs addObject:@"AddEventViewController"];
    [tabVCs addObject:@"ProfileViewController"];
    tabbarView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-gap, SCREEN_WIDTH, gap)];
    tabbarView.backgroundColor = [UIColor whiteColor];
    
    int forCount = (int)[namesArray count];
    for (int i = 0; i<forCount; i++) {
        
        UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(i*(SCREEN_WIDTH/forCount), 0, SCREEN_WIDTH/forCount, gap)];
        double iconSize = 30;
        double centerX = ((SCREEN_WIDTH/forCount)/2) - iconSize/2;
        double centerY = gap/2 - iconSize/2;
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(centerX, centerY, iconSize, iconSize)];
        img.image = [UIImage imageNamed:[NSString stringWithFormat:@"ftab%d",i+1]];
        
//        if(i==0 && [currPage isEqual:@"TimeLineViewController"]){
//            img.image = [UIImage imageNamed:[NSString stringWithFormat:@"ftab%d",i+1]];
//        }else if(i==0 && ![currPage isEqual:@"TimeLineViewController"]){
//            img.image = [UIImage imageNamed:[NSString stringWithFormat:@"btab%d",i+1]];
//        }if(i==1 && [currPage isEqual:@"ChatViewController"]){
//            img.image = [UIImage imageNamed:[NSString stringWithFormat:@"ftab%d",i+1]];
//        }else if(i==1 && ![currPage isEqual:@"ChatViewController"]){
//            img.image = [UIImage imageNamed:[NSString stringWithFormat:@"btab%d",i+1]];
//        }if(i==2 && [currPage isEqual:@"StoreViewController"]){
//            img.image = [UIImage imageNamed:[NSString stringWithFormat:@"ftab%d",i+1]];
//        }else if(i==2 && ![currPage isEqual:@"StoreViewController"]){
//            img.image = [UIImage imageNamed:[NSString stringWithFormat:@"btab%d",i+1]];
//        }if(i==3 && [currPage isEqual:@"MapViewController"]){
//            img.image = [UIImage imageNamed:[NSString stringWithFormat:@"ftab%d",i+1]];
//        }else if(i==3 && ![currPage isEqual:@"MapViewController"]){
//            img.image = [UIImage imageNamed:[NSString stringWithFormat:@"btab%d",i+1]];
//        }if(i==4 && [currPage isEqual:@"ProfileViewController"]){
//            img.image = [UIImage imageNamed:[NSString stringWithFormat:@"ftab%d",i+1]];
//        }else if(i==4 && ![currPage isEqual:@"ProfileViewController"]){
//            img.image = [UIImage imageNamed:[NSString stringWithFormat:@"btab%d",i+1]];
//        }
        
        img.contentMode = UIViewContentModeScaleAspectFit;
        [btnView addSubview:img];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0,0,btnView.frame.size.width,btnView.frame.size.height);
        [btn addTarget:self action:@selector(tabBarButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        
        [btnView addSubview:btn];
        [tabbarView addSubview:btnView];
    }
    
    UIImageView *arrowImgVw = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,20)];
    arrowImgVw.image = [UIImage imageNamed:@"blurline2.png"];
    
    [tabbarView addSubview:arrowImgVw];
    [self.view addSubview:tabbarView];
    
}

- (void) tabBarButtonTapped:(id)sender{
    UIButton *tabbarBtn = (UIButton*)sender;
    
    double forCount = 5; double iconSize = 30;
    double centerX = ((SCREEN_WIDTH/forCount)/2) - iconSize/2;
    double centerY = gap/2 - iconSize/2;
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(centerX, centerY, iconSize, iconSize)];
    img.image = [UIImage imageNamed:[NSString stringWithFormat:@"ftab%d",(int)tabbarBtn.tag+1]];
    img.contentMode = UIViewContentModeScaleAspectFit;
    
    [tabbarBtn addSubview:img];
    [tabbarBtn bringSubviewToFront:img];
    
    NSLog(@"1");
    if (self.navigationController == nil) {
        NSLog(@"2");
    }else{
        //if ([self.navigationController.viewControllers count] >2) {
            [self openTabContent:(int)tabbarBtn.tag];
            NSLog(@"3");
        //}
    }

}

- (void) openTabContent:(int)tagValue {
    NSString *dest = [self->tabVCs objectAtIndex:tagValue];
    NSString *current = NSStringFromClass([self class]);
    
    NSLog(@" tagValue %d", tagValue);
    NSLog(@" current %@", current);
    
    if ([dest isEqualToString:current]) {
        return;
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"OPEN_TAB_CONTENT" object:nil userInfo:@{@"page":[NSString stringWithFormat:@"%i",tagValue]}];
    }
}


@end
