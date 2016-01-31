#import "_IAHNote.h"

@class IAHNotebook;


@interface IAHNote : _IAHNote {}
// Custom logic goes here.
@property (nonatomic, readonly) BOOL hasLocation;

+(instancetype) noteWithName:(NSString *) name notebook: (IAHNotebook *) notebook  context:(NSManagedObjectContext *) context;
+(instancetype) noteWithName:(NSString *) name notebook: (IAHNotebook*) notebook latitude: (NSNumber *) latitude longitude: (NSNumber *) longitude address: (NSString *) address context:(NSManagedObjectContext *) context;
@end
