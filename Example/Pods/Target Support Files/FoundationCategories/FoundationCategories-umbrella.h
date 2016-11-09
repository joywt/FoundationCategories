#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSDate+Utilities.h"
#import "NSDictionary+Accessors.h"
#import "NSString+Utilities.h"

FOUNDATION_EXPORT double FoundationCategoriesVersionNumber;
FOUNDATION_EXPORT const unsigned char FoundationCategoriesVersionString[];

