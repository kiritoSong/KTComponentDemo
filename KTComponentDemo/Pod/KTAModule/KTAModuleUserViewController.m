//
//  ModuleAUserViewController.m
//  KTComponentDemo
//
//  Created by 刘嵩野 on 2018/10/25.
//  Copyright © 2018年 kirito_song. All rights reserved.
//

#import "KTAModuleUserViewController.h"

@interface KTAModuleUserViewController ()
{
    NSString *_userName;
    int _age;
}
@end

@implementation KTAModuleUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *nameLab = [UILabel new];
    nameLab.frame = CGRectMake(50, 100, 300, 100);
    nameLab.backgroundColor = [UIColor orangeColor];
    nameLab.text = [NSString stringWithFormat:@"姓名:%@",_userName];
    [self.view addSubview:nameLab];
    
    
    UILabel *ageLab = [UILabel new];
    ageLab.frame = CGRectMake(50, 300, 300, 100);
    ageLab.backgroundColor = [UIColor orangeColor];
    ageLab.text = [NSString stringWithFormat:@"年龄:%d",_age];
    [self.view addSubview:ageLab];
    
}

- (instancetype)initWithUserName:(NSString *)userName age:(int)age
{
    self = [super init];
    if (self) {
        _userName = userName;
        _age = age;
    }
    return self;
}


@end
