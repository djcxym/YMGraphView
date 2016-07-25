//
//  ViewController.m
//  GraphDemo
//
//  Created by dengjc on 16/7/20.
//  Copyright © 2016年 dengjc. All rights reserved.
//

#import "ViewController.h"
#import "YMGraphView.h"
#import "GraphViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *data;

@property (nonatomic,strong) NSArray *style;

@property (nonatomic,strong) UITableView *tableView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    self.navigationItem.title = @"图表";
    _data = @[@"散点图",@"饼状图",@"柱状图",@"环状图",@"折线线",@"多条折线",@"函数"];
    _style = @[@(YMGraphViewStyleScatter),@(YMGraphViewStylePie),@(YMGraphViewStyleHist),@(YMGraphViewStyleAnnular),@(YMGraphViewStyleLine),@(YMGraphViewStyleMultiLine),@(-1)];
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = _data[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GraphViewController *graphVC = [[GraphViewController alloc]init];
    graphVC.style = (YMGraphViewStyle)[_style[indexPath.row] integerValue];
    [self.navigationController pushViewController:graphVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
