//
//  IanNoteRepairController.m
//  IHGP
//
//  Created by 谢伟成 on 16/3/30.
//  Copyright © 2016年 谢伟成. All rights reserved.
//

#import "IanNoteRepairController.h"
#import "appMarco.h"

@interface IanNoteRepairController ()

@end

@implementation IanNoteRepairController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame =IanMainScreen.bounds;
//    self.title ="请输入您的"
    [self.view setBackgroundColor:ianRGBColor(59, 86,128)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
