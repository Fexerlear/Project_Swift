//
//  FERefreshNormalHeader.m
//  DaNeng
//
//  Created by Fexerlear on 2019/4/25.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "FERefreshNormalHeader.h"

@implementation FERefreshNormalHeader

#pragma mark 在这里做一些初始化配置（比如添加子控件）

- (void)prepare{
    
    [super prepare];
    //隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
    
    
    
}

@end
