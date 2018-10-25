//
//  ModuleLoginLoginManager.h
//  KTComponentDemo
//
//  Created by 刘嵩野 on 2018/10/25.
//  Copyright © 2018年 kirito_song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

/**
 登录模块
 */
@interface KTLoginManager : NSObject


@property (nonatomic ,readonly) BOOL isLogin;

+ (instancetype)sharedInstance;

/**
 弹窗登录

 @return 是否已经登录
 */
- (BOOL)loginIfNeed;


/**
 退出登录
 */
- (void)loginOut;
@end

NS_ASSUME_NONNULL_END
