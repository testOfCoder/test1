//
//  NetworkTools.h
//  新闻
//
//  Created by wmg on 15/7/5.
//  Copyright (c) 2015年 test1. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface NetworkTools : AFHTTPSessionManager
+ (instancetype)sharedNetworkTools;
@end
