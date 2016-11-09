//
//  NSString+Utilities.m
//  FoundationCategories
//
//  Created by wangtie on 16/11/9.
//  Copyright © 2016年 wangtie. All rights reserved.
//

#import "NSString+Utilities.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Utilities)

- (NSString*) URLEncode{
    
    NSString *encodedString = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                                    NULL,
                                                                                                    (__bridge CFStringRef)self,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                    kCFStringEncodingUTF8 );
    
    return encodedString;
    
    //return [self stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
}


- (BOOL)isPhoneNum
{
    //    电信号段:133/153/180/181/189/177
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //    虚拟运营商:170
    return self.length==11;
//    NSString *phoneRegex=@"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
//    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
//    return [phoneTest evaluateWithObject:self];
}

- (BOOL)checkUserIdCard
{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (BOOL) isEmail{
    
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regExPredicate evaluateWithObject:[self lowercaseString]];
}

- (NSString *)transformToPinyin {
    NSMutableString *mutableString = [NSMutableString stringWithString:self];
    CFStringTransform((__bridge CFMutableStringRef)mutableString, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)mutableString, NULL, kCFStringTransformStripDiacritics, NO);
    return mutableString;
}

/**
 *  md5加密
 */
- (NSString *)MImd5 {
    NSData* inputData = [self dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char outputData[CC_MD5_DIGEST_LENGTH];
    CC_MD5([inputData bytes], (unsigned int)[inputData length], outputData);
    NSMutableString *md5Str = [NSMutableString string];
    int i = 0;
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; ++i)
        [md5Str appendFormat:@"%02x", outputData[i]];
    
    return md5Str;
}

/**
 *  DES加密
 */
- (NSString *)MIDESEncryptWithKey:(NSString *)key {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    data = [self encrypt:data WithKey:key];
    return [self base64EncodedStringWithWrapWidth:0 withData:data];
}

/**
 *  DES解密
 */
- (NSString *)MIDESDecryptWithKey:(NSString *)key {
    NSData *data = [self base64Decoded];
    data = [self decrypt:data WithKey:key];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

#pragma mark - Method Private

- (NSData *)decrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}

