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
        self.width =IanMainScreen.bounds.size.width;
        self.height =37;
        [self setSubviews];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}



-(void)setSubviews
{
    _labelName =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0.25*self.width-1, 35)];
    [_labelName setTextAlignment:NSTextAlignmentCenter];
    [_labelName setFont:[UIFont systemFontOfSize:12]];
    
    
    UIView *line1 =[[UIView alloc] initWithFrame:CGRectMake(0.25*self.width,0, 1, 35)];
    [self.contentView addSubview:line1];
    [line1 setBackgroundColor:[UIColor blackColor]];
    
    
    _labelTime =[[UILabel alloc] initWithFrame:CGRectMake(0.25*self.width+1, 0, 0.25*self.width-1, 35)];
    [_labelTime setTextAlignment:NSTextAlignmentCenter];
    [_labelTime setFont:[UIFont systemFontOfSize:12]];
    
    
    UIView *line2 =[[UIView alloc] initWithFrame:CGRectMake(0.50*self.width,0, 1, 35)];
    [self.contentView addSubview:line2];
    [line2 setBackgroundColor:[UIColor blackColor]];
    
    
    
    _labelSite =[[UILabel alloc] initWithFrame:CGRectMake(0.50*self.width+1, 0, 0.25*self.width-1, 35)];
    [_labelSite setTextAlignment:NSTextAlignmentCenter];
    [_labelSite setFont:[UIFont systemFontOfSize:12]];
    
    UIView *line3 =[[UIView alloc] initWithFrame:CGRectMake(0.75*self.width,0, 1, 35)];
    [self.contentView addSubview:line3];
    [line3 setBackgroundColor:[UIColor blackColor]];
    
    
    
    _labelMoney =[[UILabel alloc] initWithFrame:CGRectMake(0.75*self.width+1, 0, 0.25*self.width-1, 35)];
    [_labelMoney setTextAlignment:NSTextAlignmentCenter];
    [_labelMoney setFont:[UIFont systemFontOfSize:12]];
    

    UIView *line4 =[[UIView alloc] initWithFrame:CGRectMake(self.width,0, 1, 35)];
    [self.contentView addSubview:line4];
    [line4 setBackgroundColor:[UIColor blackColor]];
    
    
    UIView  *bottomLine =[[UIView alloc] initWithFrame:CGRectMake(0, 35, IanMainScreen.bounds.size.width, 1)];
    [bottomLine setBackgroundColor:[UIColor blackColor]];
    [self.contentView addSubview:bottomLine];
    
    

    
    [self.contentView addSubview:_labelName];
    [self.contentView addSubview:_labelTime];
    [self.contentView addSubview:_labelSite];
    [self.contentView addSubview:_labelMoney];
    
}

-(void)setCellWithData:(NSDictionary *)dict
{
    NSString *projectName =dict[@"action"];
    projectName =[projectName stringByAppendingString:dict[@"name"]];
    _labelName.text = projectName;
    
    _labelTime.text =dict[@"time"];
    _labelSite.text = dict[@"site"];
    _labelMoney.text = dict[@"money"];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
