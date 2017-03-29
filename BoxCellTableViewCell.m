//
//  BoxCellTableViewCell.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/2/9.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "BoxCellTableViewCell.h"

@implementation BoxCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)showDataWithModel:(BoxOwnerModel *)model {
    
    self.ctsiContainerType.text=model.ctsiContainerType;
    self.ctsiContainerSize.text=model.ctsiContainerSize;
    self.ctsiContainerLoad.text=model.ctsiContainerLoad;
    self.createDateTime.text=model.createDateTime;
   // self.ctsiPlace.text= [model.ctsiPlace stringByAppendingString:@"箱源地址"];
    self.ctsiPlace.text=[@"箱源地址: " stringByAppendingString: model.ctsiPlace];
    
    
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
