//
//  WhatICanDoViewController.m
//  GraduationDesign
//
//  Created by shupengstar on 16/5/6.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "WhatICanDoViewController.h"

@interface WhatICanDoViewController ()
@property (nonatomic, strong) UITextView *textView;

@end

@implementation WhatICanDoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 48)];
    self.textView.selectable = NO;
    self.textView.editable = NO;
    [self.view addSubview:self.textView];
    self.textView.text = @"交通违章处理程序\n一般程序的情形是：依照法律、法规对违法行为人作出200元(不含本数)以上罚款、暂扣或者吊销驾驶证、对单位处以罚款的，应当进行调查，收集证据，并按照一般程序作出处罚决定。\n交通违章处罚一般程序：调查取证，告知处罚事情、理由、依据和有关权利，听取陈述、申辩或者举行听证，作出处罚决定。\n1、交通警察在现场对个人处以200元以下罚款，可以当场作出处罚决定;\n2、交通警察在非现场，根据交通技术监控记录资料，对违法的机动车所有人、管理人或者驾驶人处200元以下罚款的，可以适用简易程序作出处罚决定。\n所以，采用简易程序的都是处以200元以下的罚款的违法行为，根据《道路交通处理程序规定》具有一年以上道路交通管理工作经历的交通警察，经设区的市公安机关交通管理部门培训考试合格的，才可以处理适用简易程序的交通事故。\n罚款缴纳\n1．持《交通违法行为处罚决定书》（如有暂扣证件的还须携带《交通管理暂扣凭证》），按规定到银行缴纳罚款，当地各银行都可交违章罚款，通过自助交电话费的POS机即可。\n说明：网上查到违章记录后，可以等交警局将《交通违法行为处罚决定书》寄给你，也可以自己去各交警大队或交通监控中心领取。\n 2．持《违反交通管理罚款收据》、《交通违法行为处罚决定书》（如有暂扣证件的还须携带《交通管理暂扣凭证》）及当事人的驾驶证、行驶证到处罚决定交警大队接受处理。\n3． 如违例项目需要吊扣驾驶证的还须按规定吊扣，吊扣驾驶证期满后凭《吊扣驾驶证执行凭证》取回驾驶证。\n4.如是持深圳驾驶证的司机，违章不需吊扣证的，只需直接到各银行缴纳罚款即可。\n异地违章\n处理汽车异地违章主要有2种办法：\n方法一，本人到当地交通管理部门接受处罚，因各地的处罚方式不同，请注意携带驾驶证和行驶证或复印件。\n特点：手续繁琐、过程复杂。\n方法二，通过异地朋友代办，如果违章当地有朋友的话，可以直接把将违章通知单、驾驶证、行驶证、身份证等证件的原件或复印件递送给你的朋友，请朋友代劳办理。\n特点：一劳永逸，可节省不必要的舟车劳顿，但由于某些省市交管部门不接受他人代办，仍需驾驶员本人办理。\n如果车主对违章处罚不认同可通过法律诉讼提出申诉。交通违法当事人如有不服，应在收到异地处罚决定书之日起60日内，向违法行为发生地公安交警大队上级机关申请行政复议，或在3个月内向违法行为发生地人民法院提起行政诉讼。";

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
