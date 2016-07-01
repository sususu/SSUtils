//
//  DTLog.m
//  DTFoundation
//
//  Created by Oliver Drobnik on 06.08.13.
//  Copyright (c) 2013 Cocoanetics. All rights reserved.
//

#import "Logger.h"
#import <asl.h>
#import <Availability.h>

SSLogLevel SSCurrentLogLevel = SSLogLevelInfo;

#if TARGET_OS_IPHONE
#if __IPHONE_OS_VERSION_MIN_REQUIRED > __IPHONE_6_1 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
#define DTLOG_USE_NEW_ASL_METHODS 1
#endif
#else
#if __MAC_OS_X_VERSION_MIN_REQUIRED > __MAC_10_9
#define DTLOG_USE_NEW_ASL_METHODS 1
#endif
#endif

#if DEBUG

// set default handler for debug mode
SSLogBlock SSLogHandler = ^(NSUInteger logLevel, NSString *fileName, NSUInteger lineNumber, NSString *methodName, NSString *format, ...)
{
    va_list args;
    va_start(args, format);
    
    SSLogMessagev(logLevel, format, args);
    
    va_end(args);
};

#else

// set no default handler for non-DEBUG mode
SSLogBlock SSLogHandler = NULL;

#endif

#pragma mark - Logging Functions

void SSLogSetLoggerBlock(SSLogBlock handler)
{
    SSLogHandler = [handler copy];
}

void SSLogSetLogLevel(SSLogLevel logLevel)
{
    SSCurrentLogLevel = logLevel;
}

void SSLogMessagev(SSLogLevel logLevel, NSString *format, va_list args)
{
    NSString *facility = [[NSBundle mainBundle] bundleIdentifier];
    aslclient client = asl_open(NULL, [facility UTF8String], ASL_OPT_STDERR); // also log to stderr
    
    aslmsg msg = asl_new(ASL_TYPE_MSG);
    asl_set(msg, ASL_KEY_READ_UID, "-1");  // without this the message cannot be found by asl_search
    
    // convert to via NSString, since printf does not know %@
    NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
    
    asl_log(client, msg, logLevel, "%s", [message UTF8String]);
    
    asl_free(msg);
    
    va_end(args);
}

void SSLogMessage(SSLogLevel logLevel, NSString *format, ...)
{
    va_list args;
    va_start(args, format);
    
    SSLogMessagev(logLevel, format, args);
    
    va_end(args);
}

NSArray *DTLogGetMessages(void)
{
    aslmsg query, message;
    int index;
    const char *key, *val;
    
    NSString *facility = [[NSBundle mainBundle] bundleIdentifier];
    
    query = asl_new(ASL_TYPE_QUERY);
    
    // search only for current app messages
    asl_set_query(query, ASL_KEY_FACILITY, [facility UTF8String], ASL_QUERY_OP_EQUAL);
    
    aslresponse response = asl_search(NULL, query);
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    
#if DTLOG_USE_NEW_ASL_METHODS
    while ((message = asl_next(response)))
#else
        while ((message = aslresponse_next(response)))
#endif
        {
            NSMutableDictionary *tmpDict = [NSMutableDictionary dictionary];
            
            for (index = 0; ((key = asl_key(message, index))); index++)
            {
                NSString *keyString = [NSString stringWithUTF8String:(char *)key];
                
                val = asl_get(message, key);
                
                NSString *string = val?[NSString stringWithUTF8String:val]:@"";
                tmpDict[keyString] = string;
            }
            
            [tmpArray addObject:tmpDict];
        }
    
    asl_free(query);
#if DTLOG_USE_NEW_ASL_METHODS
    asl_release(response);
#else
    aslresponse_free(response);
#endif
    
    if ([tmpArray count])
    {
        return [tmpArray copy];
    }
    
    return nil;
}
