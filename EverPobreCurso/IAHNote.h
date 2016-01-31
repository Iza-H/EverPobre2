#import "_IAHNote.h"

@class IAHNotebook;


@interface IAHNote : _IAHNote {}
// Custom logic goes here.
@property (nonatomic, readonly) BOOL hasLocation;

+(instancetype) noteWithName:(NSString *) name notebook: (IAHNotebook *) notebook  context:(NSManagedObjectContext *) context;
@end
