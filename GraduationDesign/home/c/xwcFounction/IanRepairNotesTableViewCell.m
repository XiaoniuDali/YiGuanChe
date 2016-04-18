//
//  IanRepairNotesTableViewCell.m
//  GraduationDesign
//
//  Created by 谢伟成 on 16/4/17.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "IanRepairNotesTableViewCell.h"
#import "appMarco.h"
@interface IanRepairNotesTableViewCell()
@property (nonatomic,strong) UILabel * labelName;
@property (nonatomic,strong) UILabel * labelTime;
@property (nonatomic,strong) UILabel * labelSite;
@property (nonatomic,strong) UILabel * labelMoney;


@end

@implementation IanRepairNotesTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setSubviews];
        [self setBackgroundColor:[UIColor redColor]];
    }
    return self;
}


-(void)setSubviews
{
    _labelName =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0.25*self.contentView.width, 35)];
    _labelTime =[[UILabel alloc] initWithFrame:CGRectMake(0.25*self.width, 0, 0.25*self.width, 35)];
    _labelSite =[[UILabel alloc] initWithFrame:CGRectMake(0.50*self.width, 0, 0.25*self.width, 35)];
    _labelMoney =[[UILabel alloc] initWithFrame:CGRectMake(0.75*self.width, 0, 0.25*self.width, 35)];
    
    
    
    
    
    
    
    
    [self.contentView addSubview:_labelName];
    [self.contentView addSubview:_labelTime];
    [self.contentView addSubview:_labelSite];
    [self.contentView addSubview:_labelMoney];
    
}

-(void)setCellWithData:(NSDictionary *)dict
{
    _labelName.text =dict[@"name"];
    _labelTime.text =dict[@"time"];
    _labelSite.text = dict[@"site"];
    _labelMoney.text = dict[@"money"];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
