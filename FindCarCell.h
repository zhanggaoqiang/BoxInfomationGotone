//
//  FindCarCell.h
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/2/9.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindCarCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *startCity;

@property (strong, nonatomic) IBOutlet UILabel *endCity;
@property (strong, nonatomic) IBOutlet UILabel *startDis;
@property (strong, nonatomic) IBOutlet UILabel *endDis;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *startDetailAdress;

@property (strong, nonatomic) IBOutlet UILabel *volumeLabel;

@property (strong, nonatomic) IBOutlet UILabel *carKindslabel;
@property (strong, nonatomic) IBOutlet UILabel *goodlength;

@property (strong, nonatomic) IBOutlet UILabel *goodsKinds;
-(void)showDataWithModel:(GoodsOwnerModel *)model;


@end
