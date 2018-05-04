//
//  OFMiningSDK.h
//  OFMiningSDK
//
//  Created by xiepengxiang on 2018/4/23.
//  Copyright © 2018年 OFBank. All rights reserved.
//

#import <Foundation/Foundation.h>

/* SDK版本号 */
#define OFMINING_IOS_SDK_VERSION @"1.0.0"

@interface OFMiningSDK : NSObject

/**
 *    Mining SDK 初始化
 *
 *    @param appCode    appCode
 *    @param security   security
 */
+ (void)startWithAppCode:(NSString *)appCode security:(NSString *)security;

/**
 *    打开调试日志
 */
+ (void)turnOnDebug;

/**
 *    返回SDK版本
 *
 *    @return SDK版本
 */
+ (NSString *)getVersion;

/**
 *    启动挖矿
 */
+ (void)startMining;

/**
 *    停止挖矿
 */
+ (void)stopMining;

/**
 *    用户注册接口
 *
 *    @param account    用户名
 *    @param password   密码
 *    @param success    注册成功回调
 *    @param failure    注册失败回调
 */
+ (void)registerWithAccount:(NSString *)account
                   password:(NSString *)password
                    success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                    failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

/**
 *    用户登录接口
 *
 *    @param account            用户名
 *    @param password           密码
 *    @param tokenExpireTime    token 有效期设置，默认为永久不失效
 *    @param success            登录成功回调
 *    @param failure            登录失败回调
 */
+ (void)loginWithAccount:(NSString *)account
                password:(NSString *)password
         tokenExpireTime:(NSString *)tokenExpireTime
                 success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                 failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

/**
 *    获取用户挖矿收益记录
 *
 *    @param page       记录页数，可不传，默认为1
 *    @param count      每页记录数，可不传，默认为10
 *    @param success    获取记录成功回调
 *    @param failure    获取记录失败回调
 */
+ (void)getRewardsListWithPage:(NSString *)page
                         count:(NSString *)count
                       success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

/**
 *    获取用户交易记录
 *
 *    @param page       记录页数，可不传，默认为1
 *    @param count      每页记录数，可不传，默认为10
 *    @param success    获取记录成功回调
 *    @param failure    获取记录失败回调
 */
+ (void)getDrawTransactionWithPage:(NSString *)page
                                 count:(NSString *)count
                               success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

/**
 *    提现到指定地址
 *
 *    @param walletAddress      提现地址
 *    @param coinNum            提现金额
 *    @param success            获取记录成功回调
 *    @param failure            获取记录失败回调
 */
+ (void)withdrawCashWithWalletAddress:(NSString *)walletAddress
                              coinNum:(NSString *)coinNum
                              success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                              failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

@end



