//
//  MenuCell.h
//  expandCell
//
//  Created by Yuchi Chen on 2016/11/9.
//  Copyright © 2016年 Yuchi Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end

@interface UITableView (MenuCell)

// return the cell with the specified ID. It takes care of the dequeue if necessary
- (MenuCell *)dequeueReusableCellWithId:(NSString *)cellId;

@end
