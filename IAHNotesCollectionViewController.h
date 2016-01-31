//
//  IAHNotesCollectionViewController.h
//  EverPobreCurso
//
//  Created by Izabela on 31/1/16.
//  Copyright © 2016 Izabela. All rights reserved.
//

#import "AGTCoreDataCollectionViewController.h"

@interface IAHNotesCollectionViewController : AGTCoreDataCollectionViewController
-(id)initWithFetchedResultsController:fc notebook:nb layout:layout;

@end
