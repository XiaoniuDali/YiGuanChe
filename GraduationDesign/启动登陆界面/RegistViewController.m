//
//  RegistViewController.m
//  GraduationDesign
//
//  Created by shupengstar on 16/4/10.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "RegistViewController.h"
#import <Masonry.h>
#import <IQKeyboardManager.h>
#import "NetworkManager.h"
#import <MJExtension.h>
#import "IanLoginViewController.h"
#import <FMDatabase.h>
#import "appMarco.h"
@interface RegistViewController ()
@property (nonatomic, strong) UITextField *vinTextField, *pwdTextField, *rePwdTextField, *telephoneTextField;
@property (nonatomic, strong) UIButton *registBtn;
@property (nonatomic, strong) UITextView *locateVIN;
@property (nonatomic, strong) FMDatabase *dataBaseHandle;
@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户注册";
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    
    self.dataBaseHandle =[self createDatabase];
    [self createDataBase];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [self.dataBaseHandle close];
}

// 创建数据库
-(FMDatabase *)createDatabase
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
- (void)createDataBase{
    
    BOOL result =[ self.dataBaseHandle executeUpdate:@"create table if not exists vinModel(id integer primary key autoincrement,BSQLX text,BSQMS text,CJMC text,CLDM text,CLLX text,CMS text,CSXS text,CX text,CXI text,DWS text,FDJGS text,FDJXH text,GL text,JB text,NK text,NLevelID text,PFBZ,PL text,PP text,QDFS text,RYBH text,RYLX text,SCNF text,SSNF text,SSYF text,TCNF text,VINNF text,Vin text,XSMC text,ZDJG text,ZWS text)"];
    
    if (result) {
        NSLog(@"创建表成功");
    }else
    {
        NSLog(@"创建表失败");
    }
    
}

