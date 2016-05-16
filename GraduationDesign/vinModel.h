//
//  vinModel.h
//  GraduationDesign
//
//  Created by shupengstar on 16/4/2.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tool_FMDBModel.h"

//@class Result;
//@interface vinModel :Tool_FMDBModel<NSCoding>
//
//@property (nonatomic, assign) NSInteger error_code;
//
//@property (nonatomic, strong) Result *result;
//
//@property (nonatomic, copy) NSString *reason;
//
//@end


@interface vinModel : Tool_FMDBModel<NSCoding>

@property (nonatomic, copy) NSString *telephone;

@property (nonatomic, copy) NSString *password;

@property (nonatomic, copy) NSString *GL;

@property (nonatomic, copy) NSString *CSXS;

@property (nonatomic, copy) NSString *BSQMS;

@property (nonatomic, copy) NSString *PL;

@property (nonatomic, copy) NSString *CX;

@property (nonatomic, copy) NSString *CLDM;

@property (nonatomic, copy) NSString *SSNF;

@property (nonatomic, copy) NSString *CLLX;

@property (nonatomic, copy) NSString *BSQLX;

@property (nonatomic, copy) NSString *TCNF;

@property (nonatomic, copy) NSString *SSYF;

@property (nonatomic, copy) NSString *NK;

@property (nonatomic, copy) NSString *CMS;

@property (nonatomic, copy) NSString *FDJXH;

@property (nonatomic, copy) NSString *SCNF;

@property (nonatomic, copy) NSString *ZWS;

@property (nonatomic, copy) NSString *Vin;

@property (nonatomic, copy) NSString *RYBH;

@property (nonatomic, copy) NSString *PP;

@property (nonatomic, copy) NSString *CXI;

@property (nonatomic, copy) NSString *RYLX;

@property (nonatomic, copy) NSString *XSMC;

@property (nonatomic, copy) NSString *CJMC;

@property (nonatomic, copy) NSString *QDFS;

@property (nonatomic, copy) NSString *VINNF;

@property (nonatomic, copy) NSString *FDJGS;

@property (nonatomic, copy) NSString *PFBZ;

@property (nonatomic, copy) NSString *JB;

@property (nonatomic, copy) NSString *ZDJG;

@property (nonatomic, copy) NSString *NLevelID;

@property (nonatomic, copy) NSString *DWS;
@end

