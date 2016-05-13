//
//  IHNewsViewController.m
//  IHGP
//
//  Created by 谢伟成 on 16/1/11.
//  Copyright (c) 2016年 谢伟成. All rights reserved.
//








#import "appMarco.h"
#import "IHNewsViewController.h"
#import "NewsViewController.h"

@interface IHNewsViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak) UITableView *tableView;
@property(strong, nonatomic) UISearchController *searchController;
@property (nonatomic,strong) NSMutableDictionary * dataDict;
@property (nonatomic,strong) NSMutableArray * dictKeys;



@end

@implementation IHNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"nameHtml" ofType:@"plist"];
    self.dataDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    
    self.dictKeys =(NSMutableArray *)[self.dataDict allKeys];
    
    
    IanLog(@"self.dictKeysself.dictKeys====%@%ld",self.dictKeys,self.dictKeys.count);
 
 
    [self setSubviews];

}

-(void)setSubviews
{
 
    UITableView *tableView =[[UITableView alloc] init];
    [tableView setFrame:CGRectMake(0, 0, self.view.width, self.view.height-48)];
    tableView.delegate =self;
    tableView.dataSource =self;
    [self.view addSubview:tableView];
    self.tableView =tableView;
    
 
}

#pragma -mark uitabledelegate的方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataDict.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    NewsViewController * newsVC =[[NewsViewController alloc] init];
    newsVC.htmlName = self.dictKeys[indexPath.row];
    
    [self.navigationController pushViewController:newsVC animated:YES];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text =[self.dataDict objectForKey:[self.dictKeys objectAtIndex:indexPath.row]];
    [cell setBackgroundColor:ianRGBColor(231, 231,231)];
    [cell.textLabel setFont:[UIFont systemFontOfSize:13]];
    
    return cell;
}



@end



/*
 ABSGuZhangZengDuan.html                 ABS的故障诊断
 bianBieJiaPeiJian.html                  如何鉴别假冒伪劣汽车配件
 biZhengQiShiFouZhengChang.html          怎么检查避震器是否正常
 changJianXiaoGuZhangChaXun.html         红旗轿车故障排除5例
 cheLiangLouYouZenMeBan.html             汽车漏油怎么办？
 cheLiangLouYu.html                      漏水对策
 coldStart.html                          冷车启动困难是什么问题
 congLunTaiMoShunQingKuangPanDuan.html   判断轮胎磨损情况
 dianChiDianJieYeXiaoHaoGuoKuai.html     蓄电池电解液消耗过快怎么办
 dianChiShouZhongGaiRuHe.html            电池寿终该如何
 enginTooHot.html                        发动机过热
 faDongJiGuoReZenMeBan.html              发动机过热时的应急处理方法
 faDongJiWeiHeZongRongYiZhaoHuo.html     发动机为何总易熄火
 fangXiangPanBianBieGuZhang.html         方向盘上辨故障
 jiaoCheFangDaoQi.html                   轿车防盗器失灵检修
 JiaRuQiCheZhaoHuoZenMeBan.html          假如汽车着火怎么办
 lieZhiRanYouHuiSanYuanQiJian.html       劣质燃油毁坏三元催化器
 liHeQioZengDuan.html                     离合器故障的诊断
 qiCheAnQuanQiNang.html                   汽车安全气囊的检修
 qiCheKongTiaoSiZhongChangJianGuZhang.html  汽车空调四种常见故障检修
 qiCheXiaoYinXiangGuZhangQianXi.html       汽车消音器故障浅析
 qiCheYiBiaoPanJianJieJiGuZhangPaiChu.html   汽车常用仪表简介及故障排除
 qingQingSongSong.html                     轻轻松松换轮胎
 queBaoCheTaiAnQuan.html                  确保车胎安全
 sanRiQiJinShui.html                      散热器进水软管破裂怎么办
 shengQianXiuChe.html                     省钱修车方法
 shouDongBianSuXiangXingNeng.html         如何检查手动变速箱性能
 theReasonOfBreakdown.html                汽车高速断火的几点原因
 tongGuoJiaoGanPanDuanYeYaZhiDong.html    通过"脚感"来判断液压制动系统的故障
 waterHeartIsNormal.html                  水温不正常了怎么办
 weiXingQiCheZhiDongChangJianWenTi.html   微型汽车制动系统常见故障检修
 xingCheTuZhongDianQiTuFaGuZhangYingJiFangFa.html    行车途中电器突发故障的应急办法
 yeYaZhiDongXiaoNengBuLiang.html          液压制动效能不良的故障诊断
 zengDuanDianChiGuZhangDeJianBianFangFa.html   诊断蓄电池故障的简便方法
 zenYanTiaoZhengCheMen.html               怎样调整车门
 zhiDongJinBaoRuHeJianCha.html            制动器鸣响如何检查
 ziJiDongShouJieJueCheDeng.html           自己动手解决车灯暗淡
 ziJiDongShouJieJueCheDengWenTi.html      自己动手解决车灯暗淡
 */