- (void)setUI{
    __weak typeof(self) weakSelf = self;
    self.locateVIN = ({
        UITextView *textView = [UITextView new];
        textView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        textView.text = @"如何找到您的VIN码\n1.除挂车和摩托车外，标牌应固定在仪表板的左侧,前挡风玻璃左下方；\n2.如果没有这样的地方可利用，则固定在门铰链柱、门锁柱或与门锁柱接合的门边之一的柱子上。\n3.如果那里也不能利用，则固定在车门内侧靠近驾驶员座位的地方。\n4.如果上述位置都不能利用，则要向NHTSA书面申请。";
        textView.editable = NO;
        textView;
    });
    self.vinTextField = ({
        UITextField *textfield = [UITextField new];
        textfield.placeholder = @"请输入您汽车的VIN码(17位)";
        textfield.borderStyle =UITextBorderStyleRoundedRect;
        textfield.backgroundColor = [UIColor groupTableViewBackgroundColor];
        textfield;
    });
    self.telephoneTextField = ({
        UITextField *textfield = [UITextField new];
        textfield.placeholder = @"请输入您的手机号码";
        textfield.borderStyle =UITextBorderStyleRoundedRect;
        textfield.backgroundColor = [UIColor groupTableViewBackgroundColor];
        textfield;
    });
    self.pwdTextField = ({
        UITextField *textfield = [UITextField new];
        textfield.placeholder = @"请输入密码";
        textfield.borderStyle =UITextBorderStyleRoundedRect;
        textfield.secureTextEntry = YES;
        textfield.backgroundColor = [UIColor groupTableViewBackgroundColor];
        textfield;
    });
    self.rePwdTextField = ({
        UITextField *textfield = [UITextField new];
        textfield.placeholder = @"请确认密码";
        textfield.borderStyle =UITextBorderStyleRoundedRect;
        textfield.secureTextEntry = YES;
        textfield.backgroundColor = [UIColor groupTableViewBackgroundColor];
        textfield;
    });
    self.registBtn = ({
        UIButton *regist = [UIButton new];
        [regist addTarget:self action:@selector(registButton) forControlEvents:UIControlEventTouchUpInside];
        [regist setTitle:@"注册" forState:UIControlStateNormal];
        [regist.titleLabel setFont:[UIFont systemFontOfSize:14]];
        regist.layer.cornerRadius = 5.0;
        regist.layer.masksToBounds = YES;
        regist.backgroundColor = buttonColor;
        regist;
    });
    [self.view addSubview:self.locateVIN];
    [self.view addSubview:self.vinTextField];
    [self.view addSubview:self.telephoneTextField];
    [self.view addSubview:self.pwdTextField];
    [self.view addSubview:self.rePwdTextField];
    [self.view addSubview:self.registBtn];
    
    [self.locateVIN mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(weakSelf.view);
        make.centerXWithinMargins.mas_equalTo(weakSelf.vinTextField.mas_centerXWithinMargins);
        make.top.mas_offset(80);
        make.size.mas_equalTo(CGSizeMake(300, 150));
        
    }];
    
    [self.vinTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(300, 30));
        
    }];
    
    [self.telephoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerYWithinMargins.mas_equalTo(50);
        make.centerXWithinMargins.mas_equalTo(weakSelf.vinTextField.mas_centerXWithinMargins);
        make.size.mas_equalTo(CGSizeMake(300, 30));
        
    }];

    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerYWithinMargins.mas_equalTo(100);
        make.centerXWithinMargins.mas_equalTo(weakSelf.vinTextField.mas_centerXWithinMargins);
        make.size.mas_equalTo(CGSizeMake(300, 30));
        
    }];
    
    [self.rePwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerYWithinMargins.mas_equalTo(150);
        make.centerXWithinMargins.mas_equalTo(weakSelf.vinTextField.mas_centerXWithinMargins);
        make.size.mas_equalTo(CGSizeMake(300, 30));
        
    }];
    [self.registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerYWithinMargins.mas_equalTo(200);
        make.centerXWithinMargins.mas_equalTo(weakSelf.vinTextField.mas_centerXWithinMargins);
        make.size.mas_equalTo(CGSizeMake(200, 30));
        
    }];
    
}
- (void)registButton{
//   apikey   e28898efbd004bf78dc03d1c3734619b
    // 汽车VIN   LSGPC52U6AF102554
    
//      伟成：49756c81fcd3498f8847d9e7ff7eeab2
//    http://www.haoservice.com/docs/58
    
//     http://apis.haoservice.com/lifeservice/vin?vin=LSGPC52U6AF102554&key=您申请的APPKEY
    
    
//     http://apis.haoservice.com/efficient/vinservice?vin=LSGPC52U6AF102554&key=您申请的APPKEY
    
    [IHAcountTool showHUD:@"" andView:self.view];
    NSDictionary *dic = @{
                          @"vin" : @"LSGPC52U6AF102554",//self.vinTextField.text,//
                          @"key" : @"49756c81fcd3498f8847d9e7ff7eeab2"
                          };
//    NSDictionary *dic = nil;
    
    NSArray *allModel = [vinModel findAll];
    for (int i = 0; i<allModel.count; i++) {
        vinModel *haveModel =allModel[i];
        //查看数组数据能否成功读取
        if ([haveModel.telephone isEqualToString:self.telephoneTextField.text]) {
            [IHAcountTool showDelyHUD:@"该号码已经被注册" andView:self.view];
            return;
        }
        NSLog(@"array:%@",haveModel);
        //查看模型数据能否成功读取广州宝马
    }
    
    if (self.vinTextField.text.length == 0 || self.vinTextField.text.length != 17) {
        [IHAcountTool showDelyHUD:@"请输入正确VIN码" andView:self.view];
        return;
    }
    if (![self.pwdTextField.text isEqualToString:self.rePwdTextField.text]) {
        [IHAcountTool showDelyHUD:@"两次密码不一样" andView:self.view];
        return;
    }
    if (self.telephoneTextField.text.length != 11 || self.telephoneTextField.text.length == 0) {
        [IHAcountTool showDelyHUD:@"手机号不正确" andView:self.view];
        return;
    }

    [[NetworkManager shareMgr] app_search_VIN:dic completeHandle:^(NSDictionary *response) {
        NSLog(@"得到数据：%@",response);

        if (response[@"result"]) {
            
            NSDictionary *dic =response[@"result"];
            
            [self.dataBaseHandle executeUpdate:@"DELETE FROM vinModel"];
            NSString * telephone = self.telephoneTextField.text;
            NSString * password = self.pwdTextField.text;
            NSString * BSQLX = dic[@"BSQLX"];
            NSString * BSQMS = dic[@"BSQMS"];
            NSString * CJMC = dic[@"CJMC"];
            NSString * CLDM = dic[@"CLDM"];
            NSString * CLLX = dic[@"CLLX"];
            NSString * CMS = dic[@"CMS"];
            NSString * CSXS = dic[@"CSXS"];
            NSString * CX = dic[@"CX"];
            NSString * CXI = dic[@"CXI"];
            NSString * DWS = dic[@"DWS"];
            NSString * FDJGS = dic[@"FDJGS"];
            NSString * FDJXH = dic[@"FDJXH"];
            NSString * GL = dic[@"GL"];
            NSString * JB = dic[@"JB"];
            NSString * NK = dic[@"NK"];
            NSString * NLevelID = dic[@"NLevelID"];
            NSString * PFBZ = dic[@"PFBZ"];
            NSString * PL = dic[@"PL"];
            NSString * PP = dic[@"PP"];
            NSString * QDFS = dic[@"QDFS"];
            NSString * RYBH = dic[@"RYBH"];
            NSString * RYLX = dic[@"RYLX"];
            NSString * SCNF = dic[@"SCNF"];
            NSString * SSNF = dic[@"SSNF"];
            NSString * SSYF = dic[@"SSYF"];
            NSString * TCNF = dic[@"TCNF"];
            NSString * VINNF = dic[@"VINNF"];
            NSString * Vin = dic[@"Vin"];
            NSString * XSMC = dic[@"XSMC"];
            NSString * ZDJG = dic[@"ZDJG"];
            NSString * ZWS = dic[@"ZWS"];
            
            
            [self.dataBaseHandle executeUpdate:@"insert into vinModel(telephone,password,BSQLX ,BSQMS ,CJMC ,CLDM ,CLLX,CMS,CSXS ,CX ,CXI ,DWS ,FDJGS ,FDJXH ,GL,JB,NK ,NLevelID ,PFBZ,PL ,PP ,QDFS ,RYBH ,RYLX,SCNF,SSNF ,SSYF,TCNF ,VINNF,Vin,XSMC,ZDJG,ZWS) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",telephone,password,BSQLX ,BSQMS ,CJMC ,CLDM ,CLLX,CMS,CSXS ,CX ,CXI ,DWS ,FDJGS ,FDJXH ,GL,JB,NK ,NLevelID ,PFBZ,PL ,PP ,QDFS ,RYBH ,RYLX,SCNF,SSNF ,SSYF,TCNF ,VINNF,Vin,XSMC,ZDJG,ZWS];
            
            [IHAcountTool showDelyHUD:@"注册成功" andView:self.view];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [IHAcountTool showDelyHUD:@"注册成功" andView:self.view];
                
                [self.navigationController popViewControllerAnimated:YES];
            });
        } else {
            
            [IHAcountTool showDelyHUD:@"注册失败" andView:self.view];

        }

        //保存数据到数据库（模型中的成员变量有数组与模型）
        //    //如果模型中的成员变量是数组或者自定义模型，就将数组或者自定义模型归档(NSKeyedArchive)为二进制数据，再存入数据库；从数据库取出数据时，将二进制数据解档（NSKeyedUnArchive）为数组或者自定义模型；
    }];
}
@end

