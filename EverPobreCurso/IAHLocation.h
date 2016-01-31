#import "_IAHLocation.h"
@import CoreLocation;

@interface IAHLocation : _IAHLocation {}
// Custom logic goes here.

+(instancetype)locationWithCLLocation: (CLLocation *) loc forNote: (IAHNote *) note;
+(instancetype)locationWithLongitude:(NSNumber *)longitude latitude: (NSNumber *) latitude address: (NSString*) address context:(NSManagedObjectContext *) context;
@end
