//
//  JingDianMapCell.h
//  IYLM
//
//  Created by Jian-Ye on 12-11-8.
//  Copyright (c) 2012年 Jian-Ye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JingDianMapCell : UIView
@property (weak, nonatomic) IBOutlet UILabel *carName;
@property (weak, nonatomic) IBOutlet UILabel *phoneNum;
@property (nonatomic, copy)NSDictionary *agencyDic;
- (void)setCarAgency:(NSDictionary *)agencyDic;
@end
