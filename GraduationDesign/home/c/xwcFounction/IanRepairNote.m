//
//  IanRepairNote.m
//  GraduationDesign
//
//  Created by 谢伟成 on 16/4/16.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "IanRepairNote.h"

@implementation IanRepairNote

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.time forKey:@"time"];
    [aCoder encodeObject:self.site forKey:@"site"];
    [aCoder encodeObject:self.money forKey:@"money"];
    [aCoder encodeObject:self.projectName forKey:@"projectName"];
    
    
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.time = [aDecoder decodeObjectForKey:@"time"];
        self.site = [aDecoder decodeObjectForKey:@"site"];
        self.money = [aDecoder decodeObjectForKey:@"money"];
        self.projectName = [aDecoder decodeObjectForKey:@"projectName"]; 
 
    }
    return self;
}

@end
