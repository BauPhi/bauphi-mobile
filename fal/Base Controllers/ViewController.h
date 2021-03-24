//
//  ViewController.h
//  fal
//
//  Created by Öykü on 20.03.2020.
//  Copyright © 2020 Öykü. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    UIView *yellowView;
    UIView *tabbarView;
    UILabel *pageTitleLbl;
    NSMutableArray *tabVCs;
    NSString *currPage;
    int gap;
}
@property (nonatomic, retain) UIView *yellowView;
@property (nonatomic, retain) UIView *tabbarView;
@property (nonatomic, retain) UILabel *pageTitleLbl;
@property (nonatomic, retain) NSMutableArray *tabVCs;
@property (nonatomic, retain) NSString *currPage;

-(void)setPageTitle:(NSString *)pageTitle;
- (void) generateTabbar;

@end

