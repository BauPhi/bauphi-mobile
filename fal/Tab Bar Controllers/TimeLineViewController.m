//
//  TimeLineViewController.m
//  BauPhi
//
//  Created by oyku suyun on 7.03.2021.
//  Copyright © 2021 Öykü. All rights reserved.
//

#import "TimeLineViewController.h"
#import "Config.h"
#import "TimeLineTableViewCell.h"

@interface TimeLineViewController ()

@end

@implementation TimeLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setPageTitle:@"Anasayfa"];
    [self generateTabbar];
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, (2*GRID_LAYOUT_HEIGTH), SCREEN_WIDTH, SCREEN_HEIGHT-3*GRID_LAYOUT_HEIGTH)];
    table.delegate = self;
    table.dataSource = self;
//    table.backgroundColor = [UIColor greenColor];
    [self.view addSubview:table];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cell";
    TimeLineTableViewCell *cell = (TimeLineTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil){        
        cell = [[TimeLineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 2*GRID_LAYOUT_HEIGTH;
}

@end
