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
//toast显现时长，单位是秒
#define visible_duration 1
@interface TTToast()
@property (assign, nonatomic)CGRect keyboardFrame;
@property (strong, nonatomic)UIControl *ctrToast;
@property (strong, nonatomic)UIControl *ctrActivity;

@property (strong, nonatomic)UIImageView *icon;
@property (strong, nonatomic)UILabel *content;
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
    [TTToast showActivity];
}
+ (void)dismiss
{
    [sharedToast.ctrActivity removeFromSuperview];
    [sharedToast.ctrToast removeFromSuperview];
}
+ (void)showErrorMessage:(NSString*)message
{
    [TTToast showToastWithImage:[UIImage imageNamed:@"warning"] andText:message];
}
+ (void)showSuccessMessage:(NSString*)message
{
    [TTToast showToastWithImage:[UIImage imageNamed:@"right"] andText:message];
}
+ (void)showWarningMessage:(NSString*)message
{
    [TTToast showToastWithImage:[UIImage imageNamed:@"warning"] andText:message];
}
#pragma mark - private method
+ (void)showActivity
{
    if (!sharedToast.ctrActivity) {
        UIControl *control = [[UIControl alloc] initWithFrame:CGRectZero];
        sharedToast.ctrActivity = control;
        [[UIApplication sharedApplication].keyWindow addSubview:control];
        
        [control mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(control.superview).insets(UIEdgeInsetsMake(0, 0, [TTToast sharedToast].keyboardFrame.size.height, 0));
        }];
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        view.layer.cornerRadius = 10;
        view.layer.masksToBounds = YES;
        [control addSubview:view];
        
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        
        [view addSubview:visualEffectView];
        [visualEffectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(visualEffectView.superview);
        }];
        
        //
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [view addSubview:activityIndicator];
        [activityIndicator startAnimating];
        [activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(view);
            make.width.mas_equalTo(view.mas_width);
            make.height.mas_equalTo(view.mas_height);
        }];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(100);
            make.center.equalTo(view.superview);
        }];
    }else{
        [[UIApplication sharedApplication].keyWindow addSubview:sharedToast.ctrActivity];
        
        [sharedToast.ctrActivity mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(sharedToast.ctrActivity.superview).insets(UIEdgeInsetsMake(0, 0, [TTToast sharedToast].keyboardFrame.size.height, 0));
        }];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(visible_duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [TTToast dismiss];
    });
}
+ (void)showToastWithImage:(UIImage*)image andText:(NSString*)text
{
    if (!sharedToast.ctrToast) {
        UIControl *control = [[UIControl alloc] initWithFrame:CGRectZero];
        sharedToast.ctrToast = control;
        [[UIApplication sharedApplication].keyWindow addSubview:control];
        
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
        
        //text
        UILabel *label = [[UILabel alloc] init];
        sharedToast.content = label;
        label.text = text;
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view).offset(40);
            make.bottom.equalTo(view).offset(-40);
            make.right.lessThanOrEqualTo(view).offset(-20);
            make.left.greaterThanOrEqualTo(view).offset(40);
            make.centerX.equalTo(view).offset(10);
        }];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(270);
            make.center.equalTo(view.superview);
        }];
        
        //icon
        UIImageView *icon = [[UIImageView alloc] initWithImage:image];
        sharedToast.icon = icon;
        [view addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(label.mas_left).offset(-5);
            make.top.equalTo(icon.superview).offset(40);
            make.width.mas_equalTo(image.size.width);
            make.height.mas_equalTo(image.size.height);
        }];
        [control layoutIfNeeded];
    }else{
        [[UIApplication sharedApplication].keyWindow addSubview:sharedToast.ctrToast];
        sharedToast.icon.image = image;
        sharedToast.content.text = text;
        [sharedToast.ctrToast mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(sharedToast.ctrToast.superview).insets(UIEdgeInsetsMake(0, 0, [TTToast sharedToast].keyboardFrame.size.height, 0));
        }];
    }
    //更新toast内容
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(visible_duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [TTToast dismiss];
    });
}
#pragma mark - keyboard notification
- (void)keyboardDidChange:(NSNotification*)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    self.keyboardFrame = [aValue CGRectValue];
}
@end
