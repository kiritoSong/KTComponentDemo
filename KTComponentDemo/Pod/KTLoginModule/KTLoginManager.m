//
//  ModuleLoginLoginManager.m
//  KTComponentDemo
//
//  Created by 刘嵩野 on 2018/10/25.
//  Copyright © 2018年 kirito_song. All rights reserved.
//

#import "KTLoginManager.h"
#import "KTLoginViewController.h"


@interface KTLoginManager ()
@property (nonatomic ,readwrite) BOOL isLogin;
@end

@implementation KTLoginManager

+ (instancetype)sharedInstance
{
    static KTLoginManager *mediator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[KTLoginManager alloc] init];
    });
    return mediator;
}


-(BOOL)loginIfNeed {
    
    if (!_isLogin) {
        UIViewController * getCurrentVC = [KTLoginManager getCurrentVC];
        KTLoginViewController * loginVC = [KTLoginViewController new];
        [getCurrentVC presentViewController:loginVC animated:YES completion:nil];
        _isLogin = YES;
        return NO;
    }
    return _isLogin;
}


- (void)loginOut {
    _isLogin = NO;
}

+(UIViewController *)getCurrentVC{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication].delegate window];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        //多层present
        while (appRootVC.presentedViewController) {
            appRootVC = appRootVC.presentedViewController;
            if (appRootVC) {
                nextResponder = appRootVC;
            }else{
                break;
            }
        }
        //        nextResponder = appRootVC.presentedViewController;
    }else{
        
        // 如果当前UIViewController顶层不是UIView，那就需要循环获取到该UIViewController对应的UIView，
        // 才能跳出循环
        int i= 0;
        UIView *frontView = [[window subviews] objectAtIndex:i];
        nextResponder = [frontView nextResponder];
        while (![nextResponder isKindOfClass:[UIViewController class]]) {
            i++;
            frontView = [[window subviews]objectAtIndex:i];
            nextResponder = [frontView nextResponder];
        }
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    return result;
}


@end
