//
//  News.h
//  新闻
//
//  Created by wmg on 15/7/5.
//  Copyright (c) 2015年 test1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *digest;
@property (nonatomic, assign) int  replyCount;
@property (nonatomic, copy) NSString *imgsrc;
+ (instancetype)newsWithDict: (NSDictionary *)dict;
/**
 *  加载指定 URL 新闻数组
 */
+ (void)loadNewsListWithURLString:(NSString *)URLSting;
@end
