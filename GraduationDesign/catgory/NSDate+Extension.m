//
//  NSDate+Extension.m
//  Day50-WeiBo2
//
//  Created by 谢伟成 on 15/12/15.
//  Copyright (c) 2015年 谢伟成. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)



-(BOOL)isThisYear
{
    /**获取现在的时间和创建时间进行比较 只有一种情况是今年那就是cmp的year相等*/
    NSDate *now =[NSDate date];
    
    NSCalendar *calendar =[NSCalendar currentCalendar];
    NSCalendarUnit unit =NSCalendarUnitYear;
    
    NSDateComponents *CreateCmp =[calendar components:unit fromDate:self];
    NSDateComponents *nowCmp = [calendar components:unit fromDate:now];
    
    //    IanLog(@"isThisYearWithDate==%d",CreateCmp.year==nowCmp.year);
    
    return CreateCmp.year==nowCmp.year;
}

-(BOOL)isYesterday
{
    /**由于已经确定是今年的发的微博 所以不需要判断*/
    NSDate *now =[NSDate date];
    NSDateFormatter *fmt =[[NSDateFormatter alloc]init];
    fmt.dateFormat =@"yyyy-MM-dd";
    NSString *nowStr =[fmt stringFromDate:now];
    NSString *dateStr =[fmt stringFromDate:self];
    NSDate *nowDate =[fmt dateFromString:nowStr];
    NSDate *dateDate =[fmt dateFromString:dateStr];
    
    //    IanLog(@"nowStr==%@---dateStr==%@",nowStr,dateStr);
    
    NSCalendar *calendar =[NSCalendar currentCalendar];
    NSCalendarUnit unit =NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *CreateCmp =[calendar components:unit fromDate:dateDate toDate:nowDate options:0];
    
    //    IanLog(@"isYesterdayWithDate==%d",CreateCmp.year==0 && CreateCmp.month ==0 && CreateCmp.day==1);
    
    return CreateCmp.year==0 && CreateCmp.month ==0 && CreateCmp.day==1;
}


-(BOOL)isToday
{
    /**由于已经确定是今年的发的微博 所以不需要判断*/
    NSDate *now =[NSDate date];
    NSDateFormatter *fmt =[[NSDateFormatter alloc]init];
    fmt.dateFormat =@"yyyy-MM-dd";
    NSString *nowStr =[fmt stringFromDate:now];
    NSString *dateStr =[fmt stringFromDate:self];
    //    IanLog(@"isTodayWithDate==%d", [nowStr isEqualToString:dateStr]);
    
    return [nowStr isEqualToString:dateStr];
    
}

@end
