//
//  IAHMapViewController.h
//  EverPobreCurso
//
//  Created by Izabela on 31/1/16.
//  Copyright © 2016 Izabela. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;
@import CoreData;

@interface IAHMapViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView;


-(id) initWithLocationArray: (NSArray *) results context: (NSManagedObjectContext *)context;
@end
