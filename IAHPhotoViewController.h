//
//  IAHPhotoViewController.h
//  EverPobreCurso
//
//  Created by Izabela on 29/1/16.
//  Copyright © 2016 Izabela. All rights reserved.
//

@import UIKit;
@class IAHNote;

@interface IAHPhotoViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *vintageButton;
-(id) initWitModel : (IAHNote *) note;

@end
