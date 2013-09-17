@interface CKMessageComposition : NSObject
@property(copy, nonatomic) NSString *subject;
@property(retain, nonatomic) NSDictionary *resources;
@property(copy, nonatomic) NSString *markupString;
+ (CKMessageComposition *)newComposition;
+ (CKMessageComposition *)newCompositionForText:(NSString *)arg1; // you can use this method if it's an SMS, i.e. text only short message :)
@end

@interface CKMediaObjectManager : NSObject
+ (CKMediaObjectManager *)sharedInstance;
- (id)newMediaObjectForData:(NSData *)arg1 mimeType:(NSString *)arg2 exportedFilename:(id)arg3;
@end

@interface IMFileManager : NSFileManager
+ (IMFileManager *)defaultHFSFileManager;
- (NSString *)MIMETypeOfPath:(NSString *)arg1;
@end

@interface CKMessagePart : NSObject
@end

@class CKMediaObject;
@interface CKMediaObjectMessagePart : CKMessagePart
- (CKMediaObjectMessagePart *)initWithMediaObject:(CKMediaObject *)arg1;
@end

@interface CKContentEntryBridge : NSObject
+ (CKContentEntryBridge *)newContentEntryBridge;
@end

@interface CKWebviewBasedContentEntryBridge : CKContentEntryBridge
- (NSString *)_htmlForMessagePart:(CKMessagePart *)arg1;
@end
