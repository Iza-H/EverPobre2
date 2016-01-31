//
//  IAHNotesViewController.h
//  EverPobreCurso
//
//  Created by Izabela on 26/1/16.
//  Copyright © 2016 Izabela. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreData;
@class IAHNotebook;

#import "AGTCoreDataTableViewController.h"  //por herencia no puede ser class




@interface IAHNotesViewController : AGTCoreDataTableViewController

-(id) initWithFetchedResultsController:(NSFetchedResultsController *)aFetchedResultsController style:(UITableViewStyle)aStyle notebook: (IAHNotebook*) notebook;



@end
