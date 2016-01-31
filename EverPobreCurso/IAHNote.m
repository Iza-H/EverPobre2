#import "IAHNote.h"
#import "IAHPhoto.h"
#import "IAHNotebook.h"
#import "IAHLocation.h"
@import CoreLocation;

@interface IAHNote ()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *lm;

// Private interface goes here.

@end

@implementation IAHNote

@synthesize lm=_lm;

-(BOOL)hasLocation{
    return (nil != self.location);
}

+(NSArray *) observableKeys{
    return @[@"name", @"text", @"notebook", @"photo.imageData", @"location"];
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
    
    CLAuthorizationStatus status  = [CLLocationManager authorizationStatus];
    if ((status==kCLAuthorizationStatusAuthorizedAlways || status==kCLAuthorizationStatusNotDetermined)&&[CLLocationManager locationServicesEnabled]){
        self.lm = [[CLLocationManager alloc] init];
        self.lm.delegate = self;
        self.lm.desiredAccuracy = kCLLocationAccuracyBest;
        [self.lm startUpdatingLocation];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self zapLocationManager];
        });
        
    }
    
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

#pragma mark - CLLocationManagerDelegate
-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [self zapLocationManager];
    
    if(![self hasLocation]){
        //Ultima localizacion
        CLLocation *loc = [locations lastObject];
        self.location = [IAHLocation locationWithCLLocation: loc forNote: self];
    }
    
    
}



-(void)zapLocationManager{
    [self.lm stopUpdatingLocation];
    self.lm.delegate = nil;
    self.lm = nil;
}

@end
