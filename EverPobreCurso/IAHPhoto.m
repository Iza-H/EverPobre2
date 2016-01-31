#import "IAHPhoto.h"

@interface IAHPhoto ()

// Private interface goes here.

@end

@implementation IAHPhoto

// Custom logic goes here.

-(UIImage *) image{
    return [UIImage imageWithData:self.imageData];
}
-(void) setImage:(UIImage*) image{
    [self setImageData:UIImageJPEGRepresentation(image, 1.0f)];
}

@end
