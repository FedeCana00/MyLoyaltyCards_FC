//
//  ImagePickerViewController.m
//  MyLoyaltyCard_FC
//
//  Created by Fede Cana on 11/05/2021.
//  Copyright © 2021 Fede Cana. All rights reserved.
//

#import "ImagePickerViewController.h"

@interface ImagePickerViewController ()

@end

@implementation ImagePickerViewController

- (void)viewDidLoad{
    @try{
        [super viewDidLoad];
        if([self startCameraController]){
            NSLog(@"Image picker controller avviato!");
        }
    } @catch(NSException *ex){
        NSLog(@"Error => %@", ex.reason);
    }
}


/* assume the view controller conforms to UIImagePickerControllerDelegate and UINavigationControllerDelegate */
- (BOOL)startCameraController{
    @try{
        /* first check whether the camera is available for use */
        if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] == NO))
            return NO;
        /* create an image picker controller and set its sourceType property */
        UIImagePickerController *camera = [[UIImagePickerController alloc] init];
        camera.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        /* Displays a control that allows the user to choose picture or movie capture, if both are available */
        camera.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        /* hide the controls for moving and scaling pictures */
        camera.allowsEditing = NO;
        /* set the delegate for the image picker controller */
        camera.delegate = self;
        /* present the image picker controller modally */
        camera.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:camera animated:YES completion:nil];
        return YES;
    }@catch(NSException *ex){
        NSLog(@"Error => %@", ex.reason);
    }
}

/*  Responding to the user Cancel (dismiss the image picker controller) */
- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    /* Dismiss the image picker controller */
    //[picker.parentViewController dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController  popViewControllerAnimated:YES];
}
/* Responding to the user user accepting a newly-captured picture or movie */
/* The info argument is a dictionary containing the original image and the edited image, if an image was picked; or a filesystem URL for the movie, if a movie was picked */
- (void) imagePickerController:(UIImagePickerController *)picker
 didFinishPickingMediaWithInfo:(NSDictionary *)info{
     @try{
         NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
         //create a path where store image
         UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
         NSString *imageName = [self.cardName stringByAppendingString:@".png"];
         NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES);
         NSString *documentsDirectory = [paths objectAtIndex:0];
         NSString* path = [documentsDirectory stringByAppendingPathComponent:
                           imageName ];
         NSData* data = UIImagePNGRepresentation(originalImage);
         [data writeToFile:path atomically:YES];
         //----------------------------------------
        
         
        /*  Handle still image capture */
        if (CFStringCompare((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo){
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"gotImage"   // notification name
                                                                object:self                         // notification sender (this object)
                                                              userInfo:@{@"URL":path}];                       // additional info
            NSLog(@"URL => %@", path);
            /*  Dismiss the image picker controller */
            //[picker.parentViewController dismissViewControllerAnimated:YES completion:nil];
            [self.navigationController  popViewControllerAnimated:YES];
        }
        /*  Handle video capture */
        if (CFStringCompare((CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo)
        {
            /* ... */
        }
    } @catch(NSException *ex){
         NSLog(@"Error => %@", ex.reason);
     }
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
