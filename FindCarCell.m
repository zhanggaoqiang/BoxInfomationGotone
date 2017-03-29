//
//  FindCarCell.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/2/9.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "FindCarCell.h"

@implementation FindCarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)showDataWithModel:(GoodsOwnerModel *)model {
    
    self.name.text=model.csiContactName;
    self.startCity.text=model.csiDpCity;
    self.endCity.text=model.csiRpCity;
    self.startDis.text=model.csiDpDistrict;
    self.endDis.text=model.csiRpDistrict;
    self.startDetailAdress.text=model.csiReceiptPlace;
    self.carKindslabel.text=model.csiTruckType;
    self.volumeLabel.text=model.csiCargoWeight;
    self.goodlength.text=model.csiMinTruckLength;
    
    
    
}

@end
