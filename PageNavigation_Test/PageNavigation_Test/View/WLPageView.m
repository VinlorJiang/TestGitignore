//
//  WLPageView.m
//  PageNavigation_Test
//
//  Created by dinpay on 2017/6/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WLPageView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kPadding 15.0
@interface WLPageView ()<UIScrollViewDelegate>
/** 标题数组 */
@property (nonatomic, strong) NSArray *titleArray;
/** 视图数组 */
@property (nonatomic, strong) NSArray *viewArray;
/** 顶部滚动视图 */
@property (nonatomic, strong) UIScrollView *topScrollView;
/** 底部滚动视图 */
@property (nonatomic, strong) UIScrollView *bottomscrollView;
/** 按钮下面的线条 */
@property (nonatomic, strong) UIImageView *lineImageView;
/** 当前按钮 */
@property (nonatomic, strong) UIButton *currentBtn;
/** 线条高度 */
@property (nonatomic, assign) CGFloat lineHeight;
/** 当前页 */
@property (nonatomic, assign) NSInteger currentPage;
@end


@implementation WLPageView

- (instancetype)initWithFrame:(CGRect)frame viewArray:(NSArray<UIView *> *)viewArray titleArray:(NSArray<NSString *> *)titleArray lineHeight:(CGFloat)lineHeight {
    self = [super initWithFrame:frame];
    if (self) {
        self.viewArray = [NSArray arrayWithArray:viewArray];
        self.titleArray = [NSArray arrayWithArray:titleArray];
        self.lineHeight = lineHeight;
        [self addSubview:self.topScrollView];
    }
    return self;
}
- (UIScrollView *)topScrollView {
    if (!_topScrollView) {
        _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.frame.size.height)];
        _topScrollView.showsVerticalScrollIndicator = NO;
        _topScrollView.showsHorizontalScrollIndicator = NO;
        _topScrollView.alwaysBounceVertical = YES;
        _topScrollView.alwaysBounceHorizontal = NO;
        _topScrollView.bounces = NO;
        _topScrollView.backgroundColor = [UIColor whiteColor];
        [_topScrollView addSubview:self.lineImageView];
        NSInteger btnOffset = 0;
        for (int i = 0; i < self.titleArray.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:self.titleArray[i] forState:UIControlStateNormal];
            if (self.titleNomalColor) {
                [btn setTitleColor:self.titleNomalColor forState:UIControlStateNormal];
            } else {
                [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            }
            if (self.titleSelectedColor) {
                [btn setTitleColor:self.titleSelectedColor forState:UIControlStateSelected];
            } else {
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            }
            btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
            CGSize size = [self sizeOfLabelWithCustomMaxWidth:kScreenWidth systemOfSize:14.0 filledTextString:self.titleArray[i]];
            float originX = i? (kPadding *2+btnOffset):kPadding;
            btn.frame = CGRectMake(originX, 0, size.width, self.frame.size.height - self.lineHeight);
            btnOffset = CGRectGetMaxX(btn.frame);
            btn.titleLabel.textAlignment = NSTextAlignmentLeft;
            [btn addTarget:self action:@selector(changeSelectItem:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 111 + i;
            [_topScrollView addSubview:btn];
            
            if (i == 0) {
                self.currentBtn = btn;
                btn.selected = YES;
                self.lineImageView.frame = CGRectMake(kPadding, self.frame.size.height-self.lineHeight, btn.frame.size.width, self.lineHeight);
            }
            
            UIView *view;
            if (self.viewArray) {
                view = self.viewArray[i];
            }
            view.frame = CGRectMake(i * kScreenWidth, 0, kScreenWidth, kScreenHeight-self.frame.origin.y-_topScrollView.frame.size.height);
            [self.bottomscrollView addSubview:view];
        }
        _topScrollView.contentSize = CGSizeMake(btnOffset+kPadding, self.frame.size.height);
    }
    return _topScrollView;
}
- (UIScrollView *)bottomscrollView {
    if (!_bottomscrollView) {
        _bottomscrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.frame.origin.y+self.topScrollView.frame.size.height, kScreenWidth, kScreenHeight-self.frame.origin.y+self.topScrollView.frame.size.height)];
        _bottomscrollView.contentSize = CGSizeMake(kScreenWidth * self.titleArray.count, kScreenHeight-self.frame.origin.y + self.topScrollView.frame.size.height);
        _bottomscrollView.showsVerticalScrollIndicator = NO;
        _bottomscrollView.showsHorizontalScrollIndicator = NO;
        _bottomscrollView.alwaysBounceVertical = YES;
        _bottomscrollView.alwaysBounceHorizontal = NO;
        _bottomscrollView.bounces = NO;
        _bottomscrollView.pagingEnabled = YES;
        _bottomscrollView.delegate = self;
        _bottomscrollView.backgroundColor = [UIColor whiteColor];
        [[self currentViewController].view addSubview:_bottomscrollView];
        

    }
    return _bottomscrollView;
}
- (UIViewController *)currentViewController {
    UIViewController *vc = [[UIApplication sharedApplication].windows firstObject].rootViewController;
    while (vc.presentedViewController) {
        vc = vc.presentedViewController;
    }
    return vc;
}
- (CGSize)sizeOfLabelWithCustomMaxWidth:(CGFloat)width systemOfSize:(CGFloat)fontSize filledTextString:(NSString *)string {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = string;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:fontSize];
    [label sizeToFit];
    CGSize size = label.frame.size;
    return size;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int index = scrollView.contentOffset.x / kScreenWidth;
    UIButton *currentButton = [self viewWithTag:111+index];
    self.currentBtn.selected = NO;
    currentButton.selected = YES;
    self.currentBtn = currentButton;
    [UIView animateWithDuration:0.3 animations:^{
        if (index == 0) {
            self.lineImageView.frame = CGRectMake(kPadding, self.frame.size.width- self.lineHeight, currentButton.frame.size.width, self.lineHeight);
            
        } else {
            float offSetX = CGRectGetMinX(currentButton.frame);
            if (offSetX < kScreenWidth / 2) {
                self.topScrollView.contentOffset = CGPointMake(0, 0);
            } else if (offSetX >= kScreenWidth /2 && offSetX <= self.topScrollView.contentSize.width - kScreenWidth/2) {
                self.topScrollView.contentOffset = CGPointMake(offSetX-kScreenWidth/2+kPadding, 0);
                
            } else {
                self.topScrollView.contentOffset = CGPointMake(self.topScrollView.contentSize.width - kScreenWidth, 0);
            }
            self.lineImageView.frame = CGRectMake(CGRectGetMinX(currentButton.frame), self.frame.size.height-self.lineHeight, currentButton.frame.size.width, self.lineHeight);
        }
    }];
    
}

