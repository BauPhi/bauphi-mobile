//
//  TimeLineTableViewCell.m
//  BauPhi
//
//  Created by oyku suyun on 23.03.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import "TimeLineTableViewCell.h"
#import "Config.h"

@implementation TimeLineTableViewCell
@synthesize titleLbl;
@synthesize firstDescription;
@synthesize secondDescription;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    double imageSize = SCREEN_WIDTH/4;
    int pading = 10;
    double labelPading = GRID_LAYOUT_HEIGTH/2;
    double cellWidth =SCREEN_WIDTH;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(imageSize+pading, labelPading, cellWidth, labelPading)];
        titleLbl.font = TITLE_FONT_SMALL;
        titleLbl.textColor = BLACK_COLOR;
        firstDescription = [[UILabel alloc] initWithFrame:CGRectMake(imageSize+pading, 2*labelPading, cellWidth, labelPading)];
        firstDescription.font = BODY_FONT_SMALL;
        firstDescription.textColor = PLACEHOLDER_COLOR;
        secondDescription = [[UILabel alloc] initWithFrame:CGRectMake(imageSize+pading, 3*labelPading, cellWidth, labelPading)];
        secondDescription.font = BODY_FONT_SMALL;
        secondDescription.textColor = PLACEHOLDER_COLOR;
        
        //dummy data
        titleLbl.text = @"Öykü,Ankara";
        firstDescription.text = @"5 km uzakta";
        secondDescription.text = @"23.04.2021 tarihine kadar uygun";
        
        [self addSubview:titleLbl];
        [self addSubview:firstDescription];
        [self addSubview:secondDescription];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
