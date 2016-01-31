#import "IAHNotebook.h"

@interface IAHNotebook ()

// Private interface goes here.

@end

@implementation IAHNotebook

+(NSArray *) observableKeys{
    return @[@"name", @"notes"];
}
// Custom logic goes here.
+(instancetype) notebookWithName:(NSString *) name context: (NSManagedObjectContext *) context{
    IAHNotebook *nb = [self insertInManagedObjectContext:context];
    nb.name = name;
    nb.creationDate = [NSDate date];
    nb.modificationDate = [NSDate date];
    return nb;
}

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
