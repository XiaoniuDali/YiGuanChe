//
//  JingDianMapCell.m
//  IYLM
//
//  Created by Jian-Ye on 12-11-8.
//  Copyright (c) 2012年 Jian-Ye. All rights reserved.
//

#import "JingDianMapCell.h"

@implementation JingDianMapCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.carName = self.agencyDic[@"carName"];
        self.phoneNum = self.agencyDic[@"phoneNum"];
    }
    return self;
}
- (void)setCarAgency:(NSDictionary *)agencyDic{
    self.carName = agencyDic[@"carName"];
    self.phoneNum = agencyDic[@"phoneNum"];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
