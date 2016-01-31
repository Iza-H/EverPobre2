#import "IAHLocation.h"
#import "IAHNote.h"
@import AddressBookUI;

@interface IAHLocation ()



@end

@implementation IAHLocation


+(instancetype)locationWithCLLocation: (CLLocation *) loc forNote: (IAHNote *) note{
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[IAHLocation entityName]];
    NSPredicate *latitude = [NSPredicate predicateWithFormat:@"abs(latitude) - abs(%lf) < 0.001", loc.coordinate.latitude ];
    NSPredicate *longitude = [NSPredicate predicateWithFormat:@"abs(longitude) -abs(%lf) <0.001", loc.coordinate.longitude];
    req.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[latitude, longitude]];
    
    NSError *error =nil;
    NSArray *results = [note.managedObjectContext executeFetchRequest:req error:&error];
    NSAssert(results, @"Error al buscar");
    
    if([results count]){
        IAHLocation *found = [results
                              lastObject];
        [found addNotesObject:note];
        return found;
    }else{
        IAHLocation *location = [self insertInManagedObjectContext:note.managedObjectContext];
        location.latitudeValue = loc.coordinate.latitude;
        location.longitudeValue = loc.coordinate.latitude;
        [location addNotesObject:note];
        
        //Direcion:
        CLGeocoder *coder = [[CLGeocoder alloc] init];
        [coder reverseGeocodeLocation:loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if(error){
                NSLog(@"Error while obtaining address: %@", error);
            }
            location.address = ABCreateStringWithAddressDictionary([[placemarks lastObject] addressDictionary], YES);
        }];
        return location;
    }
    
    
    
}

@end
