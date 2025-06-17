//
//  TGLoggerStoreServer.h
//  TGLog
//
//  Created by toad on 2021/09/01.
//
//  服务器

#import "TGLoggerStorage.h"
#import "TGLoggerUploadHandler.h"
NS_ASSUME_NONNULL_BEGIN

@interface TGLoggerStoreServer : TGLoggerStorage

@property (nonatomic,strong) __kindof TGLoggerUploadHandler *handler;

@end

NS_ASSUME_NONNULL_END
