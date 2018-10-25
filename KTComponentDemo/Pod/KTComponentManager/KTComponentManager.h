//
//  KTComponentManager.h
//  KTComponentDemo
//
//  Created by 刘嵩野 on 2018/10/25.
//  Copyright © 2018年 kirito_song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KTComponentManagerProtocol <NSObject>

+ (id)handleAction:(NSString *)action params:(NSDictionary *)params;

@end

@interface KTComponentManager : NSObject

+ (instancetype)sharedInstance;


/**
 执行某个已注册的Url

 @param url url
 @param params 参数
 @return 返回值
 */
- (id)openUrl:(NSString *)url params:(NSDictionary * _Nullable)params;



- (void)addHandleTargetWithInfo:(NSDictionary *)handleInfo;

- (id)openUrl:(NSString *)url;
@end

NS_ASSUME_NONNULL_END
