//
//  TitleView.m
//  PageNavigation_Test
//
//  Created by apple on 2017/6/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TitleView.h"

@interface TitleView ()

@property (nonatomic, strong) UIScrollView *scrollView;
/** 底线 */
@property (nonatomic, strong) UIView *bottomView;
/** 滚动线 */
@property (nonatomic) UIScrollView *scrollLine;


@end

@implementation TitleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
     //   self.backgroundColor = [UIColor purpleColor];
        [self createSubView];
    }
    return self;
}
- (void)createSubView {
    [self addSubview:self.scrollView];
    [self addSubview:self.bottomView];
    [self addSubview:self.scrollLine];
    
    self.scrollView.frame = self.bounds;
    
    CGFloat bottomViewX = 0;
    CGFloat bottomViewY = CGRectGetMaxY(self.scrollView.frame) - 0.5;
    CGFloat bottomViewW = self.bounds.size.width;
    CGFloat bottomViewH = 0.5;

    self.bottomView.frame = CGRectMake(bottomViewX, bottomViewY, bottomViewW, bottomViewH);
   
    CGFloat labelY = CGRectGetMinY(self.scrollView.frame);
    CGFloat labelW = self.bounds.size.width / self.titleLabel.count;
    CGFloat labelH = self.scrollView.frame.size.height-2;
    NSMutableArray *mutArray;
    for (int i = 0; i < self.titleLabel.count; i++) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = self.titleLabel[i];
        titleLabel.tag = i;
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor colorWithRed:85.0 green:85.1 blue:85.2 alpha:1];
        
        titleLabel.frame = CGRectMake(labelW * i, labelY, labelW, labelH);
        [self addSubview:titleLabel];
        [mutArray addObject:titleLabel];
    }
    UILabel *firstLabel = mutArray[0];
    CGFloat scrollLineX = CGRectGetMinX(firstLabel.frame);
    CGFloat scrollLineY = labelH;
    CGFloat scrollLineW = labelW;
    CGFloat scrollLineH = 2;

    self.scrollLine.frame = CGRectMake(scrollLineX, scrollLineY, scrollLineW, scrollLineH);
}
#pragma mark - lazyload
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor orangeColor];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}
- (NSArray *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = @[@"新闻",@"热点",@"娱乐",@"教育"];
    }
    return _titleLabel;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor lightGrayColor];
    }
    return _bottomView;
}
- (UIScrollView *)scrollLine {
    if (!_scrollLine) {
        _scrollLine = [[UIScrollView alloc] init];
        _scrollLine.backgroundColor = [UIColor redColor];
    }
    return _scrollLine;
}
@end
