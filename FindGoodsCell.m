//
//  FindGoodsCell.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/2/8.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "FindGoodsCell.h"


@implementation FindGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)showDataWithModel:(BoxFirstPageModel*)model {
   self.name.text=model.tsiContactName;
    self.time.text=model.createDateTime;
    self.length.text=[model.tsiTruckLength  stringByAppendingString:@"米"];
    self.carKind.text=model.tsiTruckType;
    self.startdis.text=model.tsiDeparturePlace;
    self.desition.text=model.tsiDestination;
    self.varity.text=[model.tsiTruckVolume stringByAppendingString:@"百吨"];
}

@end