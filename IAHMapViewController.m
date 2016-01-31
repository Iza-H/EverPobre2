//
//  IAHMapViewController.m
//  EverPobreCurso
//
//  Created by Izabela on 31/1/16.
//  Copyright © 2016 Izabela. All rights reserved.
//

#import "IAHMapViewController.h"
#import "IAHMapAnotationObject.h"
#import "IAHLocation.h"
#import "IAHNote.h"
#import "IAHNotesCollectionViewController.h"
@import MapKit;

@interface IAHMapViewController ()<MKMapViewDelegate>
@property (strong, nonatomic) NSArray *model;
@property (strong, nonatomic) IAHMapAnotationObject *zoomObject;
@property (strong, nonatomic) NSManagedObjectContext *context;

@end

@implementation IAHMapViewController

-(id) initWithLocationArray: (NSArray *) results context: (NSManagedObjectContext *)context{
    if(self= [super initWithNibName:nil bundle:nil]){
        _model = results;
        _context = context;
        self.tabBarItem.title = @"Map";
        
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    for (IAHLocation *item in self.model){
        CLLocationDegrees longitude = (CLLocationDegrees)[item.longitude doubleValue];
        CLLocationDegrees latitude = (CLLocationDegrees)[item.latitude doubleValue];
        IAHMapAnotationObject *annObject = [[IAHMapAnotationObject alloc] initWithLatitude:latitude longitude:longitude  title:item.address];
        if (self.zoomObject==nil){
            self.zoomObject=annObject;
        }
        [self.mapView addAnnotation:annObject];
    }
    
}
-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.mapView.delegate=self;
    MKCoordinateRegion countryRegion = MKCoordinateRegionMakeWithDistance(self.zoomObject.coordinate, 1000000, 1000000);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.mapView setRegion:countryRegion animated:YES];
    });
}

#pragma mark - MKMapViewDelegate
-(MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    static NSString *reuseId=@"MpInfoID";
    MKPinAnnotationView *annotationInfo =(MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseId];
    if(annotationInfo==nil){
        annotationInfo = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseId];
        annotationInfo.canShowCallout = YES;
        annotationInfo.userInteractionEnabled = YES;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        //[btn addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
        [annotationInfo setRightCalloutAccessoryView:btn];
        
    }
    return annotationInfo;
}

-(void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    NSLog(@"Clicked");
    //Crear el fetch request
    NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:[IAHNote entityName]];
    req.fetchBatchSize = 25;
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:IAHNoteAttributes.name ascending:YES selector:@selector(caseInsensitiveCompare:)],
                            [NSSortDescriptor sortDescriptorWithKey:IAHNoteAttributes.modificationDate ascending:NO]];
    
    
    
    //predicate
    req.predicate = [NSPredicate predicateWithFormat:@"location.address == %@",  [view.annotation title]];
    
    
    
    // Fetched Results Controller
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc]
                                      initWithFetchRequest:req
                                      managedObjectContext:self.context
                                      sectionNameKeyPath:nil
                                      cacheName:nil];
    
    // layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 5;
    layout.itemSize = CGSizeMake(120, 150);
    layout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    
    // View controller
    IAHNotesCollectionViewController *nVC = [IAHNotesCollectionViewController coreDataCollectionViewControllerWithFetchedResultsController:fc layout:layout];
    
    // Push it!
    nVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nVC
                                         animated:YES];
    

}








@end
