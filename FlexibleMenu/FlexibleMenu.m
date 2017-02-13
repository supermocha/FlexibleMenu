//
//  FlexibleMenu.m
//  FlexibleMenu
//
//  Created by Yuchi Chen on 2017/2/9.
//  Copyright © 2017年 Yuchi Chen. All rights reserved.
//

#import "FlexibleMenu.h"
#import "MenuSectionView.h"
#import "MenuCell.h"

@interface FlexibleMenu () <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *titles;
    NSMutableArray *items;
    NSMutableArray *formatItems;
    UITableView *contentTableView;
    NSInteger lastExpandIndex;
}
@end

@implementation FlexibleMenu

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame titles:(NSMutableArray *)menuTitles items:(NSMutableArray *)menuItems
{
    self = [super initWithFrame:frame];
    if (self) {
        titles = menuTitles;
        items = menuItems;
        [self setFormatItems];
        [self setContentTableView];
    }
    return self;
}

#pragma mark - Private

- (void)setFormatItems
{
    formatItems = [[NSMutableArray alloc] init];
    for (int i = 0; i < titles.count; i ++) {
        [formatItems addObject:@[]];
    }
}

- (void)setContentTableView
{
    contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentTableView.delegate = self;
    contentTableView.dataSource = self;
    [self addSubview:contentTableView];
}

- (id)loadNibWithName:(NSString *)nibName
{
    return [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] firstObject];
}

- (void)expandCell:(UIButton *)sender
{
    if (lastExpandIndex == sender.tag) {
        if ([formatItems[sender.tag] count] == 0) {
            formatItems[sender.tag] = items[sender.tag];
        }
        else {
            [self setFormatItems];
        }
    }
    else {
        [self setFormatItems];
        if ([formatItems[sender.tag] count] == 0) {
            formatItems[sender.tag] = items[sender.tag];
        }
        else {
            formatItems[sender.tag] = @[];
        }
    }

    [contentTableView beginUpdates];
    [contentTableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
    [contentTableView reloadSections:[NSIndexSet indexSetWithIndex:lastExpandIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
    [contentTableView endUpdates];
    
    lastExpandIndex = sender.tag;
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MenuSectionView *sectionView = [self loadNibWithName:NSStringFromClass([MenuSectionView class])];
    sectionView.sectionButton.tag = section;
    [sectionView.sectionButton setTitle:titles[section] forState:UIControlStateNormal];
    [sectionView.sectionButton addTarget:self action:@selector(expandCell:) forControlEvents:UIControlEventTouchUpInside];
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    MenuSectionView *sectionView = [self loadNibWithName:NSStringFromClass([MenuSectionView class])];
    return CGRectGetHeight(sectionView.frame);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuCell *cell = [tableView dequeueReusableCellWithId:NSStringFromClass([MenuCell class])];
    return CGRectGetHeight(cell.frame);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(flexibleMenuDidSelectRowAtIndexPath:)]) {
        [self.delegate flexibleMenuDidSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return titles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [formatItems[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuCell *cell = [tableView dequeueReusableCellWithId:NSStringFromClass([MenuCell class])];
    cell.titleLabel.text = [[formatItems objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    return cell;
}

@end
