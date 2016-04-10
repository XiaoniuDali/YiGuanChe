//
//  vinModel.m
//  GraduationDesign
//
//  Created by shupengstar on 16/4/2.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "vinModel.h"

//@implementation vinModel
//
//@end
@implementation vinModel
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.shaftdistance forKey:@"shaftdistance"];
    [aCoder encodeObject:self.crateWidth forKey:@"crateWidth"];
    [aCoder encodeObject:self.loadQualityFactor forKey:@"loadQualityFactor"];
    [aCoder encodeObject:self.displacement forKey:@"displacement"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.shaftdistance = [aDecoder decodeObjectForKey:@"shaftdistance"];
        self.crateWidth = [aDecoder decodeObjectForKey:@"crateWidth"];
        self.loadQualityFactor = [aDecoder decodeObjectForKey:@"loadQualityFactor"];
        self.displacement = [aDecoder decodeObjectForKey:@"displacement"];
    }
    return self;
}
@end
