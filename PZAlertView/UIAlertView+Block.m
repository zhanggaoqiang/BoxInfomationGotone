//
//  UIAlertView+Block.m
//  PZShoppingPro
//
//  Created by PZ_Chen on 16/5/24.
//  Copyright © 2016年 PZ_Chen. All rights reserved.
//

#import "UIAlertView+Block.h"
#import <objc/runtime.h>

/* 
 * Runtime association key. 
 */
static NSString *kHandlerAssociatedKey = @"kHandlerAssociatedKey";

@implementation UIAlertView (Block)

#pragma mark - Showing
/* 
 * Shows the receiver alert with the given handler. 
 */
- (void)showWithHandler:(UIAlertViewHandler)handler{
    objc_setAssociatedObject(self, (__bridge const void *)(kHandlerAssociatedKey), handler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setDelegate:self];
    [self show];
}


#pragma mark - UIAlertViewDelegate
/* 
 * Sent to the delegate when the user clicks a button on an alert view. 
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIAlertViewHandler completionHandler = objc_getAssociatedObject(self, (__bridge const void *)(kHandlerAssociatedKey));
    if (completionHandler != nil) {
        completionHandler(alertView, buttonIndex);
    }
}


#pragma mark - Utility methods
/**
 *  带有一个确定和取消按钮的提示框
 *
 *  @param message 当前提示内容
 *  @param handler 按钮点击回调
 */
+ (void)showSureAndCancleWithMessage:(NSString *)message handler:(UIAlertViewHandler)handler {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kStrTips_Z_Common_TipsTitle message:message                                                   delegate:nil cancelButtonTitle:kStrTips_Z_Common_TipsSureTitle otherButtonTitles:kStrTips_Z_Common_TipsCancelTitle, nil];
    [alert showWithHandler:handler];
}

/**
 *  只有一个确定按钮的提示框
 *
 *  @param message 当前内容
 *  @param handler 按钮点击回调
 */
+(void)showTipWithMessage:(NSString *)message handler:(UIAlertViewHandler)handler{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kStrTips_Z_Common_TipsTitle message:message                                                   delegate:nil cancelButtonTitle:kStrTips_Z_Common_TipsSureTitle otherButtonTitles:nil];
    [alert showWithHandler:handler];
}

/**
 *  常规AlertView
 *
 *  @param title            标题
 *  @param message          内容
 *  @param cancleTitle      取消按钮标题
 *  @param handler          按钮点击回调
 *  @param otherButtonTitle 其他按钮标题至多只有一个其他按钮
 */
+(void)showAlertView:(NSString *)title message:(NSString *)message cancleButton:(NSString *)cancleTitle handler:(UIAlertViewHandler)handler otherButtonTitle:(nullable NSString *)otherButtonTitle {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message                                                   delegate:nil cancelButtonTitle:cancleTitle otherButtonTitles:otherButtonTitle,nil];
    [alert showWithHandler:handler];
}

@end
