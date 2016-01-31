//
//  IAHMapAnotationObject.h
//  EverPobreCurso
//
//  Created by Izabela on 31/1/16.
//  Copyright © 2016 Izabela. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface IAHMapAnotationObject : NSObject<MKAnnotation>

-(id) initWithLatitude: (CLLocationDegrees) latitude longitude: (CLLocationDegrees) longitude title: (NSString *) title;

@end
