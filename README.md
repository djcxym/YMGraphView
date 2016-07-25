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
