//
//  NSDictionary+Accessors.m
//  FoundationCategories
//
//  Created by wangtie on 16/11/9.
//  Copyright © 2016年 wangtie. All rights reserved.
//

#import "NSDictionary+Accessors.h"

@implementation NSDictionary (Accessors)
- (BOOL)A_isKindOfClass:(Class)aClass forKey:(NSString *)key{
    id value = [self objectForKey:key];
    return [value isKindOfClass:aClass];
}

- (BOOL)A_isMemberOfClass:(Class)aClass forKey:(NSString *)key{
    id value = [self objectForKey:key];
    return [value isMemberOfClass:aClass];
}

- (BOOL)A_isArrayForKey:(NSString *)key{
    return [self A_isKindOfClass:[NSArray class] forKey:key];
}

- (BOOL)A_isDictionaryForKey:(NSString *)key{
    return [self A_isKindOfClass:[NSDictionary class] forKey:key];
}

- (BOOL)A_isStringForKey:(NSString *)key{
    return [self A_isKindOfClass:[NSString class] forKey:key];
}

- (BOOL)A_isNumberForKey:(NSString *)key{
    return [self A_isKindOfClass:[NSNumber class] forKey:key];
}

- (NSArray *)A_arrayForKey:(NSString *)key{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return nil;
}

- (NSDictionary *)A_dictionaryForKey:(NSString *)key{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return nil;
}

- (NSString *)A_stringForKey:(NSString *)key{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    }else if ([value isKindOfClass:[NSNull class]]){
        return @"";
    }
    else if ([value respondsToSelector:@selector(description)]) {
        return [value description];
    }
    return @"";
}

- (NSNumber *)A_numberForKey:(NSString *)key{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return value;
    } else if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
        return [nf numberFromString:value];
    }
    return @(0);
}

- (double)A_doubleForKey:(NSString *)key{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value doubleValue];
    }
    return 0;
}

- (float)A_floatForKey:(NSString *)key{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value floatValue];
    }
    return 0;
}

- (int)A_intForKey:(NSString *)key{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value intValue];
    }
    return 0;
}

- (unsigned int)A_unsignedIntForKey:(NSString *)key{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
        value = [nf numberFromString:value];
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedIntValue];
    }
    return 0;
}

- (NSInteger)A_integerForKey:(NSString *)key{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value integerValue];
    }
    return 0;
}

- (NSUInteger)A_unsignedIntegerForKey:(NSString *)key{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
        value = [nf numberFromString:value];
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedIntegerValue];
    }
    return 0;
}

- (long long)A_longLongForKey:(NSString *)key{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value longLongValue];
    }
    return 0;
}

- (unsigned long long)A_unsignedLongLongForKey:(NSString *)key{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
        value = [nf numberFromString:value];
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedLongLongValue];
    }
    return 0;
}

- (BOOL)A_boolForKey:(NSString *)key{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value boolValue];
    }
    return NO;
}

- (BOOL)isKindOfClass:(Class)aClass forKey:(NSString *)key{
    return [self A_isKindOfClass:aClass forKey:key];
}
- (BOOL)isMemberOfClass:(Class)aClass forKey:(NSString *)key{
    return [self A_isMemberOfClass:aClass forKey:key];
}
- (BOOL)isArrayForKey:(NSString *)key{
    return [self A_isArrayForKey:key];
}
- (BOOL)isDictionaryForKey:(NSString *)key{
    return [self A_isDictionaryForKey:key];
}
- (BOOL)isStringForKey:(NSString *)key{
    return [self A_isStringForKey:key];
}
- (BOOL)isNumberForKey:(NSString *)key{
    return [self A_isNumberForKey:key];
}

- (NSArray *)arrayForKey:(NSString *)key{
    return [self A_arrayForKey:key];
}
- (NSDictionary *)dictionaryForKey:(NSString *)key{
    return [self A_dictionaryForKey:key];
}
- (NSString *)jk_stringForKey:(NSString *)key{
    return [self A_stringForKey:key];
}
- (NSNumber *)numberForKey:(NSString *)key{
    return [self A_numberForKey:key];
}
- (double)doubleForKey:(NSString *)key{
    return [self A_doubleForKey:key];
}
- (float)floatForKey:(NSString *)key{
    return [self A_floatForKey:key];
}
- (int)intForKey:(NSString *)key{
    return [self A_intForKey:key];
}
- (unsigned int)unsignedIntForKey:(NSString *)key{
    return [self A_unsignedIntForKey:key];
}
- (NSInteger)integerForKey:(NSString *)key{
    return [self A_integerForKey:key];
}
- (NSUInteger)unsignedIntegerForKey:(NSString *)key{
    return [self A_unsignedIntegerForKey:key];
}
- (long long)longLongForKey:(NSString *)key{
    return [self A_longLongForKey:key];
}
- (unsigned long long)unsignedLongLongForKey:(NSString *)key{
    return [self A_unsignedLongLongForKey:key];
}
- (BOOL)boolForKey:(NSString *)key{
    return [self A_boolForKey:key];
}
@end
