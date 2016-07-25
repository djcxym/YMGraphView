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

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIViewControllerAnimatedTransitioning,UINavigationControllerDelegate>

@property (nonatomic,strong) NSArray *data;

@property (nonatomic,strong) NSArray *style;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    self.navigationItem.title = @"图表";
    self.navigationController.delegate = self;
//    _data = @[@"散点图",@"饼状图",@"柱状图",@"环状图",@"折线线",@"多条折线",@"函数"];
    _style = @[@(YMGraphViewStyleScatter),@(YMGraphViewStylePie),@(YMGraphViewStyleHist),@(YMGraphViewStyleAnnular),@(YMGraphViewStyleLine),@(YMGraphViewStyleMultiLine),@(-1)];
//    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
//    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
//    _tableView.dataSource = self;
//    _tableView.delegate = self;
//    [self.view addSubview:_tableView];
    
    UIPanGestureRecognizer * panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self.view addGestureRecognizer:panGes];
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

- (id<UIViewControllerAnimatedTransitioning>)
navigationController:(UINavigationController *)navigationController
animationControllerForOperation:(UINavigationControllerOperation)operation
fromViewController:(UIViewController*)fromVC
toViewController:(UIViewController*)toVC
{
//    if (operation == UINavigationControllerOperationPush) {
//        return self;
//    }
//    return nil;
    return self;
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController*)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>)animationController
{
    return self.interactivePopTransition;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 1;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [[transitionContext containerView] addSubview:toViewController.view];
    toViewController.view.transform = CGAffineTransformMakeTranslation(320, 0);
//    toViewController.view.transform = CGAffineTransformMakeScale(1, 1);
    fromViewController.view.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromViewController.view.transform = CGAffineTransformMakeTranslation(-320, 0);
        toViewController.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        fromViewController.view.transform = CGAffineTransformIdentity;
        toViewController.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];
}

- (void)panGesture:(UIPanGestureRecognizer *)gesture {
    CGFloat xOff = [gesture translationInView:self.view].x;
    CGFloat percent = fabs(xOff)/self.view.frame.size.width;
    CGPoint location = [gesture locationInView:self.view];
    if (gesture.state == UIGestureRecognizerStateBegan) {
        if (location.x >  CGRectGetMidX(self.view.bounds)) {
            self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
            GraphViewController *graphVC = [[GraphViewController alloc]init];
            graphVC.style = (YMGraphViewStyle)[_style[0] integerValue];
            [self.navigationController pushViewController:graphVC animated:YES];
        }
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        CGFloat d = (xOff / CGRectGetWidth(self.view.bounds)) * -1;
        [self.interactivePopTransition updateInteractiveTransition:d];
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        if ([gesture velocityInView:self.view].x < 0) {
            [self.interactivePopTransition finishInteractiveTransition];
        } else {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        self.interactivePopTransition = nil;
    }
}


@end
