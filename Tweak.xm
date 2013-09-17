#import "Tweak.h"

#define IMAGE1 @"/Applications/MobilePhone.app/icon@2x~iphone.png"
#define IMAGE2 @"/Applications/MobileSMS.app/icon@2x.png"
#define SENTENCE @"Composed by MMSComposer"

%hook CKWebviewBasedContentEntryBridge
- (CKMessageComposition *)messageComposition
{
	NSData *data = nil;
	CKMediaObject *mediaObject = nil;
	CKMediaObjectMessagePart *messagePart1 = nil;
	CKMediaObjectMessagePart *messagePart2 = nil;
	CKWebviewBasedContentEntryBridge *bridge = nil;
	NSString *html1 = @"";
	NSString *html2 = @"";
	NSFileManager *fileManager = [NSFileManager defaultManager];

	CKMessageComposition *composition = [CKMessageComposition newComposition];
	[composition setSubject:nil];

	if ([fileManager fileExistsAtPath:IMAGE1])
	{
		data = [NSData dataWithContentsOfFile:IMAGE1];
		mediaObject = [[CKMediaObjectManager sharedInstance] newMediaObjectForData:data mimeType:[[IMFileManager defaultHFSFileManager] MIMETypeOfPath:IMAGE1] exportedFilename:nil];
		messagePart1 = [[CKMediaObjectMessagePart alloc] initWithMediaObject:mediaObject];
		bridge = (CKWebviewBasedContentEntryBridge *)[CKWebviewBasedContentEntryBridge newContentEntryBridge];
		html1 = [bridge _htmlForMessagePart:messagePart1];
	}

	if ([fileManager fileExistsAtPath:IMAGE1])
	{
		data = [NSData dataWithContentsOfFile:IMAGE2];
		mediaObject = [[CKMediaObjectManager sharedInstance] newMediaObjectForData:data mimeType:[[IMFileManager defaultHFSFileManager] MIMETypeOfPath:IMAGE2] exportedFilename:nil];
		messagePart2 = [[CKMediaObjectMessagePart alloc] initWithMediaObject:mediaObject];
		bridge = (CKWebviewBasedContentEntryBridge *)[CKWebviewBasedContentEntryBridge newContentEntryBridge];
		html2 = [bridge _htmlForMessagePart:messagePart2];
	}
	/*
	   SENTENCE
	   IMAGE1
	   IMAGE2	
	 */
	NSString *htmlString = [[SENTENCE stringByAppendingString:html1] stringByAppendingString:html2];

	/*
	   IMAGE1
	   SENTENCE
	   IMAGE2
	   NSString *htmlString = [[html1 stringByAppendingString:SENTENCE] stringByAppendingString:html2];
	 */

	[composition setMarkupString:htmlString];

	NSString *idString1 = [html1 substringWithRange:NSMakeRange(9, 36)];
	NSString *idString2 = [html2 substringWithRange:NSMakeRange(9, 36)];
	NSDictionary *resources = [NSDictionary dictionaryWithObjectsAndKeys:messagePart1, idString1, messagePart2, idString2, nil];
	[composition setResources:resources];
	[messagePart1 release];
	[messagePart2 release];

	return composition;
}
%end
