//
//  KTComponentManager.m
//  KTComponentDemo
//
//  Created by 刘嵩野 on 2018/10/25.
//  Copyright © 2018年 kirito_song. All rights reserved.
//

#import "KTComponentManager.h"

@interface KTComponentManager ()

@property (nonatomic) NSDictionary<NSString *,NSMutableSet *> *registeredDic;

@property (nonatomic) NSDictionary<NSString *,NSString *> *redirectionjson;

@property (nonatomic) NSMutableSet * webUrlSet;

@end

@implementation KTComponentManager

+ (instancetype)sharedInstance
{
    static KTComponentManager *mediator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[KTComponentManager alloc] init];
    });
    return mediator;
}

- (id)openUrl:(NSString *)url{
    id returnObj;
    
    NSURL * openUrl = [NSURL URLWithString:url];
    NSString * path = [openUrl.path substringWithRange:NSMakeRange(1, openUrl.path.length - 1)];
    
    NSRange range = [path rangeOfString:@"/"];
    NSString *targetName = [path substringWithRange:NSMakeRange(0, range.location)];
    NSString *actionName = [path substringWithRange:NSMakeRange(range.location + 1, path.length - range.location - 1)];
    
    //可以对url进行路由。比如从服务器下发json文件。将AAAA/BBBB路由到AAAA/DDDD或者CCCC/EEEE这样
    if (self.redirectionjson[path]) {
        path = self.redirectionjson[path];
    }
    
    //如果该target的action已经注册
    if ([self.registeredDic[targetName] containsObject:actionName]) {
        returnObj = [self openUrl:path params:[self getURLParameters:openUrl.absoluteString]];
    }else if ([self.webUrlSet containsObject:[NSString stringWithFormat:@"%@%@",openUrl.host,openUrl.path]]){
        //低版本兼容
        //如果有某些H5页面、打开H5页面
        //webUrlSet可以由服务器下发
        NSLog(@"跳转网页:%@",url);
    }
    
    return returnObj;
}


- (id)openUrl:(NSString *)url params:(NSDictionary *)params {
    id returnObj;
    
    if (url.length == 0) {
        return nil;
    }
    
    //可以对url进行路由。比如从服务器下发json文件。将AAAA/BBBB路由到AAAA/DDDD或者CCCC/EEEE这样
    if (self.redirectionjson[url]) {
        url = self.redirectionjson[url];
    }
    
    
    NSRange range = [url rangeOfString:@"/"];
    
    NSString *targetName = [url substringWithRange:NSMakeRange(0, range.location)];
    NSString *actionName = [url substringWithRange:NSMakeRange(range.location + 1, url.length - range.location - 1)];
    

    Class targetClass = NSClassFromString(targetName);
    
    
    if ([targetClass respondsToSelector:@selector(handleAction:params:)]) {
        //向已经实现了协议的对象发送Target&&Action信息
        returnObj = [targetClass handleAction:actionName params:params];
    }else {
        //未注册的、进行进一步处理。比如上报啊、返回一个占位对象啊等等
        NSLog(@"未注册的方法");
    }
  
    return returnObj;
}


- (void)addHandleTargetWithInfo:(NSDictionary *)handleInfo {
    [self.registeredDic setValue:handleInfo[@"actionSet"] forKey:handleInfo[@"targetName"]];
}



- (NSMutableDictionary *)getURLParameters:(NSString *)urlStr {
    
    // 查找参数
    NSRange range = [urlStr rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    // 以字典形式将参数返回
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 截取参数
    NSString *parametersString = [urlStr substringFromIndex:range.location + 1];
    
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        
        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        
        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            
            // Key不能为nil
            if (key == nil || value == nil) {
                continue;
            }
            
            id existValue = [params valueForKey:key];
            
            if (existValue != nil) {
                
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                } else {
                    
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
                
            } else {
                
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数
        
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        
        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        
        // 设置值
        [params setValue:value forKey:key];
    }
    
    return params;
}

- (NSDictionary<NSString *,NSMutableSet *> *)registeredDic {
    if (!_registeredDic) {
        _registeredDic = [NSMutableDictionary new];
    }
    return _registeredDic;
}

- (NSMutableSet *)webUrlSet {
    if (!_webUrlSet) {
        _webUrlSet = [[NSMutableSet alloc]initWithObjects:@"www.bilibili.com/video/av25305807", nil];
    }
    return _webUrlSet;
}
@end
