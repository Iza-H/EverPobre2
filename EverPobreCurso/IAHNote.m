#import "IAHNote.h"
#import "IAHPhoto.h"
#import "IAHNotebook.h"

@interface IAHNote ()

// Private interface goes here.

@end

@implementation IAHNote

+(NSArray *) observableKeys{
    return @[@"name", @"text", @"notebook", @"photo.imageData"];
}

+(instancetype) noteWithName:(NSString *) name notebook: (IAHNotebook*) notebook context:(NSManagedObjectContext *) context{
    IAHNote *note =[self insertInManagedObjectContext:context];
    note.name = name;
    note.notebook=notebook;
    note.creationDate = [NSDate date];
    note.modificationDate = [NSDate date];
    note.photo=[IAHPhoto insertInManagedObjectContext:context];
    return note;
}

// Custom logic goes here.
-(void) awakeFromInsert{
    [super awakeFromInsert];
    [self setupKVO];
}

-(void) awakeFromFetch{
    [super awakeFromFetch];
    [self setupKVO];
    
}

-(void) willTurnIntoFault{
    [super willTurnIntoFault];
    [self tearDownKVO];
}


-(void) setupKVO{
    for(NSString *key in [self.class observableKeys]){
        [self addObserver:self forKeyPath:key options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    }
    
    
    
    
    
    
    
    
    
    
}

-(void) tearDownKVO{
    for(NSString *key in [self.class observableKeys]){
        [self removeObserver:self forKeyPath:key];
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}



-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    self.modificationDate = [NSDate date];
}



@end
