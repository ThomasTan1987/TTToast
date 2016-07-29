//
//  TTToast.m
//  TTToastDemo
//
//  Created by ThoamsTan on 16/7/28.
//  Copyright © 2016年 ThoamsTan. All rights reserved.
//

#import "TTToast.h"
#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
@interface TTToast()
@property (assign, nonatomic)CGRect keyboardFrame;
@end
@implementation TTToast
static TTToast *sharedToast = nil;
+ (void)load
{
    sharedToast = [[TTToast alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:sharedToast selector:@selector(keyboardDidChange:) name:UIKeyboardDidChangeFrameNotification object:nil];
}
+ (TTToast*)sharedToast
{
    return sharedToast;
}
+ (void)show
{
    
}
+ (void)dismiss
{
    
}
+ (void)showErrorMessage:(NSString*)message
{
    
}
+ (void)showSuccessMessage:(NSString*)message
{
    [TTToast showToastWithImage:[UIImage imageNamed:@"rightDone"] andText:message];
}
+ (void)showWarningMessage:(NSString*)message
{
    
}
#pragma mark - private method
+ (void)showToastWithImage:(UIImage*)image andText:(NSString*)text
{
    UIControl *control = [[UIControl alloc] initWithFrame:CGRectZero];
    [[UIApplication sharedApplication].keyWindow addSubview:control];
    NSLog(@"%f",[TTToast sharedToast].keyboardFrame.origin.y);
    [control mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(control.superview).insets(UIEdgeInsetsMake(0, 0, [TTToast sharedToast].keyboardFrame.size.height, 0));
    }];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    
    [view addSubview:visualEffectView];
    [visualEffectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(visualEffectView.superview);
    }];
    [control addSubview:view];
    
    
    //icon
    UIImageView *icon = [[UIImageView alloc] initWithImage:image];
    [view addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.superview).offset(20);
        make.top.equalTo(icon.superview).offset(40);
        make.width.mas_equalTo(image.size.width);
        make.height.mas_equalTo(image.size.height);
    }];
    //text
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.numberOfLines = 0;
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).offset(5);
        make.top.equalTo(icon);
        make.right.equalTo(label.superview).offset(-20);
    }];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(270);
        make.center.equalTo(view.superview);
        make.bottom.equalTo(label.mas_bottom).offset(40);
    }];
    [control layoutIfNeeded];
}
#pragma mark - keyboard notification
- (void)keyboardDidChange:(NSNotification*)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    self.keyboardFrame = [aValue CGRectValue];
}
@end
