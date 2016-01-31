//
//  IAHNoteViewController.h
//  EverPobreCurso
//
//  Created by Izabela on 27/1/16.
//  Copyright © 2016 Izabela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IAHNote.h"

@interface IAHNoteViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *creationViewDate;
@property (weak, nonatomic) IBOutlet UILabel *modificationViewDate;
@property (weak, nonatomic) IBOutlet UITextField *nameView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIToolbar *bootomToolbar;
- (IBAction)displayPhoto:(id)sender;
- (IBAction)addButton:(id)sender;

-(id) initWithModel : (IAHNote *) model;
-(id) initWithNotebook : (IAHNotebook *) notebook withContext: (NSManagedObjectContext *) context;

@end
