//
//  IAHNotesViewController.m
//  EverPobreCurso
//
//  Created by Izabela on 26/1/16.
//  Copyright © 2016 Izabela. All rights reserved.
//

#import "IAHNotesViewController.h"
#import "IAHNote.h"
#import "IAHPhoto.h"
#import "IAHNotebook.h"
#import "IAHNoteViewController.h"

@interface IAHNotesViewController ()
@property (nonatomic, strong) IAHNotebook *notebook;
@end

@implementation IAHNotesViewController

-(id) initWithFetchedResultsController:(NSFetchedResultsController *)aFetchedResultsController style:(UITableViewStyle)aStyle notebook: (IAHNotebook*) notebook{
    if (self = [super initWithFetchedResultsController:aFetchedResultsController style:aStyle]){
        _notebook = notebook;
    }
    return self;
}

#pragma mark - Data Source
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //Obtener la nota
    static NSString *cellID = @"NoteCell";
    IAHNote *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //Crear la celda
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if  (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    //Sinc
    cell.imageView.image = note.photo.image;
    cell.textLabel.text = note.name;
    cell.detailTextLabel.text = note.text; //Corta la longitud plus puntos
    
    
    //Devolver la celda
    return cell;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewNote:)];
    self.navigationItem.rightBarButtonItem = item;
    // Do any additional setup after loading the view.
}

-(void)addNewNote:(id) sender{
    [IAHNote noteWithName:@"Nueva nota" notebook:self.notebook context:self.notebook.managedObjectContext];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    IAHNote *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    IAHNoteViewController *nVC = [[IAHNoteViewController alloc]initWithModel:note];
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
