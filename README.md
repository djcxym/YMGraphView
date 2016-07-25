# YMGraphView
* 提供一种图表绘制view

##contents
* 使用
    * 将YMGraphView.h和YMGraphView.m文件拖入工程即可，在使用的地方#import "YMGraphView.h"
* API
   ```objc
   typedef NS_ENUM(NSInteger,YMGraphViewStyle)
{
    YMGraphViewStyleScatter,    //散点图
    YMGraphViewStylePie,        //饼状图
    YMGraphViewStyleHist,       //柱状图
    YMGraphViewStyleLine,       //单条折线图
    YMGraphViewStyleAnnular,    //环状图
    YMGraphViewStyleMultiLine   //多条折线图
};

@interface YMGraphView : UIView

/**
 * Init method,set drawing options
 *
 *
 * @param data     数据.
 * @param perferedStyle 类型（散点图，饼图，柱状图，折线图，环形，多条曲线），
          preferedStyle = YMGraphViewStyleMultiLine时，data格式为@[arr1,arr2,arr3...],arri为CGPoint数组，代表一条曲线。其余类型时数据应为CGPoint.
 */
- (instancetype)initWithFrame:(CGRect)frame data:(NSArray*)data preferedStyle:(YMGraphViewStyle)preferedStyle;
/**
 * 饼状图突出显示指定数据，仅对饼状图有效
 * @param index  突出显示的数据.
 */
- (void)setPieStickOutIndex:(NSInteger)index;

/**
 * 折线图是否显示网格，默认显示，仅对折线图有效
 * @param showGrid  YES显示，NO不显示.
 */
- (void)setShowGrid:(BOOL)showGrid;

/**
 * 折线图是否显示数据点，默认显示，仅对折线图有用
 * @param showPoint  YES显示，NO不显示.
 */
- (void)setShowPoint:(BOOL)showPoint;

+ (instancetype)drawFuncWithBlock:(CGFloat(^)(CGFloat))func from:(CGFloat)from to:(CGFloat)to withFrame:(CGRect)frame;

   ```
* Examples
    * 散点图
    
      ```objc
      NSMutableArray *scatterArr = [[NSMutableArray alloc]init];
      for (int i=0; i<200; i++) {
          CGFloat x = arc4random()%1000;
          CGFloat y = arc4random()%500;
          [scatterArr addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
      }
      YMGraphView *view = [[YMGraphView alloc]initWithFrame:_rect data:scatterArr preferedStyle:YMGraphViewStyleScatter];
      [self.view addSubview:view];
    
      ```
      ![(随机散点图))](https://github.com/djcxym/YMGraphView/blob/master/img/90C62EEE-6735-45CB-9C59-47922D7250A6.png)
      
    * 饼状图
    
      ```objc
      YMGraphView *view = [[YMGraphView alloc]initWithFrame:_rect data:@[@400,@300,@700,@400,@400,@600] preferedStyle:YMGraphViewStylePie];
      [self.view addSubview:view];
        
      ```
      ![(饼状图))](https://github.com/djcxym/YMGraphView/blob/master/img/5F8914C0-3D51-4A79-B946-1953044FD8D5.png)
  
      ```objc
      [view setPieStickOutIndex:3];
       
      ```
      ![(饼状图))](https://github.com/djcxym/YMGraphView/blob/master/img/8A6E3614-C9CC-4E7E-9C6C-B0947D28ED05.png)
      
    * 柱状图
    
      ```objc
      YMGraphView *view = [[YMGraphView alloc]initWithFrame:_rect data:@[@400,@300,@700,@400,@400,@600] preferedStyle:YMGraphViewStyleHist];
      [self.view addSubview:view];

      ```
      ![(柱状图))](https://github.com/djcxym/YMGraphView/blob/master/img/F235E17B-3933-4762-8D61-2B0B1DC961E0.png)
      
    * 折线图
    
      ```objc
      YMGraphView *view = [[YMGraphView alloc]initWithFrame:_rect
                        data:@[[NSValue valueWithCGPoint:CGPointMake(2, 200)],
                               [NSValue valueWithCGPoint:CGPointMake(-7, 900)],
                               [NSValue valueWithCGPoint:CGPointMake(-3, 700)],
                               [NSValue valueWithCGPoint:CGPointMake(8, 1700)],
                               [NSValue valueWithCGPoint:CGPointMake(1, 500)]]
                        preferedStyle:YMGraphViewStyleLine];
      [self.view addSubview:view];
      
      ```
      ![(折线图))](https://github.com/djcxym/YMGraphView/blob/master/img/C5DD5591-730C-4164-B13C-55B39C4AEC14.png)
    
    * 多条折线
    
      ```objc
      YMGraphView *view = [[YMGraphView alloc]initWithFrame:_rect
        data:@[@[[NSValue valueWithCGPoint:CGPointMake(2, 200)],
                 [NSValue valueWithCGPoint:CGPointMake(7, 900)],
                 [NSValue valueWithCGPoint:CGPointMake(3, 700)],
                 [NSValue valueWithCGPoint:CGPointMake(8, 1700)],
                 [NSValue valueWithCGPoint:CGPointMake(1, 500)]],
                @[[NSValue valueWithCGPoint:CGPointMake(3, 300)],
                 [NSValue valueWithCGPoint:CGPointMake(6, 1200)],
                 [NSValue valueWithCGPoint:CGPointMake(4, 800)],
                 [NSValue valueWithCGPoint:CGPointMake(9, 1500)],
                 [NSValue valueWithCGPoint:CGPointMake(2, 500)]],
                @[[NSValue valueWithCGPoint:CGPointMake(2, 400)],
                 [NSValue valueWithCGPoint:CGPointMake(6, 900)],
                 [NSValue valueWithCGPoint:CGPointMake(5, 400)],
                 [NSValue valueWithCGPoint:CGPointMake(10, 1000)],
                 [NSValue valueWithCGPoint:CGPointMake(1, 1200)]]]
        preferedStyle:YMGraphViewStyleMultiLine];
      [self.view addSubview:view];

      ```
      
      ![(折线图))](https://github.com/djcxym/YMGraphView/blob/master/img/3B0E2CAC-80DE-4BBF-BCFA-B12D96E02F35.png)
      
      ```objc
      [view setShowPoint:NO];
      [view setShowGrid:NO];
      
      ```
      
      ![(折线图))](https://github.com/djcxym/YMGraphView/blob/master/img/9279C3B3-9FA9-446B-88CE-7015F9AECEA0.png)
    
    * 函数
    
      ```objc
      YMGraphView *view = [YMGraphView drawFuncWithBlock:^(CGFloat x){
        return fabs(x) - fabs(x/2 + 1) - fabs(x/2 - 1) + (fabs(x/2 + 2) + fabs(x/2 - 2) - fabs(x/2 + 1) - fabs(x/2 - 1))*sin(5*M_PI*x);
      }from:-5 to:5 withFrame:_rect];
      [self.view addSubview:view];
    
      ```
      
      ![(函数图))](https://github.com/djcxym/YMGraphView/blob/master/img/E25274BF-D185-4E96-88EC-CFF362C3090B.png)
##License
  MIT
