//
//  IAHNotesCollectionViewController.m
//  EverPobreCurso
//
//  Created by Izabela on 31/1/16.
//  Copyright © 2016 Izabela. All rights reserved.
//

#import "IAHNotesCollectionViewController.h"
#import "IAHNote.h"
#import "IAHNoteViewCellCollectionViewCell.h"
#import "IAHPhoto.h"
#import "IAHNoteViewController.h"



static NSString *cellId = @"NoteCellId";

@interface IAHNotesCollectionViewController ()
@property (nonatomic, strong) IAHNotebook *notebook;
@end

@implementation IAHNotesCollectionViewController

-(id)initWithFetchedResultsController:fc notebook:nb layout:layout{
    if (self = [super initWithFetchedResultsController:fc layout:layout]){
        _notebook = nb;
    }
    return self;
}

#pragma mark -  View Lifecicle
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self registerCell];
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
}

#pragma mark - cell registration
-(void) registerCell{
    
    UINib *nib = [UINib nibWithNibName:@"IAHNoteCollectionViewCell"
                                bundle:nil];
    [self.collectionView registerNib:nib
          forCellWithReuseIdentifier:cellId];
}

#pragma mark - Data Source
-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    

    IAHNote *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Cell
    IAHNoteViewCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId
                                                                      forIndexPath:indexPath];
    //Settings:
    cell.titleView.text = note.name;
    if (note.photo.image!=nil){
       cell.photoView.image = note.photo.image;
    }else {
        cell.photoView.image  = [UIImage imageNamed:@"img_not_avalaible.png"];
    }

    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateStyle = NSDateFormatterMediumStyle;
    //cell.modyficationDateView.text = [fmt stringFromDate:note.modificationDate];
    

    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewNote:)];
    self.navigationItem.rightBarButtonItem = item;
    // Do any additional setup after loading the view.
}

-(void)addNewNote:(id) sender{
    //[IAHNote noteWithName:@"Nueva nota" notebook:self.notebook context:self.notebook.managedObjectContext];
    IAHNoteViewController *nVC = [[IAHNoteViewController alloc]initWithNotebook:self.notebook withContext: self.fetchedResultsController.managedObjectContext];
    [self.navigationController pushViewController:nVC animated:YES];
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    IAHNote *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    IAHNoteViewController *nVC = [[IAHNoteViewController alloc]initWithModel:note];
    [self.navigationController pushViewController:nVC animated:YES];
}

@end




