//
//  AppDelegate.m
//  EverPobreCurso
//
//  Created by Izabela on 20/1/16.
//  Copyright © 2016 Izabela. All rights reserved.
//

#import "AppDelegate.h"
#import "IAHNotebook.h"
#import "IAHNote.h"
#import "AGTSimpleCoreDataStack.h"
#import "IAHNotebooksViewController.h"
#import "UIViewController+Navigation.h"
#import "Settings.h"
#import "IAHLocation.h"
#import "IAHMapViewController.h"


@interface AppDelegate ()
@property (strong, nonatomic) AGTSimpleCoreDataStack *model;

@end

@implementation AppDelegate


-(void) createDummyData{
    IAHNotebook *nb = [IAHNotebook notebookWithName:@"Ex novias para el recuerdo" context:self.model.context];
    /*[self.model saveWithErrorBlock:^(NSError *error) {
        NSLog(@"La cagamos");
    }];*/
    IAHNotebook *l = [IAHNotebook notebookWithName:@"Lugares" context:self.model.context];
    [IAHNote noteWithName:@"Pampita" notebook:nb context:self.model.context];
    [IAHNote noteWithName:@"Camila" notebook:nb context:self.model.context];
    [IAHNote noteWithName:@"Mariana" notebook:nb context:self.model.context];
    [IAHNote noteWithName:@"Belen" notebook:nb latitude: @41.3827416 longitude:  @1.32880926 address: @"Casa" context:self.model.context];
    
    [IAHNote noteWithName:@"Parla" notebook:l context:self.model.context];
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[IAHNote entityName]];
    req.fetchBatchSize = 25;
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:IAHNoteAttributes.name ascending:YES selector:@selector(caseInsensitiveCompare:)]];
    req.predicate = [NSPredicate predicateWithFormat:@"notebook == %@", nb];
    NSArray *res = [self.model executeRequest:req withError:^(NSError *error) {
        NSLog(@"La cagaste");
    }];
    NSLog(@"%@", res);
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.model = [AGTSimpleCoreDataStack coreDataStackWithModelName:@"Model"];
    
    if (ADD_DUMY_DATA){
        [self.model zapAllData];
        [self createDummyData];
        
        
    }
    if (AUTO_SAVE){
        [self autoSave];
    }
   
    
    
    
    //NSFetchReques
    NSFetchRequest *r = [NSFetchRequest fetchRequestWithEntityName:[IAHNotebook entityName]];
    r.fetchBatchSize = 25;
    r.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:IAHNotebookAttributes.name ascending:YES selector: @selector(caseInsensitiveCompare:)], [NSSortDescriptor sortDescriptorWithKey:IAHNotebookAttributes.modificationDate ascending:NO]];
    //NSFertchResult
    
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc] initWithFetchRequest:r managedObjectContext:self.model.context sectionNameKeyPath:nil cacheName:nil];
    
    IAHNotebooksViewController *tVC = [[IAHNotebooksViewController alloc] initWithFetchedResultsController:fc style: UITableViewStylePlain];
    //self.window.rootViewController = [tVC wrappedInNavigation];
    
    
    NSFetchRequest *locreq = [NSFetchRequest fetchRequestWithEntityName:[IAHLocation entityName]];
    NSError *error =nil;
    NSArray *results = [self.model.context executeFetchRequest:locreq error:&error];
    NSAssert(results, @"Error al buscar");

    
    IAHMapViewController *mVC = [[IAHMapViewController alloc] initWithLocationArray:results context:self.model.context];

    
    
    UITabBarController *tC = [[UITabBarController alloc] init];
    tC.viewControllers = @[[tVC wrappedInNavigation], [mVC wrappedInNavigationWithTitleForTabBar: @"Map"]];
    self.window.rootViewController = tC;
    
    [self.window makeKeyAndVisible];
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    [self.model saveWithErrorBlock:^(NSError *error){
        NSLog(@"Error al guardar en resignActive");
    }];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self.model saveWithErrorBlock:^(NSError *error){
        NSLog(@"Error al guardar en editBackground");
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



-(void) autoSave{
    [self.model saveWithErrorBlock:^(NSError *error) {
        NSLog(@"Error al autoguardar!");
    }];
    
    //asignamos la siguiente llamada:
    NSLog(@"AutoGuardado");
    [self performSelector:@selector(autoSave) withObject:nil afterDelay:AUTOSAVE_DELAY];
}

















@end