//result =     {
//    BSQLX = "\U624b\U52a8";变速器类型
//    BSQMS = "\U624b\U52a8\U53d8\U901f\U5668(MT)";变速箱描述
//    CJMC = "\U4e0a\U6d77\U901a\U7528";厂家名称
//    CLDM = SGM7169MTA;车型代码
//    CLLX = "\U8f7f\U8f66";车辆类型
//    CMS = "\U56db\U95e8";车门数
//    CSXS = "\U4e09\U53a2";车身形式
//    CX = "\U79d1\U9c81\U5179";车型
//    CXI = "\U79d1\U9c81\U5179";车系
//    DWS = 5;档位数
//    FDJGS = 4;缸数
//    FDJXH = LDE;发动机型号
//    GL = 86;发动机最大功率(kW)
//    JB = "\U7d27\U51d1\U578b\U8f66";车辆级别
//    NK = 2010;年款
//    NLevelID = CGX0516M0005;
//    PFBZ = "\U56fd4";排放标准
//    PL = "1.6";	排量
//    PP = "\U96ea\U4f5b\U5170";品牌
//    QDFS = "\U524d\U8f6e\U9a71\U52a8";驱动方式
//    RYBH = "93#";燃油标号
//    RYLX = "\U6c7d\U6cb9";燃油类型
//    SCNF = 2010;生产年份
//    SSNF = 2010;上市年份
//    SSYF = 8;上市月份
//    TCNF = 2011;停产年份
//    VINNF = 2010;VIN对应的年份，可为具体的年份和“未查到年代”两种
//    Vin = LSGPC52U6AF102554;
//    XSMC = "1.6 \U624b\U52a8 SL \U5929\U5730\U7248";销售名称
//    ZDJG = "11.39";指导价格
//    ZWS = 5;座位数
//};