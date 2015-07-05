//
//  News.m
//  新闻
//
//  Created by wmg on 15/7/5.
//  Copyright (c) 2015年 test1. All rights reserved.
//

#import "News.h"
#import "NetworkTools.h"
#import <objc/runtime.h>
@implementation News


+ (instancetype)newsWithDict:(NSDictionary *)dict{
    id obj = [[self alloc] init];
    NSArray * arr = [self loadPropertis];
    for (NSString * str in arr) {
        if (dict[str] != nil) {
            [obj setValue:dict[str] forKeyPath:str];
        }
    }
//    [obj setValuesForKeysWithDictionary:dict];
    
    
    return obj;
}

- (NSString *)description{
    NSArray * arr = [[self class] loadPropertis];
    NSDictionary * dic = [self dictionaryWithValuesForKeys:arr];
    return [NSString stringWithFormat:@"<%@,%p> %@", [self class], self, dic];
}

+ (void)loadNewsListWithURLString:(NSString *)URLSting{
    [[NetworkTools sharedNetworkTools] GET:URLSting parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        NSLog(@"%@", responseObject.keyEnumerator.nextObject);
        //根据key 拿到第一个数组
        NSArray *array = responseObject[responseObject.keyEnumerator.nextObject];
//        NSLog(@"%@", array);
        NSMutableArray * arrayM = [NSMutableArray arrayWithCapacity:array.count];
        for (NSDictionary *dict in array) {
            [arrayM addObject:[self newsWithDict:dict]];
        }
//        NSLog(@"%@", arrayM);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

/**  关联对象的key  */
const char *kProperties = "kProperties";
/**
 *  进行时
 *
 *  @return 属性数组
 */

+ (NSArray *)loadPropertis{
    
    /**
     *  取得属性数组
     *
     *  第一个参数:类
     *  第二个参数:属性计数指针
     */
    
    NSArray * pList = objc_getAssociatedObject(self, kProperties);
    if (pList) {
        return pList;
    }
    
    unsigned int count = 0;
    objc_property_t *list = class_copyPropertyList([self class], &count);
    NSLog(@"%zd", count);
    NSMutableArray * arrayM = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++){
        objc_property_t pro = list[i];
        const char * cname = property_getName(pro);
//        NSLog(@"%@", [NSString stringWithUTF8String:cname]);
        [arrayM addObject:[NSString stringWithUTF8String:cname]];
    }
    NSLog(@"%@", arrayM);
    free(list);

    /**
     *  设置关联对象属性
     *  1.属性关联的对象
     *  2.key
     *  3.value
     *  4.关联对象时用得机制
     */
    objc_setAssociatedObject(self, kProperties, arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return objc_getAssociatedObject(self, kProperties);
}










@end
