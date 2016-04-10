//
//  IanMainViewController.m
//  IHGP
//
//  Created by 谢伟成 on 16/1/15.
//  Copyright (c) 2016年 谢伟成. All rights reserved.
//

#import "IanMainViewController.h"
#import "IanNoteRepairController.h"
#import "appMarco.h"
#import "SearchFineViewController.h"
#define UISCREENHEIGHT  self.view.bounds.size.height
#define UISCREENWIDTH  self.view.bounds.size.width

#import "AdScrollView.h"
#import "AdDataModel.h"
#import "vinModel.h"
#define ID @"cell"

@interface IanMainViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,weak) UICollectionView *collectionView;

@end

@implementation IanMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self createScrollView];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setItemSize:CGSizeMake(100, 100)];//设置cell的尺寸
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];//设置其布局方向
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 15, 15, 10);//设置其边界
    //其布局很有意思，当你的cell设置大小后，一行多少个cell，由cell的宽度决定
    
    UICollectionView *collectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0,214, self.view.bounds.size.width, self.view.bounds.size.height-48-125) collectionViewLayout:flowLayout] ;
    
    //    UIImageView *imageView =[[UIImageView alloc] init];
    //    [imageView setBackgroundColor:[UIColor redColor]];//ianRGBColor(59, 86, 129)//图片
    //    [imageView setFrame:collectionView.bounds];
    //    [collectionView setBackgroundView:imageView];
    //
    
    collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [collectionView registerClass :[UICollectionViewCell class] forCellWithReuseIdentifier : ID];
    
    collectionView.delegate =self;
    collectionView.dataSource =self;
    
    [self.view addSubview:collectionView];
    self.collectionView =collectionView;
    
}
#pragma mark - 构建广告滚动视图
- (void)createScrollView
{
    AdScrollView * scrollView = [[AdScrollView alloc]initWithFrame:CGRectMake(0, 64, UISCREENWIDTH, 150)];
    AdDataModel * dataModel = [AdDataModel adDataModelWithImageNameAndAdTitleArray];
    //如果滚动视图的父视图由导航控制器控制,必须要设置该属性(ps,猜测这是为了正常显示,导航控制器内部设置了UIEdgeInsetsMake(64, 0, 0, 0))
    scrollView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    
    NSLog(@"%@",dataModel.adTitleArray);
    scrollView.imageNameArray = dataModel.imageNameArray;
    scrollView.PageControlShowStyle = UIPageControlShowStyleRight;
    scrollView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
    [scrollView setAdTitleArray:dataModel.adTitleArray withShowStyle:AdTitleShowStyleLeft];
    
    scrollView.pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
    [self.view addSubview:scrollView];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 7;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    
    
    //    IanLog(@"asdasd");
    switch (indexPath.row) {
        case 0:
            cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fineICON"]];
            break;
            
        case 1:
            cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"repair.png"]];
            
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
            
            break;
        case 6:
            
            break;
            
        default:
            break;
            
    }
    
    
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"select  select ");
    
    
    
    
    switch (indexPath.row) {
        case 0:
        {
            SearchFineViewController *searchFine = [SearchFineViewController new];
            [self.navigationController pushViewController:searchFine animated:YES];
            break;
            
        }
            
        case 1:
        {
            NSLog(@"纪录汽车保养、维修项目的时间、地点、价格");
            IanNoteRepairController *noteVC =[[IanNoteRepairController alloc] init];
            self.hidesBottomBarWhenPushed=YES;
            //                navgationC    释放出栈的视图控制器
            [self.navigationController pushViewController:noteVC animated:YES];
            self.hidesBottomBarWhenPushed=NO;
            
            break;
            
        }
        case 2:
        {
            
            
            break;
        }
        case 3:
        {
            
            break;
        }
        case 4:
        {
            
            break;
        }
        case 5:
        {
            
            break;
        }
        case 6:
        {
            
            break;
        }
            
        default:
            break;
    }    
}




@end
