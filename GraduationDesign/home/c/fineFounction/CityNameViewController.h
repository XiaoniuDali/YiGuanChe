//
//  CityNameViewController.h
//  GraduationDesign
//
//  Created by shupengstar on 16/4/5.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CityNameViewController;
@protocol CityNameViewControllerDelegate <NSObject>

- (void)getCityShortName : (CityNameViewController *)sender : (NSString *)shortName;

@end
@interface CityNameViewController : UIViewController

@property(nonatomic, copy)NSArray *provinceArray;

@property(nonatomic, assign)id<CityNameViewControllerDelegate>delegate;

@end
