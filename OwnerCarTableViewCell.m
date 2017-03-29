//
//  OwnerCarTableViewCell.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/3/22.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "OwnerCarTableViewCell.h"

@implementation OwnerCarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)showDataWithModel:(MyCarModel *)model {
    
    self.carLoad.text=model.carLoad;
    self.carNum.text=model.carNum;
    self.carKinds.text=model.carKinds;
    self.carlength.text=model.carLength;
    
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
