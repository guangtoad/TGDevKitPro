//
//  BleProtocolFrameModel.h
//  DigitalKeySdk
//
//  Created by greatrong on 2021/3/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BleProtocolFrameHeader,BleProtocolFrameControl,BleProtocolFrameBody,TLVPayload;

@interface BleProtocolFrameModel : NSObject

@property (nonatomic, copy)BleProtocolFrameHeader *header;
@property (nonatomic, copy)BleProtocolFrameBody *body;
@property (nonatomic, copy)NSString *checkSum;

@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *length;
@property (nonatomic, copy)NSString *value;

@end

@interface BleProtocolFrameHeader : NSObject
@property (nonatomic, copy)NSString *sof;
@property (nonatomic, copy)NSString *length;
@property (nonatomic, copy)BleProtocolFrameControl *control;
@property (nonatomic, copy)NSString *fns;
@end

@interface BleProtocolFrameControl : NSObject
@property (nonatomic, copy)NSString *reserve;
@property (nonatomic, copy)NSString *directionFlag;
@property (nonatomic, copy)NSString *encryptFlag;
@property (nonatomic, copy)NSString *responseFlag;
@property (nonatomic, copy)NSString *splitFlag;
@end

@interface BleProtocolFrameBody : NSObject

@property (nonatomic, copy)NSString *messageId;
@property (nonatomic, copy)NSString *commandId;
@property (nonatomic, copy)NSString *payload;

@end


@interface TLVPayload : NSObject


@end


NS_ASSUME_NONNULL_END
