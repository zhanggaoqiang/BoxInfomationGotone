//
//  OwnerCarTableViewCell.h
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/3/22.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OwnerCarTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *carNum;
@property (strong, nonatomic) IBOutlet UILabel *carKinds;
@property (strong, nonatomic) IBOutlet UILabel *carLoad;
@property (strong, nonatomic) IBOutlet UILabel *carlength;
-(void)showDataWithModel:(MyCarModel *)model;

@end
