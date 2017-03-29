//
//  PersonCellImage.m
//  BoxInfomationGotone
//
//  Created by 张高强 on 2017/3/6.
//  Copyright © 2017年 ZhongHao. All rights reserved.
//

#import "PersonCellImage.h"

@implementation PersonCellImage

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)showDataWithModel:(PersonCenterAvaterModel *)model {
    
    NSString *str=[imagePre stringByAppendingString:model.imageStr];
    
//    [ self.avaterImage  sd_setImageWithURL:[NSURL URLWithString:  str ] completed:nil];
    
    [self.avaterImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"1.png"]];
    
    
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
