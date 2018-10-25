//
//  KTComponentManager+ModuleLogin.h
//  KTComponentDemo
//
//  Created by 刘嵩野 on 2018/10/25.
//  Copyright © 2018年 kirito_song. All rights reserved.
//

#import "KTComponentManager.h"


@protocol KTLoginViewControllerDelegate <NSObject>


/**
 登录成功
 */
- (void)didLoginIn;


/**
 退出成功
 */
- (void)didLoginOut;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KTComponentManager (LoginModule)

- (BOOL)isLogin;

- (BOOL)loginIfNeedWithDelegate:(id<KTLoginViewControllerDelegate>)delegate;


- (void)loginOutWithDelegate:(id<KTLoginViewControllerDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
