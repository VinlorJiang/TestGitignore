//
//  ViewController.m
//  PageNavigation_Test
//
//  Created by apple on 2017/5/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "TitleView.h"
#import "WLPageView.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kNavH 64
#define kTitleViewH 40

@interface ViewController ()

@property (nonatomic, strong) TitleView *titleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.titleView];
//    [self createUI];
}

- (TitleView *)titleView {
    if (!_titleView) {
        CGFloat titleViewX = 0;
        CGFloat titleViewY = kNavH;
        CGFloat titleViewW = kScreenW;
        CGFloat titleViewH = kTitleViewH;
        _titleView = [[TitleView alloc] initWithFrame:CGRectMake(titleViewX, titleViewY, titleViewW, titleViewH)];
        
    }
    return _titleView;
}
- (void)createUI {
    NSMutableArray *viewArr = [NSMutableArray array];
    
    NSArray *colorArr = @[[UIColor redColor],[UIColor greenColor],[UIColor blackColor],[UIColor blueColor],[UIColor orangeColor],[UIColor yellowColor],[UIColor purpleColor]];
    NSArray *titleArr = @[@"香蕉",@"大苹果",@"小樱桃",@"橘子",@"pich",@"大鸭梨",@"第四点"];
    for (int i = 0; i < titleArr.count; i++) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = colorArr[i];
        [viewArr addObject:view];
    }
    WLPageView *view = [[WLPageView alloc] initWithFrame:CGRectMake(0, 20, kScreenW, 44) viewArray:viewArr titleArray:titleArr lineHeight:2];
    
    [self.view addSubview:view];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
@end
