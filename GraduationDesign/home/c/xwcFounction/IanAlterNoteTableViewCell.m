//
//  IanRepairNotesTableViewCell.m
//  GraduationDesign
//
//  Created by 谢伟成 on 16/4/17.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "IanAlterNoteTableViewCell.h"
#import "appMarco.h"
@interface IanAlterNoteTableViewCell()
@property (nonatomic,strong) UILabel * labelName;
@property (nonatomic,strong) UILabel * labelTime;
//@property (nonatomic,strong) UILabel * labelSite;
//@property (nonatomic,strong) UILabel * labelMoney;


@end

@implementation IanAlterNoteTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setSubviews];
        [self setFrame:CGRectMake(0, 0, 375, 35)];
        [self setBackgroundColor:[UIColor redColor]];
    }
    return self;
}


-(void)setSubviews
{
    _labelName =[[UILabel alloc] initWithFrame:CGRectMake(0.25*self.width, 0, 0.35*self.width, 35)];
    _labelTime =[[UILabel alloc] initWithFrame:CGRectMake(0.61*self.width, 0, 0.35*self.width, 35)];
    
    
    [self.contentView addSubview:_labelName];
    [self.contentView addSubview:_labelTime];
 
    
}

-(void)setCellWithData:(NSDictionary *)dict
{
    _labelName.text =dict[@"name"];
    _labelTime.text =dict[@"time"];
 
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
    
    IanLog(@"ddddddd");
    
    // Configure the view for the selected state
}

@end
