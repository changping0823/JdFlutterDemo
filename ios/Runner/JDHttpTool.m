//
//  JDHttpTool.m
//  Runner
//
//  Created by Charles on 2020/2/26.
//

#import "JDHttpTool.h"
#import <AFNetworking/AFNetworking.h>

@implementation JDHttpTool



+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(id)parameters
                   success:(void (^)(id json))success
                   failure:(void (^)(NSError *error))failure {
    //读取缓存
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLSessionTask *sessionTask = [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
    return sessionTask;
}

@end
