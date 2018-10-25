//
//  KTComponentManager+ModuleA.h
//  KTComponentDemo
//
//  Created by 刘嵩野 on 2018/10/25.
//  Copyright © 2018年 kirito_song. All rights reserved.
//

#import "KTComponentManager.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KTComponentManager (ModuleA)

- (UIViewController *)ModuleA_getUserViewControllerWithUserName:(NSString *)userName age:(int)age;

@end

NS_ASSUME_NONNULL_END
