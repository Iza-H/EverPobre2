//
//  IAHMapAnotationObject.m
//  EverPobreCurso
//
//  Created by Izabela on 31/1/16.
//  Copyright © 2016 Izabela. All rights reserved.
//

#import "IAHMapAnotationObject.h"

@implementation IAHMapAnotationObject

-(id) initWithLatitude: (CLLocationDegrees) latitude longitude: (CLLocationDegrees) longitude  title: (NSString *) title{
    if (self = [super init]){
        CLLocationCoordinate2D coords  = CLLocationCoordinate2DMake(latitude, longitude);
        _coordinate=coords;
        if (title!=nil){
            _title = title;
        }
        
    }
    return self;
}



@synthesize coordinate=_coordinate;
@synthesize title=_title;





@end
