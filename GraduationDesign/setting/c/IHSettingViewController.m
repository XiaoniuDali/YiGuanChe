//
//  IHSettingViewControllerViewController.m
//  GraduationDesign
//
//  Created by shupengstar on 16/5/13.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "IHSettingViewController.h"
#import "SettingTableViewCell.h"
#import <FMDatabase.h>
@interface IHSettingViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSString *_fileName;
}
@property (weak, nonatomic) IBOutlet UITableView *settingTableView;
@property (nonatomic, strong) UIButton *headerForBtn;
@property (nonatomic, strong) FMDatabase *dataBaseHandle;
@property (nonatomic, strong) NSDictionary *locationDic;
@end

@implementation IHSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.settingTableView.backgroundColor = [UIColor  groupTableViewBackgroundColor];
    self.settingTableView.tableFooterView = [UIView new];
    [self headerView];
    self.dataBaseHandle =[self createDatabase];
    [self openDatabase];
}
- (void)openDatabase{
    // 打开数据库
    [self.dataBaseHandle open];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT *FROM vinModel WHERE telephone=15088132368"]; // 奔驰
    
    FMResultSet *resultSet = [self.dataBaseHandle executeQuery:sql];
    
    while ([resultSet next]){
        
        self.locationDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [resultSet stringForColumn:@"BSQLX"],@"BSQLX",
                                   [resultSet stringForColumn:@"BSQMS"],@"BSQMS",
                                   [resultSet stringForColumn:@"CJMC"],@"CJMC",
                                   [resultSet stringForColumn:@"CLDM"],@"CLDM",
                                   [resultSet stringForColumn:@"CLLX"],@"CLLX",
                                   [resultSet stringForColumn:@"CMS"],@"CMS",
                                   [resultSet stringForColumn:@"SSYF"],@"SSYF",
                                   [resultSet stringForColumn:@"SSNF"],@"SSNF",
                            [resultSet stringForColumn:@"CSXS"],@"CSXS",
                            [resultSet stringForColumn:@"CX"],@"CX",
                            [resultSet stringForColumn:@"CXI"],@"CXI",
                            [resultSet stringForColumn:@"DWS"],@"DWS",
                            [resultSet stringForColumn:@"FDJGS"],@"FDJGS",
                            [resultSet stringForColumn:@"FDJXH"],@"FDJXH",
                            [resultSet stringForColumn:@"FDJXH"],@"FDJXH",
                            [resultSet stringForColumn:@"GL"],@"GL",
                            [resultSet stringForColumn:@"JB"],@"JB",
                            [resultSet stringForColumn:@"NK"],@"NK",
                            [resultSet stringForColumn:@"PFBZ"],@"PFBZ",
                            [resultSet stringForColumn:@"PL"],@"PL",
                            [resultSet stringForColumn:@"PP"],@"PP",
                            [resultSet stringForColumn:@"QDFS"],@"QDFS",
                            [resultSet stringForColumn:@"RYBH"],@"RYBH",
                            [resultSet stringForColumn:@"RYLX"],@"RYLX",
                            [resultSet stringForColumn:@"SCNF"],@"SCNF",
                            [resultSet stringForColumn:@"TCNF"],@"TCNF",
                            [resultSet stringForColumn:@"ZDJG"],@"ZDJG",
                            [resultSet stringForColumn:@"ZWS"],@"ZWS",
                            nil];
        NSLog(@"%@",self.locationDic);
        
    }
}
-(FMDatabase *)createDatabase
{
    FMDatabase *appDb =[FMDatabase databaseWithPath:[self databasePath]];
    
    return appDb;
}
// 数据库路径
- (NSString *)databasePath{
    NSString * doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *filePath =[doc stringByAppendingPathComponent:@"appDb.sqlite"];
    
    NSLog(@"保存路径：%@",filePath);
    
    return filePath;
}


