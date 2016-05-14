//
//  ianDriveCardInfoViewController.m
//  GraduationDesign
//
//  Created by 谢伟成 on 16/5/2.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "ianDriveCardInfoViewController.h"
#import "FMDatabase.h"
#import "appMarco.h"
#import "IanShowExamineInfoViewController.h"


@interface ianDriveCardInfoViewController ()

@property (nonatomic,strong) FMDatabase * db;
@property (nonatomic,strong) FMResultSet * set;
@property (nonatomic,assign) NSString * driveCardID;

@property (nonatomic,weak) UILabel * signTimeLabel;
@property (nonatomic,weak) UILabel * signSiteLabel;

@property (nonatomic,weak) UILabel * validaTimeLabel;
@property (nonatomic,weak) UILabel * carTypeLabel;

@property (nonatomic,weak) UILabel * noteLabel;
@property (nonatomic,weak) UILabel * driveCardIdLabel;


@end

@implementation ianDriveCardInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubviews];
    
    
    self.view.frame =IanMainScreen.bounds;
    self.title =@"驾驶证信息";
    [self.view setBackgroundColor:ianRGBColor(231, 231,231)];
 
    self.db = [self openDataBase];
  
    if (![self isTableHasData]) {   
        [self didTap:@"请输入您的驾驶证档案号"];
    }else{
        FMResultSet *set = [self.db executeQuery:@"select * from driveCardInfo"];
        [self setDataWith:set];
    }
 
}

-(void)setSubviews
{
    UILabel *signTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 104, 350, 30)];
    
    _signTimeLabel =signTimeLabel;
    [self.view addSubview:self.signTimeLabel];
    
    
    UILabel *signSiteLabel =[[UILabel alloc] initWithFrame:CGRectMake(10, 148, 350, 30)];
    _signSiteLabel =signSiteLabel;
    [self.view addSubview:self.signSiteLabel];
    
    
    
    UILabel *carTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 192, 350, 30)];
    _carTypeLabel = carTypeLabel;
    [self.view addSubview:self.carTypeLabel];
    
    
    UILabel *validaTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 236, 350, 30)];
    _validaTimeLabel = validaTimeLabel;
    [self.view addSubview:self.validaTimeLabel];
    
    
    UILabel *noteLabel =[[UILabel alloc] initWithFrame:CGRectMake(10, 280, 350, 30)];
    _noteLabel =noteLabel;
    [self.view addSubview:self.noteLabel];
 
    
    UILabel *driveCardIdLabel =[[UILabel alloc] initWithFrame:CGRectMake(10, 324, 350, 30)];
    _driveCardIdLabel =driveCardIdLabel;
    [self.view addSubview:self.driveCardIdLabel];
 
    
    UIButton *alertBtn =[[UIButton alloc] initWithFrame:CGRectMake((self.view.width -301)*0.5, 500, 301,30)];
    [alertBtn setBackgroundImage:[UIImage imageNamed:@"reset"] forState:UIControlStateNormal];
    
    [alertBtn addTarget:self action:@selector(researchDriveCardId) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:alertBtn];
 
    
    UIButton *showBtn =[[UIButton alloc] initWithFrame:CGRectMake((self.view.width -301)*0.5, 540, 301,30)];
    [showBtn setBackgroundImage:[UIImage imageNamed:@"searchDriveCardInfo"] forState:UIControlStateNormal];
    [showBtn addTarget:self action:@selector(showExamineInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showBtn];
    
 
}

-(void)showExamineInfo
{
    IanShowExamineInfoViewController *ianShowExamineInfoVC = [[IanShowExamineInfoViewController alloc] init];
    
    self.hidesBottomBarWhenPushed=YES;
    //navgationC    释放出栈的视图控制器
    [self.navigationController pushViewController:ianShowExamineInfoVC animated:YES];
    
}

-(void)researchDriveCardId
{
  
    [self didTap:@"请输入您的驾驶证档案号"];
 
}


