//
//  FineWayViewController.m
//  GraduationDesign
//
//  Created by shupengstar on 16/5/6.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "FineWayViewController.h"

@interface FineWayViewController ()
@property (nonatomic, strong) UITextView *textView;
@end

@implementation FineWayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 48)];
    self.textView.selectable = NO;
    self.textView.editable = NO;
    [self.view addSubview:self.textView];
    self.textView.text = @"处罚标准\n1、醉酒驾驶机动车\n对醉酒后驾驶机动车的，一律处1 5 日拘留，暂扣6 个月机动车驾驶证，并处1000元罚款。对醉酒后驾驶营运机动车的，一律处1 5 日拘留，暂扣6 个月机动车驾驶证，并处2000元罚款。\n2、饮酒后驾驶\n机动车：对饮酒后驾驶机动车的，一律处暂扣3 个月机动车驾驶证，并处300元罚款。对饮酒后驾驶营运机动车的，一律处暂扣3 个月机动车驾驶证，并处500元罚款。\n3、超载或超员\n对公路客运车辆载客超过额定乘员尚未达到20% 或货运机动车超过核定载质量尚未达到30% 的，一律处500元罚款。对公路客运超过额定乘员20% 的或货运机动车超过核定载质量3 0 % 的，一律处2000元罚款。\n4、超速\n对机动车行驶时超过最高限定50% 的，一律处1000元罚款，并处吊销机动车驾驶证。\n5、无证驾驶\n对机动车驾驶人驾驶证被暂扣期间继续驾车的，一律处500元罚款，并处15日拘留。对未取得机动车驾驶证、机动车驾驶证被吊销驾驶机动车的，一律处15日拘留，并处200元罚款。\n6、驾驶拼装或报废机动车\n对上道路行驶的拼装、改装或者应该报废的机动车一律予以收缴，强制报废。对驾驶前款所列机动车上道路行驶的驾驶人，一律处1500元罚款，并吊销机动车驾驶证。\n7、使用伪造驾驶证\n对伪造、变造或者使用伪造、变造的机动车登记证书、号牌、行驶证、检验合格标志、保险标志、驾驶证或者使用其它车辆的机动车登记证书、号牌、行驶证、检验合格标志、保险标志的，一律处2000元罚款。\n8、记满12分继续驾车\n对机动车驾驶人记满12分继续驾车的一律处800元罚款。\n9、发生重大交通事故构成犯罪\n依法追究刑事责任，一律吊销机动车驾驶证。\n10、肇事后逃逸\n一律吊销机动车驾驶证，终生不得重新取得机动车驾驶证。\n11、不给急救车让道扣3分\n 2013年1月1日起式实施的《机动车驾驶证申领和使用规定》，把不让行急救车纳入扣分细则中。其明确规定：驾驶机动车不按规定超车、让行的，或逆向行驶的，一次记3分。\n12、无牌照车违章停车双重处罚扣6分罚200\n对于司机摘号牌逃避违法停车处罚的情况，交警将通过记录和拍下车架号来开罚单，还会进行双重处罚。\n13、公安部修订的《机动车驾驶证申领和使用规定》（123号令）下的交通违章处罚\n 随着元旦的临近，公安部修订的《机动车驾驶证申领和使用规定》（123号令）又一次引发市民的关注。市交警支队有关负责人解读了这一被戏称为“史上最严”的交规。\n 闯红灯一次记6分。\n扣分，是新交规的重要关键词。从元旦起，一次记12分的有未悬挂或不按规定安装号牌、故意遮挡或污损号牌、驾驶与准驾车型不符的机动车等11项违法行为，比原来多了5项。驾驶机动车违反道路交通信号灯通行、在高速公路或城市快速路上违法占用应急车道行驶等14项违法行为一次记6分，也比原来多了5项。\n从中可以看出，新交规将重点打击超速、超载、闯红灯、高速公路违法停车、违法占道以及无牌、遮牌等涉牌违法行为，而这些都属于容易引发交通事故或严重妨碍交通秩序管理的违法行为。\n 用旧驾照最高罚200元\n机动车驾驶人补领机动车驾驶证后，继续使用原机动车驾驶证的，处二十元以上二百元以下罚款；在实习期内驾驶机动车不符合第六十五条规定的，处二十元以上二百元以下罚款；驾驶机动车未按规定粘贴、悬挂实习标志或者残疾人机动车专用标志的，处二十元以上二百元以下罚款；持有大型客车、牵引车、城市公交车、中型客车、大型货车驾驶证的驾驶人，未按照规定申报变更信息的，处二十元以上二百元以下罚款；机动车驾驶证被依法扣押、扣留或者暂扣期间，采用隐瞒、欺骗手段补领机动车驾驶证的，处二百元以上五百元以下罚款；机动车驾驶人身体条件发生变化不适合驾驶机动车，仍驾驶机动车的，处二百元以上五百元以下罚款；逾期不参加审验仍驾驶机动车的，处二百元以上五百元以下罚款。\n市交警支队表示，这些变化，凸显了机动车驾驶人的法律责任，强调了驾驶机动车上路的严肃性。";
    
    
    
    
    
    
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
