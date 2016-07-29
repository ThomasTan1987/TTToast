//
//  TTToast.h
//  TTToastDemo
//
//  Created by ThoamsTan on 16/7/28.
//  Copyright © 2016年 ThoamsTan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTToast : NSObject
+ (void)show;
+ (void)dismiss;
+ (void)showErrorMessage:(NSString*)message;
+ (void)showSuccessMessage:(NSString*)message;
+ (void)showWarningMessage:(NSString*)message;
@end
