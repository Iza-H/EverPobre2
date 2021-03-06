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
#import "IAHNotesCollectionViewController.h"




@interface IAHNotebooksViewController ()
@property (nonatomic, strong) NSString* notebookNameNew;

@end

@implementation IAHNotebooksViewController



    

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"EverPobre";
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

#pragma mark - New Notebook
-(void) addNewNoteBook:(id) sender{
    self.notebookNameNew=nil;
    //[IAHNotebook notebookWithName:@"New Notebook" context:self.fetchedResultsController.managedObjectContext];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"New notebook" message:@"Put a name of the notbook" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [IAHNotebook notebookWithName:self.notebookNameNew context:self.fetchedResultsController.managedObjectContext];
    }]];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Name:";
        textField.secureTextEntry = NO;
        [textField addTarget:self
                      action:@selector(alertTextFieldDidChange:)
            forControlEvents:UIControlEventEditingChanged];
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)alertTextFieldDidChange:(UITextField *)sender
{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController)
    {
        UITextField *newNotebookTextField = alertController.textFields.firstObject;
        self.notebookNameNew=newNotebookTextField.text;
    }
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
    
    
   
    
    // Fetched Results Controller
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc]
                                      initWithFetchRequest:req
                                      managedObjectContext:self.fetchedResultsController.managedObjectContext
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
    IAHNotesCollectionViewController *nVC = [[IAHNotesCollectionViewController alloc]initWithFetchedResultsController:fc notebook:nb layout:layout];
    
    // Push it!
    nVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nVC
                                         animated:YES];
    
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
