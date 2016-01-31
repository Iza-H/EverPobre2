#import "_IAHNote.h"

@class IAHNotebook;
@interface IAHNote : _IAHNote {}
// Custom logic goes here.

+(instancetype) noteWithName:(NSString *) name notebook: (IAHNotebook *) notebook  context:(NSManagedObjectContext *) context;
@end
