//
//  Config.h
//  fal
//
//  Created by oyku suyun on 20.02.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//


#ifndef Config_h
#define Config_h


#define SCREEN_WIDTH        ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT       ([[UIScreen mainScreen] bounds].size.height)
#define STATUSBAR_HEIGHT    [UIApplication sharedApplication].statusBarFrame.size.height

#define TITLE_FONT          [UIFont fontWithName:@"Futura-Bold" size:30]
#define TITLE_FONT_MEDIUM   [UIFont fontWithName:@"Futura-Bold" size:20]
#define TITLE_FONT_SMALL    [UIFont fontWithName:@"Futura-Bold" size:15]
#define BLACK_TITLE_FONT    [UIFont fontWithName:@"Avenir Next-Demi Bold" size:30]
#define BODY_FONT           [UIFont fontWithName:@"AmericanTypewriter" size:20]
#define BODY_FONT_SMALL           [UIFont fontWithName:@"AmericanTypewriter" size:15]

#define TITLE_TEXT_COLOR        ([UIColor colorWithRed:255/255.0 green:126/255.0 blue:71/255.0 alpha:1])
#define BODY_TEXT_COLOR         ([UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1])
#define PLACEHOLDER_COLOR       ([UIColor colorWithRed:197/255.0 green:196/255.0 blue:199/255.0 alpha:1])

#define BACKGROUND_COLOR    ([UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1])
#define LIGHT_BACKGROUND_COLOR ([UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1])
#define TEXT_COLOR          ([UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1])
#define BORDER_COLOR        ([UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1])
#define WHITE_COLOR         ([UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1])
#define WHITE_COLOR_ALPHA   ([UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:.5])
#define WHITE_COLOR_ALPHA_LIGHT   ([UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:.7])
#define BLACK_COLOR         ([UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1])

#define COLOR_ONE           ([UIColor colorWithRed:255/255.0 green:187/255.0 blue:0/255.0 alpha:1])
#define COLOR_TWO           ([UIColor colorWithRed:244/255.0 green:158/255.0 blue:82/255.0 alpha:1])
#define COLOR_THREE         ([UIColor colorWithRed:0/255.0 green:182/255.0 blue:172/255.0 alpha:1])
#define COLOR_THREE         ([UIColor colorWithRed:224/255.0 green:183/255.0 blue:0/255.0 alpha:1])

#define GRID_LAYOUT         ((double) SCREEN_WIDTH/10)
#define GRID_LAYOUT_HEIGTH  ((double) SCREEN_HEIGHT/10)


#endif /* Config_h */




