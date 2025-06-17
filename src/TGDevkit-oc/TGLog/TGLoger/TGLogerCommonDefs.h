//
//  TGLogerCommonDefs.h
//  TGLog
//
//  Created by toad on 2021/08/30.
//

#import <Foundation/Foundation.h>

#define TGLOGOPEN   1

typedef NS_ENUM(NSInteger,TGLogLevel) {
    TGLogLevelDebug = 0,
    TGLogLevelInfo,
    TGLogLevelWarn,
    TGLogLevelError,
    TGLogLevelCrash
};
//日志打印前缀
static NSString * _Nonnull TGLogLevelPrefixs[] = {
    [TGLogLevelDebug]   = @"🐞DEBUG",
    [TGLogLevelInfo]    = @"🌴INFO",
    [TGLogLevelWarn]    = @"⚠️WARN",
    [TGLogLevelError]   = @"❌ERROR",
    [TGLogLevelCrash]   = @"💥CRASH"
};

typedef NS_OPTIONS(NSUInteger, TGLoggerStorageType) {
    TGLoggerStorageTypeNone              = 0,
    TGLoggerStorageTypeConsle            = 1 << 0,
    TGLoggerStorageTypeLocalFile         = 1 << 1,
    TGLoggerStorageTypeSqllite           = 1 << 2,
    TGLoggerStorageTypeUpload           = 1 << 2
};
 
#if DEBUG == 1
    static const TGLogLevel TGDefalueLevel = 0;
    static const NSUInteger TGDefalueStorageType = TGLoggerStorageTypeConsle | TGLoggerStorageTypeLocalFile | TGLoggerStorageTypeSqllite;
#else
    static const TGLogLevel TGDefalueLevel = 1;
    static const NSUInteger TGDefalueStorageType = TGLoggerStorageTypeNone;
#endif


/** 崩溃信号 */
static int s_fatal_signals[] = {
    SIGHUP,
    SIGINT,
    SIGQUIT,
    SIGILL,
    SIGTRAP,
    SIGABRT,
#if  (defined(_POSIX_C_SOURCE) && !defined(_DARWIN_C_SOURCE))
    SIGPOLL,
#else
    SIGIOT,
    SIGEMT,
#endif
    SIGFPE,
    SIGKILL,
    SIGBUS,
    SIGSEGV,
    SIGSYS,
    SIGPIPE,
    SIGALRM,
    SIGTERM,
    SIGURG,
    SIGSTOP,
    SIGTSTP,
    SIGCONT,
    SIGCHLD,
    SIGTTIN,
    SIGTTOU,
#if  (!defined(_POSIX_C_SOURCE) || defined(_DARWIN_C_SOURCE))
    SIGIO,
#endif
    SIGXCPU,
    SIGXFSZ,
    SIGVTALRM,
    SIGPROF,
#if  (!defined(_POSIX_C_SOURCE) || defined(_DARWIN_C_SOURCE))
    SIGWINCH,
    SIGINFO,
#endif
    SIGUSR1,
    SIGUSR2,
};

/** 崩溃信号名称 */
static char* _Nonnull s_fatal_signal_names[] = {
    "SIGHUP",
    "SIGINT",
    "SIGQUIT",
    "SIGILL",
    "SIGTRAP",
    "SIGABRT",
#if (defined(_POSIX_C_SOURCE) && !defined(_DARWIN_C_SOURCE))
    "SIGPOLL",
#else
    "SIGIOT",
    "SIGEMT",
#endif
    "SIGFPE",
    "SIGKILL",
    "SIGBUS",
    "SIGSEGV",
    "SIGSYS",
    "SIGPIPE",
    "SIGALRM",
    "SIGTERM",
    "SIGURG",
    "SIGSTOP",
    "SIGTSTP",
    "SIGCONT",
    "SIGCHLD",
    "SIGTTIN",
    "SIGTTOU",
#if (!defined(_POSIX_C_SOURCE) || defined(_DARWIN_C_SOURCE))
    "SIGIO",
#endif
    "SIGXCPU",
    "SIGXFSZ",
    "SIGVTALRM",
    "SIGPROF",
#if (!defined(_POSIX_C_SOURCE) || defined(_DARWIN_C_SOURCE))
    "SIGWINCH",
    "SIGINFO",
#endif
    "SIGUSR1",
    "SIGUSR2",
};

static int s_fatal_signal_num = sizeof(s_fatal_signals) / sizeof(s_fatal_signals[0]);
static NSString * _Nonnull UncaughtExceptionHandlerSignalExceptionName = @"UncaughtExceptionHandlerSignalExceptionName";
static NSString * _Nonnull UncaughtExceptionHandlerSignalName = @"UncaughtExceptionHandlerSignalName";
