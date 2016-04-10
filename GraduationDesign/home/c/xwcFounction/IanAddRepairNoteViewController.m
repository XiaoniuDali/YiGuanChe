//
//  IanAddRepairNoteViewController.m
//  GraduationDesign
//
//  Created by 谢伟成 on 16/4/5.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "IanAddRepairNoteViewController.h"
#import "appMarco.h"

@interface IanAddRepairNoteViewController ()

@end

@implementation IanAddRepairNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.frame =IanMainScreen.bounds;
    [self.view setBackgroundColor:ianRGBColor(231, 231, 231)];
    self.title =@"增加维修记录";
    
    [self setSubviews];
    
    
}

-(void)setSubviews
{
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
