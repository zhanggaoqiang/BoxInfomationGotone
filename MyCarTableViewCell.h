//
//  MyCarTableViewCell.h
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/3/21.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCarTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *carNum;
@property (strong, nonatomic) IBOutlet UILabel *carKinds;
@property (strong, nonatomic) IBOutlet UILabel *carLoad;
@property (strong, nonatomic) IBOutlet UILabel *carlength;
@property (strong, nonatomic) IBOutlet UIImageView *editImage;

-(void)showDataWithModel:(MyCarModel *)model;

@end
