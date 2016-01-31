//
//  IAHNotebooksViewController.m
//  EverPobreCurso
//
//  Created by Izabela on 24/1/16.
//  Copyright © 2016 Izabela. All rights reserved.
//

#import "IAHNotebooksViewController.h"
#import "IAHNotebook.h"
#import "IAHNote.h"
#import "IAHNotesViewController.h"

@interface IAHNotebooksViewController ()

@end

@implementation IAHNotebooksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Ever Pobre";
    UIBarButtonItem *bt = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewNoteBook:)];
    self.navigationItem.rightBarButtonItem = bt;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"NotebookCell";
    //Averiguar que libreta es
    IAHNotebook *nb = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //Crear la celda
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.textLabel.text = nb.name;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateStyle = NSDateFormatterShortStyle;
    cell.detailTextLabel.text = [fmt stringFromDate:nb.modificationDate];
    //Sincronizar libreta ->celda
    
    return cell;
}

-(void) addNewNoteBook:(id) sender{
    [IAHNotebook notebookWithName:@"New Notebook" context:self.fetchedResultsController.managedObjectContext];
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //Obtener la libreta
    IAHNotebook *nb = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //Crear el fetch request
    NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:[IAHNote entityName]];
    req.fetchBatchSize = 25;
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:IAHNoteAttributes.name ascending:YES selector:@selector(caseInsensitiveCompare:)],
                            [NSSortDescriptor sortDescriptorWithKey:IAHNoteAttributes.modificationDate ascending:NO]];
    
    
    
    //configuarlo con un predicato
    req.predicate = [NSPredicate predicateWithFormat: @"notebook == %@", nb];
    
    //Crear FetchResults
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc] initWithFetchRequest:req managedObjectContext:nb.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    //Crear el controlador
    IAHNotesViewController *nVC = [[IAHNotesViewController alloc] initWithFetchedResultsController:fc style:UITableViewStylePlain notebook:nb];
    [self.navigationController pushViewController:nVC animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
