//
//  UIAlertView+Block.h
//  PZShoppingPro
//
//  Created by PZ_Chen on 16/5/24.
//  Copyright © 2016年 PZ_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

/* 
 * Completion handler invoked when user taps a button. 
 * 
 * @param alertView The alert view being shown. 
 * @param buttonIndex The index of the button tapped. 
 */
///Users/chenpingzhe/Desktop/PZShoppingPro/PZShoppingPro/Tools/PZAlertView/UIAlertView+Block.h:36:26: Block pointer is missing a nullability type specifier (_Nonnull, _Nullable, or _Null_unspecified)
typedef void(^UIAlertViewHandler)(UIAlertView * _Nullable al, NSInteger buttonIndex);

/** 
 * Category of `UIAlertView` that offers a completion handler to listen to interaction. This avoids the need of the implementation of the delegate pattern. 
 * 
 * @warning Completion handler: Invoked when user taps a button. 
 * 
 * typedef void(^UIAlertViewHandler)(UIAlertView *alertView, NSInteger buttonIndex); 
 * 
 * - *alertView* The alert view being shown. 
 * - *buttonIndex* The index of the button tapped. 
 */

@interface UIAlertView (Block)
/** 
 * Shows the receiver alert with the given handler. 
 * 
 * @param handler The handler that will be invoked in user interaction. 
 */
- (void)showWithHandler:(UIAlertViewHandler)handler;

/**
 *  带有一个确定和取消按钮的提示框
 *
 *  @param message 当前提示内容
 *  @param handler 按钮点击回调
 */
+ (void)showSureAndCancleWithMessage:(NSString * )message handler:(UIAlertViewHandler)handler;
/**
 *  只有一个确定按钮的提示框
 *
 *  @param message 当前内容
 *  @param handler 按钮点击回调
 */
+(void)showTipWithMessage:(NSString *)message handler:(UIAlertViewHandler)handler;
/**
 *  常规AlertView
 *
 *  @param title            标题
 *  @param message          内容
 *  @param cancleTitle      取消按钮标题
 *  @param handler          按钮点击回调
 *  @param otherButtonTitle 其他按钮标题至多只有一个其他按钮
 */
+(void)showAlertView:(NSString *)title message:(NSString *)message cancleButton:(NSString *)cancleTitle handler:(UIAlertViewHandler)handler otherButtonTitle:(NSString *)otherButtonTitle ;

@end
