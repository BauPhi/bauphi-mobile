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
    UILabel *pageTitleLbl;
}
@property (nonatomic, retain) UIView *yellowView;
@property (nonatomic, retain) UILabel *pageTitleLbl;

-(void)setPageTitle:(NSString *)pageTitle;

@end

