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
#import "RegistViewController.h"
#import "IanNavigationController.h"

@interface IanLoginViewController ()
@property (nonatomic,strong)UIButton *LoginBtn, *registBtn, *fogetPw;
@property (nonatomic,strong)UITextField *nameTf, *pwdTf;
@property (nonatomic,strong) UIView *loginView;
@property (nonatomic, strong) UIImageView *logoImageView;

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
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
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
    self.logoImageView = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"carslogo"];

        imageView;
    });
    [self.view addSubview:self.logoImageView];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.topMargin.offset(150);
        
        make.centerXWithinMargins.mas_equalTo(weakSelf.view.mas_centerXWithinMargins);
        make.size.mas_equalTo(CGSizeMake(100, 80));
    }];

    self.nameTf = ({
        UITextField *nameTextFiled = [[UITextField alloc]init];
        nameTextFiled.placeholder = @"输入用户名";
        nameTextFiled.borderStyle =UITextBorderStyleRoundedRect;
        nameTextFiled.backgroundColor = [UIColor groupTableViewBackgroundColor];
        nameTextFiled;
    });
    [self.view addSubview:self.nameTf];
    [self.nameTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(300, 30));
        
    }];
    
    
    self.pwdTf = ({
        UITextField *pwdTextFiled = [[UITextField alloc]init];
        pwdTextFiled.placeholder = @"输入密码";
        pwdTextFiled.borderStyle =UITextBorderStyleRoundedRect;
        pwdTextFiled.secureTextEntry = YES;
        pwdTextFiled.backgroundColor = [UIColor groupTableViewBackgroundColor];
        pwdTextFiled;
    });
    [self.view addSubview:self.pwdTf];
    
    [self.pwdTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 30));
        make.centerYWithinMargins.mas_equalTo(50);
        make.centerXWithinMargins.mas_equalTo(weakSelf.nameTf.mas_centerXWithinMargins);
        
    }];
    
    
    
    self.LoginBtn = ({
        UIButton *loginBtn = [UIButton new];
        [loginBtn addTarget:self action:@selector(LoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
        [loginBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        loginBtn.layer.cornerRadius = 5.0;
        loginBtn.layer.masksToBounds = YES;
        loginBtn.backgroundColor = buttonColor;
        loginBtn;
    });
    [self.view addSubview:self.LoginBtn];
    [self.LoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 30));
        make.centerYWithinMargins.mas_equalTo(120);
        make.centerXWithinMargins.mas_equalTo(weakSelf.pwdTf.mas_centerXWithinMargins);
        
    }];
    
    self.registBtn = ({
        UIButton *registbtn = [UIButton new];
        [registbtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [registbtn setTitle:@"快速注册" forState:UIControlStateNormal];
        registbtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [registbtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        registbtn;
    });
    [self.view addSubview:self.registBtn];
    [self.registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.centerYWithinMargins.mas_equalTo(156);
        make.centerXWithinMargins.mas_equalTo(50);
    }];
    
    self.fogetPw = ({
        UIButton *fogetPw = [UIButton new];
        [fogetPw addTarget:self action:@selector(fogetPwd) forControlEvents:UIControlEventTouchUpInside];
        [fogetPw setTitle:@"忘记密码" forState:UIControlStateNormal];
        fogetPw.titleLabel.font = [UIFont systemFontOfSize:12];
        [fogetPw setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        fogetPw;
    });
    [self.view addSubview:self.fogetPw];
    [self.fogetPw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.centerYWithinMargins.mas_equalTo(156);
        make.centerXWithinMargins.mas_equalTo(-50);
    }];
}
- (void)registBtnClick{
    RegistViewController *regist = [RegistViewController new];

    [self.navigationController pushViewController:regist animated:NO];
}
- (void)fogetPwd{
    
}

-(void)LoginBtnClick
{
    if (self.nameTf.text.length == 0 || self.pwdTf.text.length == 0) {
        
        [IHAcountTool showDelyHUD:@"用户名或密码不能为空" andView:self.view];
        
        return;
    }
    
    
    NSArray *allModel = [vinModel findAll];
    
    for (int i = 0; i<allModel.count; i++) {
        
        vinModel *haveModel =allModel[i];
        //查看数组数据能否成功读取
        if ([haveModel.telephone isEqualToString:self.nameTf.text]) {
            
            if ([haveModel.password isEqualToString:self.pwdTf.text]) {
                
                CustomTabBarController *tab =[[CustomTabBarController alloc ] init];
                [tab.view setFrame:self.view.bounds];
                
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                
                window.rootViewController =tab;
                
                [window makeKeyAndVisible];
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        } else {
            
            [IHAcountTool showDelyHUD:@"用户名或密码错误" andView:self.view];
        }
        NSLog(@"array:%@",haveModel);
        //查看模型数据能否成功读取
    }
    
}

@end