- (void)changeSelectItem:(UIButton *)btn {
    self.currentBtn.selected = NO;
    btn.selected = YES;
    self.currentBtn = btn;
    NSInteger flag = btn.tag - 111;
    self.bottomscrollView.contentOffset = CGPointMake(flag * kScreenWidth, 0);
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (flag == 0) {
            self.lineImageView.frame = CGRectMake(kPadding, self.frame.size.width - self.lineHeight, btn.frame.size.height, self.lineHeight);
        } else {
            float offSetX = CGRectGetMinX(btn.frame);
            if (offSetX < kScreenWidth /2) {
                self.topScrollView.contentOffset = CGPointMake(0, 0);
            } else if (offSetX >= kScreenWidth/2 && offSetX <= self.topScrollView.contentSize.width-kScreenWidth/2) {
                self.topScrollView.contentOffset = CGPointMake(offSetX - kScreenWidth/2+kPadding, 0);
            } else {
                self.topScrollView.contentOffset = CGPointMake(self.topScrollView.contentSize.width-kScreenWidth, 0);
            }
            self.lineImageView.frame = CGRectMake(CGRectGetMinX(btn.frame), self.frame.size.height-self.lineHeight, btn.frame.size.width, self.lineHeight);
        }
        
    }];
}
- (UIImageView *)lineImageView {
    if (!_lineImageView) {
        _lineImageView = [[UIImageView alloc] init];
        _lineImageView.image = [UIImage imageNamed:@"nar_bgbg"];
    }
    return _lineImageView;
}





@end
