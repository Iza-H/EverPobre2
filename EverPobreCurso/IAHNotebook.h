#import "_IAHNotebook.h"

@interface IAHNotebook : _IAHNotebook {}
// Custom logic goes here.

+(instancetype) notebookWithName:(NSString *) name context: (NSManagedObjectContext *) context;

@end
