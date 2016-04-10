//
//  fineDetailTableViewCell.m
//  GraduationDesign
//
//  Created by shupengstar on 16/4/4.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "fineDetailTableViewCell.h"
@interface fineDetailTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *fineMoneyLbl;
@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@property (weak, nonatomic) IBOutlet UILabel *actionLbl;

@end
@implementation fineDetailTableViewCell

- (void)setTheModel:(SearchFineModel *)fineModel{
    self.timeLbl.text = [NSString stringWithFormat:@"%@",fineModel.occur_date];
    self.fineMoneyLbl.text = [NSString stringWithFormat:@"记%ld分,罚%ld元",fineModel.fen,fineModel.money];
    self.addressLbl.text = [NSString stringWithFormat:@"【%@】%@",fineModel.city_name,fineModel.occur_area];
    self.actionLbl.text = [NSString stringWithFormat:@"%@",fineModel.info];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
