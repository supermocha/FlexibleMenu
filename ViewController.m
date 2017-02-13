//
//  ViewController.m
//  FlexibleMenu
//
//  Created by Yuchi Chen on 2017/2/9.
//  Copyright © 2017年 Yuchi Chen. All rights reserved.
//

#import "ViewController.h"
#import "FlexibleMenu.h"

@interface ViewController () <FlexibleMenuDelegate>

@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *titles = [[NSMutableArray alloc] initWithObjects:@"section1", @"section2", @"section3", @"section4", nil];
    NSMutableArray *items = [[NSMutableArray alloc] initWithObjects:@[@"item1", @"item2"], @[@"item1", @"item2", @"item3"], @[@"item1"], @[], nil];
    
    FlexibleMenu *flexibleMenu = [[FlexibleMenu alloc] initWithFrame:[UIScreen mainScreen].bounds titles:titles items:items];
    flexibleMenu.delegate = self;
    [self.view addSubview:flexibleMenu];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - FlexibleMenuDelegate

- (void)flexibleMenuDidSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section:%ld, row:%ld", indexPath.section, indexPath.row);
}

@end
