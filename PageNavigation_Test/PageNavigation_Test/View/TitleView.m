//
//  TitleView.m
//  PageNavigation_Test
//
//  Created by apple on 2017/6/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TitleView.h"

#define kPadding 15.0

@interface TitleView ()


@property (nonatomic, strong) UIScrollView *scrollView;

/** 滚动线 */
@property (nonatomic, strong) UIImageView *lineIamgeView;

@property (nonatomic, assign) CGFloat lineHieght;
@end

@implementation TitleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
     //   self.backgroundColor = [UIColor purpleColor];
        self.lineHieght = 2.0;
        [self createSubView];
    }
    return self;
}
- (void)createSubView {
    [self addSubview:self.scrollView];
    self.scrollView.frame = self.bounds;
    
    [self.scrollView addSubview:self.lineIamgeView];
 
    NSMutableArray *mutArray;
    NSInteger offSet = 0;
    for (int i = 0; i < self.titleLabel.count; i++) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = self.titleLabel[i];
        titleLabel.tag = 111 +i;
        titleLabel.font = [UIFont systemFontOfSize:15.0];
        titleLabel.textColor = [UIColor colorWithRed:85.0 green:85.1 blue:85.2 alpha:1];
        
        CGSize size = [self sizeWithWidth:[UIScreen mainScreen].bounds.size.width systemFontOfSize:15.0 content:self.titleLabel[i]];
        float originX = i ? (kPadding *2 + offSet) : kPadding;
        titleLabel.frame = CGRectMake(originX, 0, size.width, self.frame.size.height - self.lineHieght);
        offSet = CGRectGetMaxX(titleLabel.frame);
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.scrollView addSubview:titleLabel];
        [mutArray addObject:titleLabel];
    }
    self.scrollView.contentSize = CGSizeMake(offSet+kPadding, self.frame.size.height);
}
#pragma mark - lazyload
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.alwaysBounceVertical = YES;
        _scrollView.alwaysBounceHorizontal = NO;
        _scrollView.scrollsToTop = NO;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}
- (NSArray *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = @[@"香蕉",@"大苹果",@"小樱桃",@"橘子",@"pich",@"大鸭梨",@"第四点"];
    }
    return _titleLabel;
}
- (CGSize)sizeWithWidth:(CGFloat)width systemFontOfSize:(CGFloat)fontSize content:(NSString *)content {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = content;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.numberOfLines = 0;
    [label sizeToFit];
    CGSize size = label.frame.size;
    return size;
}
- (UIImageView *)lineIamgeView {
    if (!_lineIamgeView) {
        _lineIamgeView = [[UIImageView alloc] init];
        _lineIamgeView.image = [UIImage imageNamed:@"nar_bgbg"];
    }
    return _lineIamgeView;
}
@end