- (void)headerView{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];

    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    backImageView.image = [UIImage imageNamed:@"YellowBoy"];
    backImageView.alpha = 0.7;
    [headerView addSubview:backImageView];

    
    self.headerForBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width -100)/2.0, 50, 100, 100)];
    self.headerForBtn.layer.cornerRadius = 50;
    self.headerForBtn.layer.masksToBounds = YES;
    [self.headerForBtn setBackgroundImage:[UIImage imageNamed:@"settingHeader"] forState:UIControlStateNormal];
    
    [self.headerForBtn addTarget:self action:@selector(addHeaderView) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:self.headerForBtn];

    self.settingTableView.tableHeaderView = headerView;
}
- (void)addHeaderView{
    NSLog(@"hello");
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有摄像头
    if(![UIImagePickerController isSourceTypeAvailable:sourceType])
    {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;   // 设置委托
    imagePickerController.sourceType = sourceType;
    imagePickerController.allowsEditing = YES;
    [self presentViewController:imagePickerController animated:YES completion:nil];  //需要以模态的形式展示
}
#pragma mark UIImagePickerController Method
//完成拍照
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image == nil)
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self performSelector:@selector(saveImage:) withObject:image];
    
}
//用户取消拍照
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//将照片保存到disk上
-(void)saveImage:(UIImage *)image
{
    
    [self.headerForBtn setBackgroundImage:image forState:UIControlStateNormal];
    NSData *imageData = UIImagePNGRepresentation(image);
    if(imageData == nil)
    {
        imageData = UIImageJPEGRepresentation(image, 1.0); // 压缩一下比较好
    }
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    _fileName = [[formatter stringFromDate:date] stringByAppendingPathExtension:@"png"];
    
    NSURL *saveURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:_fileName];
    
    [imageData writeToURL:saveURL atomically:YES];
  
}
- (NSURL *)applicationDocumentsDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    
    return [NSURL URLWithString:docDir];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 28;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identified = @"SettingTableViewCell";
    SettingTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"SettingTableViewCell" owner:self options:nil]lastObject];
    if (!cell) {
        cell = [[SettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identified];
        
    }

    switch (indexPath.row) {
        case 0:
            cell.Sort.text = @"变速器类型";
            cell.number.text = @"变速箱描述";
            
            break;
        case 1:
            
            cell.Sort.text = self.locationDic[@"BSQLX"];
            cell.number.text = self.locationDic[@"BSQMS"];

            break;
        case 2:
            cell.Sort.text = @"厂家名称";
            cell.number.text = @"车型代码";
            break;
        case 3:
            cell.Sort.text = self.locationDic[@"CJMC"];
            cell.number.text = self.locationDic[@"CLDM"];
            
            break;
        case 4:
            cell.Sort.text = @"车辆类型";
            cell.number.text = @"车门数";
            break;
        case 5:
            cell.Sort.text = self.locationDic[@"CLLX"];
            cell.number.text = self.locationDic[@"CMS"];
            
            break;
        case 6:
            cell.Sort.text = @"上市年份";
            cell.number.text = @"上市月份";
            
            break;
        case 7:
            cell.Sort.text = self.locationDic[@"SSNF"];
            cell.number.text = self.locationDic[@"SSYF"];
            break;
            
        case 8:
            cell.Sort.text = @"车身形式";
            cell.number.text = @"车型";
            
            break;
        case 9:
            cell.Sort.text = self.locationDic[@"CSXS"];
            cell.number.text = self.locationDic[@"CX"];
            break;
            
        case 10:
            cell.Sort.text = @"车系";
            cell.number.text = @"档位数";
            
            break;
        case 11:
            cell.Sort.text = self.locationDic[@"CXI"];
            cell.number.text = self.locationDic[@"DWS"];
            break;
            
        case 12:
            cell.Sort.text = @"缸数";
            cell.number.text = @"发动机型号";
            
            break;
        case 13:
            cell.Sort.text = self.locationDic[@"FDJGS"];
            cell.number.text = self.locationDic[@"FDJXH"];
            break;
            
        case 14:
            cell.Sort.text = @"发动机型号";
            cell.number.text = @"发动机最大功率(kW)";
            
            break;
        case 15:
            cell.Sort.text = self.locationDic[@"FDJXH"];
            cell.number.text = self.locationDic[@"GL"];
            break;
            
        case 16:
            cell.Sort.text = @"车辆级别";
            cell.number.text = @"年款";
            
            break;
        case 17:
            cell.Sort.text = self.locationDic[@"JB"];
            cell.number.text = self.locationDic[@"NK"];
            break;
            
        case 18:
            cell.Sort.text = @"排放标准";
            cell.number.text = @"排量";
            
            break;
        case 19:
            cell.Sort.text = self.locationDic[@"PFBZ"];
            cell.number.text = self.locationDic[@"PL"];
            break;
            
        case 20:
            cell.Sort.text = @"品牌";
            cell.number.text = @"驱动方式";
            
            break;
        case 21:
            cell.Sort.text = self.locationDic[@"PP"];
            cell.number.text = self.locationDic[@"QDFS"];
            break;
            
        case 22:
            cell.Sort.text = @"燃油标号";
            cell.number.text = @"燃油类型";
            
            break;
        case 23:
            cell.Sort.text = self.locationDic[@"RYBH"];
            cell.number.text = self.locationDic[@"RYLX"];
            break;
            
        case 24:
            cell.Sort.text = @"生产年份";
            cell.number.text = @"停产年份";
            
            break;
        case 25:
            cell.Sort.text = self.locationDic[@"SCNF"];
            cell.number.text = self.locationDic[@"TCNF"];
            break;
            
        case 26:
            cell.Sort.text = @"指导价格";
            cell.number.text = @"座位数";
            
            break;
        case 27:
            cell.Sort.text = self.locationDic[@"ZDJG"];
            cell.number.text = self.locationDic[@"ZWS"];
            break;
            
        default:
            break;
    }
    return cell;
}

- (void)viewWillDisappear:(BOOL)animated{
    // 关闭数据库
    [self.dataBaseHandle close];
}


@end