- (NSData *)base64Decoded
{
    const char lookup[] =
    {
        99, 99, 99, 99, 99,99, 99, 99, 99, 99,99, 99, 99, 99, 99,99,
        99, 99, 99, 99, 99,99, 99, 99, 99, 99,99, 99, 99, 99, 99,99,
        99, 99, 99, 99, 99,99, 99, 99, 99, 99,99, 62, 99, 99, 99,63,
        52, 53, 54, 55, 56,57, 58, 59, 60, 61,99, 99, 99, 99, 99,99,
        99,  0,  1,  2,  3, 4,  5,  6,  7,  8, 9, 10, 11, 12, 13,14,
        15, 16, 17, 18, 19,20, 21, 22, 23, 24,25, 99, 99, 99, 99,99,
        99, 26, 27, 28, 29,30, 31, 32, 33, 34,35, 36, 37, 38, 39,40,
        41, 42, 43, 44, 45,46, 47, 48, 49, 50,51, 99, 99, 99, 99,99
    };
    
    NSData *inputData = [self dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    long long inputLength = [inputData length];
    const unsigned char *inputBytes = [inputData bytes];
    
    long long maxOutputLength = (inputLength /4 + 1) * 3;
    NSMutableData *outputData = [NSMutableData dataWithLength:(NSUInteger)maxOutputLength];
    unsigned char *outputBytes = (unsigned char *)[outputData mutableBytes];
    
    int accumulator = 0;
    long long outputLength =0;
    unsigned char accumulated[] = {0,0, 0, 0};
    for (long long i = 0; i < inputLength; i++)
    {
        unsigned char decoded = lookup[inputBytes[i] &0x7F];
        if (decoded != 99)
        {
            accumulated[accumulator] = decoded;
            if (accumulator == 3)
            {
                outputBytes[outputLength++] = (accumulated[0] <<2) | (accumulated[1] >>4);
                outputBytes[outputLength++] = (accumulated[1] <<4) | (accumulated[2] >>2);
                outputBytes[outputLength++] = (accumulated[2] <<6) | accumulated[3];
            }
            accumulator = (accumulator +1) % 4;
        }
    }
    
    //handle left-over data
    if (accumulator > 0) outputBytes[outputLength] = (accumulated[0] <<2) | (accumulated[1] >>4);
    if (accumulator > 1) outputBytes[++outputLength] = (accumulated[1] <<4) | (accumulated[2] >>2);
    if (accumulator > 2) outputLength++;
    
    //truncate data to match actual output length
    outputData.length = (NSUInteger)outputLength;
    return outputLength? outputData: nil;
}

- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth withData:(NSData*)data
{
    //ensure wrapWidth is a multiple of 4
    wrapWidth = (wrapWidth /4) * 4;
    
    const char lookup[] ="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    
    long long inputLength = [data length];
    const unsigned char *inputBytes = [data bytes];
    
    long long maxOutputLength = (inputLength /3 + 1) * 4;
    maxOutputLength += wrapWidth? (maxOutputLength / wrapWidth) *2: 0;
    unsigned char *outputBytes = (unsigned char *)malloc((NSUInteger)maxOutputLength);
    
    long long i;
    long long outputLength =0;
    for (i = 0; i < inputLength -2; i += 3)
    {
        outputBytes[outputLength++] = lookup[(inputBytes[i] &0xFC) >> 2];
        outputBytes[outputLength++] = lookup[((inputBytes[i] &0x03) << 4) | ((inputBytes[i +1] & 0xF0) >>4)];
        outputBytes[outputLength++] = lookup[((inputBytes[i +1] & 0x0F) <<2) | ((inputBytes[i + 2] & 0xC0) >> 6)];
        outputBytes[outputLength++] = lookup[inputBytes[i +2] & 0x3F];
        
        //add line break
        if (wrapWidth && (outputLength + 2) % (wrapWidth + 2) == 0)
        {
            outputBytes[outputLength++] ='\r';
            outputBytes[outputLength++] ='\n';
        }
    }
    
    //handle left-over data
    if (i == inputLength - 2)
    {
        // = terminator
        outputBytes[outputLength++] = lookup[(inputBytes[i] &0xFC) >> 2];
        outputBytes[outputLength++] = lookup[((inputBytes[i] &0x03) << 4) | ((inputBytes[i +1] & 0xF0) >>4)];
        outputBytes[outputLength++] = lookup[(inputBytes[i +1] & 0x0F) <<2];
        outputBytes[outputLength++] =  '=';
    }
    else if (i == inputLength -1)
    {
        // == terminator
        outputBytes[outputLength++] = lookup[(inputBytes[i] &0xFC) >> 2];
        outputBytes[outputLength++] = lookup[(inputBytes[i] &0x03) << 4];
        outputBytes[outputLength++] ='=';
        outputBytes[outputLength++] ='=';
    }
    
    //truncate data to match actual output length
    outputBytes =realloc(outputBytes, (NSUInteger)outputLength);
    NSString *result = [[NSString alloc] initWithBytesNoCopy:outputBytes length:(NSUInteger)outputLength encoding:NSASCIIStringEncoding freeWhenDone:YES];
    
#if !__has_feature(objc_arc)
    [resultautorelease];
#endif
    
    return (outputLength >= 4)? result: nil;
}

- (NSData *)encrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}



+ (NSString *)getBundlePathForFile:(NSString *)fileName
{
    NSString *fileExtension = [fileName pathExtension];
    NSString *path = [[NSBundle mainBundle] pathForResource:[fileName stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@".%@",fileExtension] withString:@""] ofType:fileExtension];
    return path;
}

+ (NSString *)getDocumentsDirectoryForFile:(NSString *)fileName
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/",fileName]];
    return path;
}

+ (NSString *)getLibraryDirectoryForFile:(NSString *)fileName
{
    NSString *libraryDirectory = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *destinationPath = [libraryDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/",fileName]];
    return destinationPath;
}

+ (NSString *)getCacheDirectoryForFile:(NSString *)fileName
{
    NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *destinationPath = [cacheDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/",fileName]];
    return destinationPath;
}


@end