-(void)setDataWith:(FMResultSet *)set
{
    [set next];
    self.signTimeLabel.text =[NSString stringWithFormat:@"签发时间：%@",[set stringForColumn:@"signTime"]];
    self.signSiteLabel.text =[NSString stringWithFormat:@"签发地点：%@",[set stringForColumn:@"signSite"]];
    self.carTypeLabel.text =[NSString stringWithFormat:@"准驾驶车类型：%@",[set stringForColumn:@"carType"]];
    self.validaTimeLabel.text =[NSString stringWithFormat:@"有效期：%@ 至 %@",[set stringForColumn:@"signTime"],[set stringForColumn:@"validTime"]];
    self.noteLabel.text =[NSString stringWithFormat:@"记录：%@",[set stringForColumn:@"practiceTime"]];
    self.driveCardIdLabel.text =[NSString stringWithFormat:@"驾驶证档案号：%@",[set stringForColumn:@"driveCardId"]];
    [self.db close];
}


- (void)didTap:(NSString *)title
{
    
    UIAlertController* vc = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [vc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
       
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:vc.textFields.firstObject];
        
        NSString *driveCardID = vc.textFields[0].text;
        
        
        self.db = [self openDataBase];
        
        [self.db executeUpdate:@"delete from driveCardInfo"];
        
        FMResultSet * set = [self.db executeQuery:@"SELECT * from driveCardId_info where driveCardId = ?",driveCardID];
        
        [set next];
        
        if (![set stringForColumn:@"driveCardId"]) {  //没有这个档案号
            [self didTap:@"驾驶证档案号不正确"];

        }else{
            [self.db executeUpdate:@"insert into driveCardInfo(signSite,signTime,carType,validTime,practiceTime,driveCardId) values (?,?,?,?,?,?)",[set stringForColumn:@"signSite"],[set stringForColumn:@"signTime"],[set stringForColumn:@"carType"],[set stringForColumn:@"validTime"],[set stringForColumn:@"practiceTime"],[set stringForColumn:@"driveCardId"]];
            
            FMResultSet * sets = [self.db executeQuery:@"select * from driveCardInfo where driveCardId = ?",driveCardID];
            [self setDataWith:sets];
        }
 
        
    }]];
    
    [vc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:vc.textFields.firstObject];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }]];
  
 
 
    [vc addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
        textField.placeholder = @"驾驶证档案号";
        
        textField.keyboardType =UIKeyboardTypeNumberPad;
        
        textField.tag = 11;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
    }];
    vc.actions.firstObject.enabled =false;
    
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

- (void)alertTextFieldDidChange:(NSNotification *)notification{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController) {
//        //当文本输入大于6个字符的时候，让default选项可以被点击;
        UITextField *login = alertController.textFields.firstObject;
        UIAlertAction *okAction = alertController.actions.firstObject;
        okAction.enabled = login.text.length > 11;
        
    }
}


-(BOOL)isTableHasData
{
    BOOL result =[self.db executeUpdate:@"create table if not exists driveCardInfo (signSite text,signTime text,carType text,validTime text,practiceTime text,driveCardId text)"];
    if (result) {
        IanLog(@"创建驾驶证信息表成功");
    }
    
    self.set = [self.db executeQuery:@"select driveCardId from driveCardInfo"];
    [self.set next];
    return [self.set stringForColumn:@"driveCardId"];
}


-(void)viewWillAppear:(BOOL)animated
{
    self.db = [self openDataBase];
    
}

-(FMDatabase *)openDataBase
{
    
    NSString * doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName =[doc stringByAppendingPathComponent:@"appDb.sqlite"];
    
    FMDatabase *appDb =[FMDatabase databaseWithPath:fileName];
    
    IanLog(@"fileName==%@",fileName);
    
    if (![appDb open]) {
        NSLog(@"opne 失败");
    }else if ([appDb open])
    {
        IanLog(@"打开成功");
    }
    return appDb;
}


-(void)viewWillDisappear:(BOOL)animated
{
    [self.db close];
    IanLog(@"关闭成功");
}
@end
