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
        self.width =IanMainScreen.bounds.size.width;
        self.height =36;

    }
    return self;
}


-(void)setSubviews
{
    _labelName =[[UILabel alloc] initWithFrame:CGRectMake(0, 0,IanMainScreen.bounds.size.width*0.5-1, 35)];
    [_labelName setTextAlignment:NSTextAlignmentCenter];
    [_labelName setFont:[UIFont systemFontOfSize:12]];
    
    UIView *line =[[UIView alloc] initWithFrame:CGRectMake(IanMainScreen.bounds.size.width*0.5, 0, 1, 36)];
    [self.contentView addSubview:line];
    [line setBackgroundColor:[UIColor blackColor]];
    

    
    _labelTime =[[UILabel alloc] initWithFrame:CGRectMake(IanMainScreen.bounds.size.width*0.5, 0,IanMainScreen.bounds.size.width*0.5, 35)];
    [_labelTime setTextAlignment:NSTextAlignmentCenter];
    [_labelTime setFont:[UIFont systemFontOfSize:12]];
    
    
    UIView *bottomLine =[[UIView alloc] initWithFrame:CGRectMake(0, 35, IanMainScreen.bounds.size.width, 1)];
    [bottomLine setBackgroundColor:[UIColor blackColor]];
    [self.contentView addSubview:bottomLine];
    
    [self.contentView addSubview:_labelName];
    [self.contentView addSubview:_labelTime];
 
    
}

-(void)setCellWithData:(NSDictionary *)dict
{
    NSString *projectName =dict[@"action"];
    projectName = [projectName stringByAppendingString:dict[@"name"]];
    _labelName.text =projectName;
    _labelTime.text =dict[@"time"];
 
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
