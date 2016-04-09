//
//  IanLogViewController.m
//  IHGP
//
//  Created by 谢伟成 on 16/1/13.
//  Copyright (c) 2016年 谢伟成. All rights reserved.
//

#import "IanLoginViewController.h"
#import "UIWindow+Extension.h"
#import "appMarco.h"
#import "CustomTabBarController.h"
#import <Masonry.h>
@interface IanLoginViewController ()
@property (nonatomic,strong)UIButton *LoginBtn;
@property (nonatomic,strong)UITextField *nameTf, *pwdTf;
@property (nonatomic,strong) UIView *loginView;

@end

@implementation IanLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    /**设置状态栏颜色*/
//    SetStatusBarColor(self);

    /**设置子控件*/
    [self setSubview];

    [IanDefaultNotificationCenter addObserver:self selector:@selector(keyBoardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    /**删除了通知*/
    [IanDefaultNotificationCenter removeObserver:self];
}

#pragma mark --- 键盘
-(void)keyBoardDidChangeFrame:(NSNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    CGRect rect =[dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double time =[dict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
 
    /**修改登录view的位置*/
    [UIView animateWithDuration:time*0.5 animations:^{
       self.loginView.y =rect.origin.y-self.loginView.height -20;
    }];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark --- 界面搭建
-(void)setSubview
{
    __weak typeof(self) weakSelf = self;
    
    self.nameTf = ({
        UITextField *nameTextFiled = [[UITextField alloc]init];
        nameTextFiled.placeholder = @"输入用户名";
        nameTextFiled.borderStyle =UITextBorderStyleRoundedRect;
        nameTextFiled;
    });
    [self.view addSubview:self.nameTf];
    [self.nameTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(300, 30));
        
    }];
    self.nameTf.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.pwdTf = ({
        UITextField *pwdTextFiled = [[UITextField alloc]init];
        pwdTextFiled.placeholder = @"输入密码";
        pwdTextFiled.borderStyle =UITextBorderStyleRoundedRect;
        pwdTextFiled;
    });
    [self.view addSubview:self.pwdTf];
    
    [self.pwdTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 30));
        make.centerYWithinMargins.mas_equalTo(50);
        make.centerXWithinMargins.mas_equalTo(self.nameTf.mas_centerXWithinMargins);
        
    }];
    self.pwdTf.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    self.LoginBtn = ({
        UIButton *loginBtn = [UIButton new];
        [loginBtn addTarget:self action:@selector(LoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
        [loginBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        loginBtn.layer.cornerRadius = 5.0;
        loginBtn.layer.masksToBounds = YES;
        loginBtn;
    });
    [self.view addSubview:self.LoginBtn];
    
    [self.LoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 30));
        make.centerYWithinMargins.mas_equalTo(120);
        make.centerXWithinMargins.mas_equalTo(self.pwdTf.mas_centerXWithinMargins);
        
    }];
    self.LoginBtn.backgroundColor = ianRGBColor(59, 86, 128);
}


-(void)LoginBtnClick
{
    CustomTabBarController *tab =[[CustomTabBarController alloc ] init];
    [tab.view setFrame:self.view.bounds];
    UIWindow *window =     [UIApplication sharedApplication].keyWindow;
    window.rootViewController =tab;
    [window makeKeyAndVisible];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
