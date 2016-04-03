//
//  vinModel.h
//  GraduationDesign
//
//  Created by shupengstar on 16/4/2.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Result;
@interface vinModel : NSObject

@property (nonatomic, assign) NSInteger error_code;

@property (nonatomic, strong) Result *result;

@property (nonatomic, copy) NSString *reason;

@end
@interface Result : NSObject

@property (nonatomic, copy) NSString *shaftdistance;/*轴距*/

@property (nonatomic, copy) NSString *crateWidth;

@property (nonatomic, copy) NSString *loadQualityFactor;

@property (nonatomic, copy) NSString *displacement; /*排量（CC）*/

@property (nonatomic, copy) NSString *totalQuality;

@property (nonatomic, copy) NSString *shaftNum;/*轴数*/

@property (nonatomic, copy) NSString *springNum; /*弹簧片数*/

@property (nonatomic, copy) NSString *semiSaddleBearingQuelity;/*排放依据标准*/

@property (nonatomic, copy) NSString *reatedQuality; /*额定质量*/

@property (nonatomic, copy) NSString *carrying;/*整车长*/

@property (nonatomic, copy) NSString *crateHight;

@property (nonatomic, copy) NSString *type;  /*产品类型*/

@property (nonatomic, copy) NSString *maxSpeed;

@property (nonatomic, copy) NSString *equipmentQuality; /*总质量*/

@property (nonatomic, copy) NSString *carWidth;

@property (nonatomic, copy) NSString *tireSpecifications;/*轮胎规格*/

@property (nonatomic, copy) NSString *turnToType;

@property (nonatomic, copy) NSString *brand; // 品牌

@property (nonatomic, copy) NSString *tireNum; /*轮胎数*/

@property (nonatomic, copy) NSString *emissionStandards; /*燃料种类*/

@property (nonatomic, copy) NSString *beforeWheelTrack;/*前轮距*/

@property (nonatomic, copy) NSString *carLong;

@property (nonatomic, copy) NSString *power; /*功率（KW）*/

@property (nonatomic, copy) NSString *name; // 产品名称

@property (nonatomic, copy) NSString *combustionType; /*装备质量*/

@property (nonatomic, copy) NSString *engineProducers;

@property (nonatomic, copy) NSString *model;  /*产品型号*/

@property (nonatomic, copy) NSString *shaftLoad; /*轴荷*/

@property (nonatomic, copy) NSString *beforeAfterHanging;/*前悬后悬*/

@property (nonatomic, copy) NSString *cabCarring;

@property (nonatomic, copy) NSString *carHigh;

@property (nonatomic, copy) NSString *productionDate; /*制造年份*/

@property (nonatomic, copy) NSString *engineType; /*发动机型号*/

@property (nonatomic, copy) NSString *departureAngle;

@property (nonatomic, copy) NSString *trailerTotalQuality;

@property (nonatomic, copy) NSString *crateLong;

@property (nonatomic, copy) NSString *afterWheelTrack;/*后轮距*/

@end

