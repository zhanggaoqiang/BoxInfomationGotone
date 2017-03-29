//
//  FindGoodsCell.h
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/2/8.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindGoodsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *buttonImage;
@property (strong, nonatomic) IBOutlet UILabel *name;

@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *length;
@property (strong, nonatomic) IBOutlet UILabel *carKind;

@property (strong, nonatomic) IBOutlet UILabel *varity;
@property (strong, nonatomic) IBOutlet UILabel *startdis;

@property (strong, nonatomic) IBOutlet UILabel *desition;

-(void)showDataWithModel:(BoxFirstPageModel*)model;

@end
