//
//  IanRepairNote.h
//  GraduationDesign
//
//  Created by 谢伟成 on 16/4/16.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IanRepairNote : Tool_FMDBModel<NSCoding>
@property (nonatomic,assign) NSString * time;
@property (nonatomic,assign) NSString * site;
@property (nonatomic,assign) NSString * money;
@property (nonatomic,assign) NSString * projectName;

@end
