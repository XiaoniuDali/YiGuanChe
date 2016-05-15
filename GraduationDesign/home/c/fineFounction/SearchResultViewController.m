//
//  SearchResultViewController.m
//  GraduationDesign
//
//  Created by shupengstar on 16/4/4.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import "SearchResultViewController.h"
#import "fineDetailTableViewCell.h"
#import "SearchFineModel.h"
@interface SearchResultViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *resultTableView;

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.resultTableView.estimatedRowHeight = 100;
    self.resultTableView.rowHeight = UITableViewAutomaticDimension;
    self.resultTableView.tableFooterView = [UIView new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.resultArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    fineDetailTableViewCell *fineDetailCell = [tableView dequeueReusableCellWithIdentifier:@"fineDetailCell"];
    if (!fineDetailCell) {
        fineDetailCell = [[[NSBundle mainBundle] loadNibNamed:@"fineDetailTableViewCell" owner:self options:nil] lastObject];
 
    }
    
    [fineDetailCell setTheModel:self.resultArray[indexPath.row]];
    
    return fineDetailCell;
}



@end
