//
//  PersonCellImage.h
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/3/6.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonCellImage : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *avaterImage;
-(void)showDataWithModel:(PersonCenterAvaterModel *)model;

@end
