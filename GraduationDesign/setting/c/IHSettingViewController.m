//
//  IHSettingViewControllerViewController.m
//  GraduationDesign
//
//  Created by shupengstar on 16/5/13.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "IHSettingViewController.h"

@interface IHSettingViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSString *_fileName;
}
@property (weak, nonatomic) IBOutlet UITableView *settingTableView;
@property (nonatomic, strong) UIButton *headerForBtn;

@end

@implementation IHSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self headerView];
}
- (void)headerView{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];

    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    backImageView.image = [UIImage imageNamed:@"YellowBoy"];
    backImageView.alpha = 0.7;
    [headerView addSubview:backImageView];

    
    UIButton *headerBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width -100)/2.0, 50, 100, 100)];
    headerBtn.layer.cornerRadius = 50;
    headerBtn.layer.masksToBounds = YES;
    headerBtn.backgroundColor = [UIColor greenColor];
    [headerBtn addTarget:self action:@selector(addHeaderView) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:headerBtn];
    self.headerForBtn = headerBtn;

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
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [UITableViewCell new];
    return cell;
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
