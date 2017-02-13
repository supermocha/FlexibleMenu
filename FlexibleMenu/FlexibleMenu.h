//
//  FlexibleMenu.h
//  FlexibleMenu
//
//  Created by Yuchi Chen on 2017/2/9.
//  Copyright © 2017年 Yuchi Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FlexibleMenuDelegate <NSObject>

@optional
- (void)flexibleMenuDidSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface FlexibleMenu : UIView

@property (nonatomic, weak) id<FlexibleMenuDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSMutableArray *)menuTitles items:(NSMutableArray *)menuItems;

@end
