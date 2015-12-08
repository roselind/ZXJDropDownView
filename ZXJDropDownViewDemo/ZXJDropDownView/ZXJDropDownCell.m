//
//  ZXJDropDownCell.m
//  ZXJDropDownViewDemo
//
//  Created by zhangxiaojing on 15/12/7.
//  Copyright © 2015年 张小静. All rights reserved.
//

#import "ZXJDropDownCell.h"

@interface ZXJDropDownCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation ZXJDropDownCell

- (void)setTitleText:(NSString *)titleText{
    _titleText =titleText;
    _titleLabel.text = titleText;
}
- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
