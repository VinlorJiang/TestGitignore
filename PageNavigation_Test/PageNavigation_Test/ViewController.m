//
//  ViewController.m
//  PageNavigation_Test
//
//  Created by apple on 2017/5/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "TitleView.h"

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


@end
