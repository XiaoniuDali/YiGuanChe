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
                                   [resultSet stringForColumn:@"telephone"],@"telephone",
                                   [resultSet stringForColumn:@"brand"],@"brand",
                                   [resultSet stringForColumn:@"name"],@"name",
                                   [resultSet stringForColumn:@"displacement"],@"displacement",
                                   [resultSet stringForColumn:@"type"],@"type",
                                   [resultSet stringForColumn:@"carLong"],@"carLong",
                                   [resultSet stringForColumn:@"carHigh"],@"carHigh",
                                   [resultSet stringForColumn:@"carWidth"],@"carWidth",nil];
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
    return 8;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identified = @"SettingTableViewCell";
    SettingTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"SettingTableViewCell" owner:self options:nil]lastObject];
    if (!cell) {
        cell = [[SettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identified];
        
    }

    switch (indexPath.row) {
        case 0:
            cell.Sort.text = @"品牌：";
            cell.number.text = @"名称：";
            
            break;
        case 1:
            
//            cell.Sort.text = self.locationDic[@"brand"];
//            cell.number.text = self.locationDic[@"name"];
            
            cell.Sort.text = @"品牌";
            cell.number.text = @"名称";
            break;
        case 2:
            cell.Sort.text = @"排量：";
            cell.number.text = @"产品类型：";
            break;
        case 3:
            cell.Sort.text = @"displacement";
            cell.number.text = @"type";
//            cell.Sort.text = self.locationDic[@"displacement"];
//            cell.number.text = self.locationDic[@"type"];
            
            break;
        case 4:
            cell.Sort.text = @"车长：";
            cell.number.text = @"车高：";
            break;
        case 5:
            cell.Sort.text = self.locationDic[@"carLong"];
            cell.number.text = self.locationDic[@"carHigh"];
            cell.Sort.text = @"carLong";
            cell.number.text = @"carHigh";
            
            break;
        case 6:
            cell.Sort.text = @"车宽：";
            
            break;
        case 7:
            cell.Sort.text = self.locationDic[@"carWidth"];
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
