//
//  DTCTableViewCell.m
//  GraduationDesign
//
//  Created by shupengstar on 16/4/16.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "DTCTableViewCell.h"
@interface DTCTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *result;
@property (weak, nonatomic) IBOutlet UILabel *decribe;
@property (weak, nonatomic) IBOutlet UILabel *remind;
@property (weak, nonatomic) IBOutlet UILabel *type;

@end
@implementation DTCTableViewCell
- (void)setViewForDic:(NSDictionary *)dataDic{
    self.result.text = [NSString stringWithFormat:@"后果：%@",dataDic[@"aftermath"]];
    self.decribe.text = [NSString stringWithFormat:@"描述：%@",dataDic[@"description"]];
    self.remind.text = [NSString stringWithFormat:@"提醒：%@",dataDic[@"remind"]];
    self.type.text = [NSString stringWithFormat:@"类型：%@",dataDic[@"type"]];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
