//
//  MyCarTableViewCell.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/3/21.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "MyCarTableViewCell.h"

@implementation MyCarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)showDataWithModel:(MyCarModel *)model {
    self.carNum.text=model.carNum;
    self.carKinds.text=model.carKinds;
    self.carLoad.text=model.carLoad;
    self.carlength.text=model.carLength;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
