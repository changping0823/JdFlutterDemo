//
//  JDHttpTool.h
//  Runner
//
//  Created by Charles on 2020/2/26.
//

#import <Foundation/Foundation.h>


@interface JDHttpTool : NSObject
+ (NSURLSessionTask *)POST:(NSString *)URL parameters:(id)parameters success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
@end

