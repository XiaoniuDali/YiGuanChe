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

@interface IanLoginViewController ()
@property (nonatomic,weak)UIButton *LoginBtn;
@property (nonatomic,weak)UITextField *nameTf;
@property (nonatomic,weak)UITextField *pwdTf;
@property (nonatomic,weak) UIView *loginView;

@end

@implementation IanLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    /**设置状态栏颜色*/
    SetStatusBarColor(self);

    /**设置子控件*/
    [self setSubview];
    
    
    [IanDefaultNotificationCenter addObserver:self selector:@selector(keyBoardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];

}

-(void)viewWillDisappear:(BOOL)animated
{
    /**删除了通知*/
    [IanDefaultNotificationCenter removeObserver:self];
}


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

-(void)setSubview
{
    UIView *LoginView =[[UIView alloc] init];
    CGFloat viewW =300;
    CGFloat viewH =400;
    CGFloat viewX =(self.view.width-viewW)*0.5;
    CGFloat viewY =self.view.height -viewH -20;

    LoginView.frame = CGRectMake(viewX, viewY, viewW, viewH);
    [LoginView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:LoginView];
    self.loginView =LoginView;
    

    /**登录名tf*/
    UITextField *nameTf =[[UITextField alloc] init];
    CGFloat nameTfW =300;
    CGFloat nameTfH =30;
    [nameTf setFrame:CGRectMake((LoginView.width -nameTfW)*0.5 ,LoginView.height *0.48 , nameTfW, nameTfH)];
    [nameTf becomeFirstResponder];
    [nameTf setPlaceholder:@"请输入您的账户名称"];
    nameTf.font =[UIFont systemFontOfSize:12];
    nameTf.borderStyle =UITextBorderStyleRoundedRect;
   

    self.nameTf =nameTf;
     [LoginView addSubview:nameTf];
    
    /**登陆密码tf*/
    UITextField *pwdTf =[[UITextField alloc] init];
    CGFloat pwdTfW =300;
    CGFloat pwdTfH =30;
    [pwdTf setFrame:CGRectMake((LoginView.width -pwdTfW)*0.5,LoginView.height *0.62 , pwdTfW, pwdTfH)];
    [pwdTf becomeFirstResponder];
    [pwdTf setPlaceholder:@"请输入您的账户密码"];
    pwdTf.font =[UIFont systemFontOfSize:12];
    pwdTf.borderStyle =UITextBorderStyleRoundedRect;
    pwdTf.secureTextEntry =YES;
    
    [LoginView addSubview:pwdTf];
    self.pwdTf =pwdTf;
    
    
    
    
    
    /**登录按钮*/
    UIButton *LoginBtn =[[UIButton alloc] init];
    [LoginBtn setBackgroundColor:ianRGBColor(59, 86, 128)];
    CGFloat btnW =200;
    CGFloat btnH =30;
    [LoginBtn setFrame:CGRectMake((LoginView.width - btnW)/2,LoginView.height * 0.80 , btnW, btnH)];
    [LoginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [LoginBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [LoginBtn addTarget:self action:@selector(LoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.LoginBtn =LoginBtn;
    [LoginView addSubview:LoginBtn];
    
    
}


-(void)LoginBtnClick
{
    CustomTabBarController *tab =[[CustomTabBarController alloc ] init];
    [tab.view setFrame:self.view.bounds];
    UIWindow *window =     [UIApplication sharedApplication].keyWindow;
    window.rootViewController =tab;
    [window makeKeyAndVisible];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
