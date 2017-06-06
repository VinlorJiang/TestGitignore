//
//  WLPageView.h
//  PageNavigation_Test
//
//  Created by dinpay on 2017/6/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLPageView : UIView

@property (nonatomic, strong) UIColor *titleNomalColor;
@property (nonatomic, strong) UIColor *titleSelectedColor;


- (instancetype)initWithFrame:(CGRect)frame viewArray:(NSArray <UIView *> *)viewArray titleArray:(NSArray <NSString *> *)titleArray lineHeight:(CGFloat)lineHeight;

@end
