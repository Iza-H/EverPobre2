//
//  IAHImageFilter.m
//  EverPobreCurso
//
//  Created by Izabela on 31/1/16.
//  Copyright © 2016 Izabela. All rights reserved.
//

#import "IAHImageFilter.h"
#import "IAHPhotoViewController.h"
@import CoreImage;

@interface IAHImageFilter()
@property (strong, nonatomic) IAHPhotoViewController *pVC;
@end

@implementation IAHImageFilter

-(id) initWithImageViewController: (IAHPhotoViewController *) vc{
    if ( self = [super init]){
        _pVC = vc;
    }
    return self;
}

-(void) updateViewControllerBeforeBackground{
    self.pVC.activityView.hidden=NO;
    [self.pVC.activityView  startAnimating];
    
}

-(void) updateViewontrollerAfterBackgroundWithimage:(UIImage *)image{
    [self.pVC.activityView  stopAnimating];
    self.pVC.activityView.hidden=YES;
    self.pVC.photoView.image = image;
}

-(void) main{
    [self performSelectorOnMainThread:@selector(updateViewControllerBeforeBackground) withObject:nil waitUntilDone:NO];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *image = [CIImage imageWithCGImage:self.pVC.photoView.image.CGImage];
    CIFilter *falseColor = [CIFilter filterWithName:@"CIFalseColor"];
    [falseColor setDefaults];
    [falseColor setValue:image forKey:kCIInputImageKey];
    
    CIFilter *vignette = [CIFilter filterWithName:@"CIVignette"];
    [vignette setDefaults];
    [vignette setValue:@10 forKey:kCIInputIntensityKey];
    
    
    
    CIImage *output = falseColor.outputImage;
    [vignette setValue:output forKey:kCIInputImageKey];
    output = vignette.outputImage;
    
    CGImageRef res = [context createCGImage:output fromRect:[output extent]];
    
    [self performSelectorOnMainThread:@selector(updateViewontrollerAfterBackgroundWithimage:) withObject:[UIImage imageWithCGImage:res] waitUntilDone:NO];
    //liberar la CGIMageRef
    CGImageRelease(res);
    
    
}
    //Un contexto

@end
