//声明，这个是复制DTCoreText开源框架里面的Log代码，为了以后用到DTCoretext而不与它产生冲突，把前缀DT 改成 SS

//
//  DTLog.h
//  DTFoundation
//
//  Created by Oliver Drobnik on 06.08.13.
//  Copyright (c) 2013 Cocoanetics. All rights reserved.
//

/**
 Replacement for `NSLog` which can be configured to output certain log levels at run time.
 */

#import <UIKit/UIKit.h>

// block signature called for each log statement
typedef void (^SSLogBlock)(NSUInteger logLevel, NSString *fileName, NSUInteger lineNumber, NSString *methodName, NSString *format, ...);


// internal variables needed by macros
extern SSLogBlock SSLogHandler;
extern NSUInteger SSCurrentLogLevel;

/**
 There is a macro for each ASL log level:
 
 - DTLogEmergency (0)
 - DTLogAlert (1)
 - DTLogCritical (2)
 - DTLogError (3)
 - DTLogWarning (4)
 - DTLogNotice (5)
 - DTLogInfo (6)
 - DTLogDebug (7)
 */

/**
 Constants for log levels used by DTLog
 */
typedef NS_ENUM(NSUInteger, SSLogLevel)
{
    /**
     Log level for *emergency* messages
     */
    SSLogLevelEmergency = 0,
    
    /**
     Log level for *alert* messages
     */
    SSLogLevelAlert     = 1,
    
    /**
     Log level for *critical* messages
     */
    SSLogLevelCritical  = 2,
    
    /**
     Log level for *error* messages
     */
    SSLogLevelError     = 3,
    
    /**
     Log level for *warning* messages
     */
    SSLogLevelWarning   = 4,
    
    /**
     Log level for *notice* messages
     */
    SSLogLevelNotice    = 5,
    
    /**
     Log level for *info* messages. This is the default log level for DTLog.
     */
    SSLogLevelInfo      = 6,
    
    /**
     Log level for *debug* messages
     */
    SSLogLevelDebug     = 7
};

/**
 @name Logging Functions
 */

/**
 Sets the block to be executed for messages with a log level less or equal the currently set log level
 @param handler The block to handle log output
 */
void SSLogSetLoggerBlock(SSLogBlock handler);

/**
 Modifies the current log level
 @param logLevel The ASL log level (0-7) to set, lower numbers being more important
 */
void SSLogSetLogLevel(NSUInteger logLevel);

/**
 Variant of DTLogMessage that takes a va_list.
 @param logLevel The DTLogLevel for the message
 @param format The log message format
 @param args The va_list of arguments
 */
void SSLogMessagev(SSLogLevel logLevel, NSString *format, va_list args);

/**
 Same as `NSLog` but allows for setting a message log level
 @param logLevel The DTLogLevel for the message
 @param format The log message format and optional variables
 */
void SSLogMessage(SSLogLevel logLevel, NSString *format, ...);

/**
 Retrieves the log messages currently available for the running app
 @returns an `NSArray` of `NSDictionary` entries
 */
NSArray *SSLogGetMessages(void);

/**
 @name Macros
 */

// log macro for error level (0)
#define SSLogEmergency(format, ...) SSLogCallHandlerIfLevel(SSLogLevelEmergency, format, ##__VA_ARGS__)

// log macro for error level (1)
#define SSLogAlert(format, ...) SSLogCallHandlerIfLevel(SSLogLevelAlert, format, ##__VA_ARGS__)

// log macro for error level (2)
#define SSLogCritical(format, ...) SSLogCallHandlerIfLevel(SSLogLevelCritical, format, ##__VA_ARGS__)

// log macro for error level (3)
#define SSLogError(format, ...) SSLogCallHandlerIfLevel(SSLogLevelError, format, ##__VA_ARGS__)

// log macro for error level (4)
#define SSLogWarning(format, ...) SSLogCallHandlerIfLevel(SSLogLevelWarning, format, ##__VA_ARGS__)

// log macro for error level (5)
#define SSLogNotice(format, ...) SSLogCallHandlerIfLevel(SSLogLevelNotice, format, ##__VA_ARGS__)

// log macro for info level (6)
#define SSLogInfo(format, ...) SSLogCallHandlerIfLevel(SSLogLevelInfo, format, ##__VA_ARGS__)

// log macro for debug level (7)
#define SSLogDebug(format, ...) SSLogCallHandlerIfLevel(SSLogLevelDebug, format, ##__VA_ARGS__)

// macro that gets called by individual level macros
#define SSLogCallHandlerIfLevel(logLevel, format, ...) \
if (SSLogHandler && SSCurrentLogLevel>=logLevel) SSLogHandler(logLevel, SSLogSourceFileName, SSLogSourceLineNumber, SSLogSourceMethodName, format, ##__VA_ARGS__)

// helper to get the current source file name as NSString
#define SSLogSourceFileName [[NSString stringWithUTF8String:__FILE__] lastPathComponent]

// helper to get current method name
#define SSLogSourceMethodName [NSString stringWithUTF8String:__PRETTY_FUNCTION__]

// helper to get current line number
#define SSLogSourceLineNumber __LINE__