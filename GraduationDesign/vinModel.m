//
//  vinModel.m
//  GraduationDesign
//
//  Created by shupengstar on 16/4/2.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "vinModel.h"

@implementation vinModel
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.telephone forKey:@"telephone"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.BSQLX forKey:@"BSQLX"];
    [aCoder encodeObject:self.BSQMS forKey:@"BSQMS"];
    [aCoder encodeObject:self.CJMC forKey:@"CJMC"];
    [aCoder encodeObject:self.CLDM forKey:@"CLDM"];
    [aCoder encodeObject:self.CLLX forKey:@"CLLX"];
    [aCoder encodeObject:self.CMS forKey:@"CMS"];
    [aCoder encodeObject:self.CSXS forKey:@"CSXS"];
    [aCoder encodeObject:self.CX forKey:@"CX"];
    [aCoder encodeObject:self.CXI forKey:@"CXI"];
    [aCoder encodeObject:self.DWS forKey:@"DWS"];
    
    [aCoder encodeObject:self.FDJGS forKey:@"FDJGS"];
    [aCoder encodeObject:self.FDJXH forKey:@"FDJXH"];
    [aCoder encodeObject:self.GL forKey:@"GL"];
    [aCoder encodeObject:self.JB forKey:@"JB"];
    [aCoder encodeObject:self.NK forKey:@"NK"];
    [aCoder encodeObject:self.NLevelID forKey:@"NLevelID"];
    [aCoder encodeObject:self.PFBZ forKey:@"PFBZ"];
    [aCoder encodeObject:self.PL forKey:@"PL"];
    [aCoder encodeObject:self.PP forKey:@"PP"];
    [aCoder encodeObject:self.QDFS forKey:@"QDFS"];
    
    [aCoder encodeObject:self.RYBH forKey:@"RYBH"];
    [aCoder encodeObject:self.RYLX forKey:@"RYLX"];
    [aCoder encodeObject:self.SCNF forKey:@"SCNF"];
    [aCoder encodeObject:self.SSNF forKey:@"SSNF"];
    [aCoder encodeObject:self.SSYF forKey:@"SSYF"];
    [aCoder encodeObject:self.TCNF forKey:@"TCNF"];
    [aCoder encodeObject:self.VINNF forKey:@"VINNF"];
    [aCoder encodeObject:self.Vin forKey:@"Vin"];
    [aCoder encodeObject:self.XSMC forKey:@"XSMC"];
    [aCoder encodeObject:self.ZDJG forKey:@"ZDJG"];
    [aCoder encodeObject:self.ZWS forKey:@"ZWS"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.telephone = [aDecoder decodeObjectForKey:@"telephone"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.BSQLX = [aDecoder decodeObjectForKey:@"BSQLX"];
        self.BSQMS = [aDecoder decodeObjectForKey:@"BSQMS"];
        self.CJMC = [aDecoder decodeObjectForKey:@"CJMC"];
        self.CLDM = [aDecoder decodeObjectForKey:@"CLDM"];
        self.CLLX = [aDecoder decodeObjectForKey:@"CLLX"];
        self.CMS = [aDecoder decodeObjectForKey:@"CMS"];
        self.CSXS = [aDecoder decodeObjectForKey:@"CSXS"];
        self.CX = [aDecoder decodeObjectForKey:@"CX"];
        self.CXI = [aDecoder decodeObjectForKey:@"CXI"];
        self.DWS = [aDecoder decodeObjectForKey:@"DWS"];
        
        self.FDJGS = [aDecoder decodeObjectForKey:@"FDJGS"];
        self.FDJXH = [aDecoder decodeObjectForKey:@"FDJXH"];
        self.GL = [aDecoder decodeObjectForKey:@"GL"];
        self.JB = [aDecoder decodeObjectForKey:@"JB"];
        self.NLevelID = [aDecoder decodeObjectForKey:@"NLevelID"];
        self.PFBZ = [aDecoder decodeObjectForKey:@"PFBZ"];
        self.CSXS = [aDecoder decodeObjectForKey:@"CSXS"];
        self.CX = [aDecoder decodeObjectForKey:@"CX"];
        self.PL = [aDecoder decodeObjectForKey:@"PL"];
        self.PP = [aDecoder decodeObjectForKey:@"PP"];
        self.QDFS = [aDecoder decodeObjectForKey:@"QDFS"];
        
        self.RYBH = [aDecoder decodeObjectForKey:@"RYBH"];
        self.RYLX = [aDecoder decodeObjectForKey:@"RYLX"];
        self.SCNF = [aDecoder decodeObjectForKey:@"SCNF"];
        self.SSNF = [aDecoder decodeObjectForKey:@"SSNF"];
        self.SSYF = [aDecoder decodeObjectForKey:@"SSYF"];
        self.TCNF = [aDecoder decodeObjectForKey:@"TCNF"];
        self.VINNF = [aDecoder decodeObjectForKey:@"VINNF"];
        self.Vin = [aDecoder decodeObjectForKey:@"Vin"];
        self.XSMC = [aDecoder decodeObjectForKey:@"XSMC"];
        self.ZDJG = [aDecoder decodeObjectForKey:@"ZDJG"];
        self.ZWS = [aDecoder decodeObjectForKey:@"ZWS"];
    }
    return self;
}

@end



