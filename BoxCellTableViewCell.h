//
//  BoxCellTableViewCell.h
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/2/9.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoxCellTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *ctsiContainerType;
@property (strong, nonatomic) IBOutlet UILabel *ctsiContainerSize;
@property (strong, nonatomic) IBOutlet UILabel *ctsiContainerLoad;
@property (strong, nonatomic) IBOutlet UILabel *createDateTime;

@property (strong, nonatomic) IBOutlet UILabel *ctsiPlace;

-(void)showDataWithModel:(BoxOwnerModel *)model;


@end
