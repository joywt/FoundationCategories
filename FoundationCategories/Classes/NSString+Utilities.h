//
//  NSString+Utilities.h
//  FoundationCategories
//
//  Created by wangtie on 16/11/9.
//  Copyright © 2016年 wangtie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utilities)

- (NSString*)URLEncode;
- (BOOL)isPhoneNum;
- (BOOL)checkUserIdCard;
- (BOOL)isEmail;
- (NSString *)transformToPinyin;
/**
 *  md5加密
 */
- (NSString *)MImd5;

/**
 *  DES加密
 */
- (NSString *)MIDESEncryptWithKey:(NSString *)key;

/**
 *  DES解密
 */
- (NSString *)MIDESDecryptWithKey:(NSString *)key;



+ (NSString *)getBundlePathForFile:(NSString *)fileName;
+ (NSString *)getDocumentsDirectoryForFile:(NSString *)fileName;
+ (NSString *)getLibraryDirectoryForFile:(NSString *)fileName;
+ (NSString *)getCacheDirectoryForFile:(NSString *)fileName;
@end
