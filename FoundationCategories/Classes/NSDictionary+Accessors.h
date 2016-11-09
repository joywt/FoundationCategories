//
//  NSDictionary+Accessors.h
//  FoundationCategories
//
//  Created by wangtie on 16/11/9.
//  Copyright © 2016年 wangtie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Accessors)
- (BOOL)A_isKindOfClass:(Class)aClass forKey:(NSString *)key;
- (BOOL)A_isMemberOfClass:(Class)aClass forKey:(NSString *)key;
- (BOOL)A_isArrayForKey:(NSString *)key;
- (BOOL)A_isDictionaryForKey:(NSString *)key;
- (BOOL)A_isStringForKey:(NSString *)key;
- (BOOL)A_isNumberForKey:(NSString *)key;

- (NSArray *)A_arrayForKey:(NSString *)key;
- (NSDictionary *)A_dictionaryForKey:(NSString *)key;
- (NSString *)A_stringForKey:(NSString *)key;
- (NSNumber *)A_numberForKey:(NSString *)key;
- (double)A_doubleForKey:(NSString *)key;
- (float)A_floatForKey:(NSString *)key;
- (int)A_intForKey:(NSString *)key;
- (unsigned int)A_unsignedIntForKey:(NSString *)key;
- (NSInteger)A_integerForKey:(NSString *)key;
- (NSUInteger)A_unsignedIntegerForKey:(NSString *)key;
- (long long)A_longLongForKey:(NSString *)key;
- (unsigned long long)A_unsignedLongLongForKey:(NSString *)key;
- (BOOL)A_boolForKey:(NSString *)key;
@end
