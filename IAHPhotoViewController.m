//
//  IAHPhotoViewController.m
//  EverPobreCurso
//
//  Created by Izabela on 29/1/16.
//  Copyright © 2016 Izabela. All rights reserved.
//

#import "IAHPhotoViewController.h"
#import "IAHNote.h"
#import "IAHPhoto.h"
#import "IAHImageFilter.h"
@import UIKit;

@interface IAHPhotoViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteButton;
@property (nonatomic) BOOL isModelImageEmpty;
@property (nonatomic) BOOL shouldSaveImageToModel;
@property (nonatomic, strong) IAHNote *model;
@property (nonatomic, strong) NSOperationQueue *queue;
@end

@implementation IAHPhotoViewController

-(id) initWitModel : (IAHNote *) note{
    if (self == [super initWithNibName:nil bundle:nil]) {
        _model = note;
        _queue = [[NSOperationQueue alloc] init];
        if (note.photo.imageData == nil ){
            _shouldSaveImageToModel = NO;
        } else{
            _shouldSaveImageToModel = YES;
        }

    }
    return self;
    
}

- (IBAction)takePhoto:(id)sender {
    //Creae un Image Picker
    UIImagePickerController *pVC = [[UIImagePickerController alloc] init];
    
    //Configurarlo
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        pVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        
    }else{
        pVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    //Hacerme su delegado
    pVC.delegate = self;
    
    //Mostararlo
    [self presentViewController:pVC animated:YES completion:nil];
    
    self.deleteButton.enabled = NO;
    self.vintageButton.enabled = NO;
    
}
- (IBAction)applayFilter:(id)sender {
    IAHImageFilter *f = [[IAHImageFilter alloc]initWithImageViewController:self];
    [self.queue addOperation:f];
    
}
- (IBAction)delete:(id)sender {
    CGRect oldBounds = self.photoView.bounds;
    [UIView animateWithDuration:0.8 animations:^{
        self.photoView.alpha = 0;
        self.photoView.bounds = CGRectZero;
        self.photoView.transform = CGAffineTransformMakeRotation(M_2_PI);
    } completion:^(BOOL finished) {
        self.model.photo.image = nil;
        self.photoView.image = nil;
        self.deleteButton.enabled = NO;
        self.vintageButton.enabled=NO;
        self.photoView.alpha = 1;
        self.photoView.bounds = oldBounds;
        self.photoView.transform = CGAffineTransformIdentity;
    }];
    
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.activityView.hidden=YES;
    
    self.title = self.model.name;
    if (self.model.photo.imageData !=nil){
        self.photoView.image = self.model.photo.image;
        self.shouldSaveImageToModel = YES;
    }else{
        self.photoView.image  = [UIImage imageNamed:@"img_not_avalaible.png"];
        self.shouldSaveImageToModel = NO;
    }
    self.deleteButton.enabled = self.shouldSaveImageToModel;
    self.vintageButton.enabled =self.shouldSaveImageToModel;
}
            
-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if(self.shouldSaveImageToModel) {
        self.model.photo.image = self.photoView.image;
    }
}

#pragma mark - UIIMagePickerControllerDelegate
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.shouldSaveImageToModel =YES;
    self.model.photo.image = img;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
}

@end
