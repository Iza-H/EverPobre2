//
//  IAHNoteViewController.m
//  EverPobreCurso
//
//  Created by Izabela on 27/1/16.
//  Copyright © 2016 Izabela. All rights reserved.
//

#import "IAHNoteViewController.h"
#import "IAHNote.h"
#import "IAHPhotoViewController.h"

@interface IAHNoteViewController ()

@property(strong,nonatomic) IAHNote *model;
@property (nonatomic) CGRect oldFrame;
@property (nonatomic) double animationDuration;
@property (nonatomic) BOOL isKeyboardVisible;

@end

@implementation IAHNoteViewController

-(id) initWithModel : (IAHNote *) model{
    if (self = [super initWithNibName:nil bundle:nil]){
        _model = model;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isKeyboardVisible=NO;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //sincronizacion:
    NSDateFormatter * frm = [[NSDateFormatter alloc] init];
    frm.dateStyle = NSDateFormatterShortStyle;
    self.creationViewDate.text = [frm stringFromDate:self.model.creationDate];
    self.modificationViewDate.text = [frm stringFromDate:self.model.modificationDate];
    
    self.textView.text = self.model.text;
    self.nameView.text = self.model.name;
    
    //Alta de notificaciones de teclado
    
    [self startOvservingKeyboard];
    
    
    
}
-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.model.text = self.textView.text;
    self.model.name = self.nameView.text;
    
    //Baja de notificaciones del teclado
    
    [self stopOvservingKeyboard];
    
    
}

#pragma mark - Notifications
-(void)startOvservingKeyboard{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    

    
}

-(void)stopOvservingKeyboard{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}
-(void) keyboardWillAppear:(NSNotification *)note{
    if (self.isKeyboardVisible==NO){
        self.isKeyboardVisible=YES;
        NSDictionary *info = note.userInfo;
        self.animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey]doubleValue];
        CGRect oldFrame = self.textView.frame;
        CGRect kbbFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
        
        CGRect newFrame = CGRectMake(oldFrame.origin.x,oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height-kbbFrame.size.height + self.bootomToolbar.bounds.size.height );
        
        [UIView animateWithDuration:self.animationDuration animations:^{
            self.textView.frame = newFrame;
        }];
      }
}
    
    
    

-(void) keyboardWillDisappear:(NSNotification *)note{
    self.isKeyboardVisible=NO;
    NSDictionary *info = note.userInfo;
    CGRect oldFrame = self.textView.frame;
    CGRect kbbFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGRect newFrame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height + kbbFrame.size.height - self.bootomToolbar.bounds.size.height);
    [UIView animateWithDuration:self.animationDuration animations:^{
         self.textView.frame = newFrame;
    }];
    self.isKeyboardVisible= FALSE;
    
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)displayPhoto:(id)sender {
    IAHPhotoViewController *pVC = [[IAHPhotoViewController alloc] initWitModel:self.model];
    [self.navigationController  pushViewController:pVC animated:YES];
    
}

-(IBAction)removeKeyboard:(id)sender{
    //[self.nameView resignFirstResponder];
    [self.view endEditing:YES];
}
@end
