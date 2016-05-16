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
@interface RegistViewController ()
@property (nonatomic, strong) UITextField *vinTextField, *pwdTextField, *rePwdTextField, *telephoneTextField;
@property (nonatomic, strong) UIButton *registBtn;
@property (nonatomic, strong) UITextView *locateVIN;
@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户注册";
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
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
                          @"key" : @"00c3a1a82ed6455eb442c5f2369dbc50"
                          };
     
    NSArray *allModel = [vinModel findAll];
    for (int i = 0; i<allModel.count; i++) {
        vinModel *haveModel =allModel[i];
        //查看数组数据能否成功读取
        if ([haveModel.telephone isEqualToString:self.telephoneTextField.text]) {
            [IHAcountTool showDelyHUD:@"该号码已经被注册" andView:self.view];
            return;
        }
        NSLog(@"array:%@",haveModel);
        //查看模型数据能否成功读取
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
            vinModel *models = [vinModel new];
            
            [models mj_setKeyValues:response[@"result"]];
            // 保存数据到数据库
            models.telephone = self.telephoneTextField.text;
            models.password = self.pwdTextField.text;
            [models save];
            
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

//得到数据：{
//    "error_code" = 0;
//    reason = "\U6210\U529f";
//    result =     {
//        afterWheelTrack = 1558;
//        beforeAfterHanging = "951/962";
//        beforeWheelTrack = 1544;
//        brand = "\U96ea\U4f5b\U5170(CHEVROLET)";
//        cabCarring = "";
//        carHigh = 1477;
//        carLong = 4598;
//        carWidth = 1797;
//        carrying = 5;
//        combustionType = "";
//        crateHight = "";
//        crateLong = "";
//        crateWidth = "";
//        departureAngle = "11.3/16.7";
//        displacement = 89;
//        emissionStandards = "GB18352.3-2005\U56fd\U2163";
//        engineProducers = "\U4e0a\U6d77\U901a\U7528\U4e1c\U5cb3\U52a8\U529b\U603b\U6210\U6709\U9650\U516c\U53f8";
//        engineType = LDE;
//        equipmentQuality = 1390;
//        loadQualityFactor = "";
//        maxSpeed = 180;
//        model = LDE;
//        name = "\U96ea\U4f5b\U5170(CHEVROLET) SGM7166ATB \U8f7f\U8f66";
//        power = 1598;
//        productionDate = "2010\U5e74\U6b3e ";
//        reatedQuality = "";
//        semiSaddleBearingQuelity = "";
//        shaftLoad = "950/850";
//        shaftNum = 2;
//        shaftdistance = 2685;
//        springNum = "-/-";
//        tireNum = 4;
//        tireSpecifications = "205/60R16,205/65R15";
//        totalQuality = "";
//        trailerTotalQuality = "";
//        turnToType = "";
//        type = "\U8f7f\U8f66";
//    };
//}
