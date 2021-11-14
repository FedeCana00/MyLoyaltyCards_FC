//
//  CardViewController.m
//  MyLoyaltyCard_FC
//
//  Created by Fede Cana on 07/05/2021.
//  Copyright © 2021 Fede Cana. All rights reserved.
//

#import "CardViewController.h"
#import "CardDetailTableViewController.h"

@interface CardViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageViewOfCard;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewOfLogo;
- (CIImage*)generateBarcode;
- (CIImage *)generateQrcode;
@property (weak, nonatomic) IBOutlet UILabel *colorCardLabel;
@property (weak, nonatomic) IBOutlet UILabel *codiceClienteLabel;
@property(nonatomic, strong) UIColor *backgroundColor;
- (void)getCardColor;

@end

@implementation CardViewController

- (void)viewDidLoad {
    @try{
        [super viewDidLoad];
        //imposto il titolo della View
        self.title = self.showCard.nomeAzienda;
        //genero e setto il barcode oppure il qrcode
        if([self.showCard.formatoCodice isEqualToString:@"Barcode"]){
            CIImage *barcode = [self generateBarcode];
            UIImage *barcodeImage = [[UIImage alloc] initWithCIImage:barcode];
            self.imageViewOfCard.image = barcodeImage;
        } else if([self.showCard.formatoCodice isEqualToString: @"QRcode"]){
            CIImage *qrcode = [self generateQrcode];
            UIImage *qrcodeImage = [[UIImage alloc] initWithCIImage:qrcode];
            self.imageViewOfCard.image = qrcodeImage;
        } else {
            NSLog(@"Errore nessun formato del codice corrisponde!");
        }
        //genero e assegno il colore della carta
        [self getCardColor];
        self.colorCardLabel.backgroundColor = self.backgroundColor;
        //imposto il codice cliente nella label che lo visualizza
        self.codiceClienteLabel.text = self.showCard.codiceCliente;
        //imposto il logo della carta
        UIImage *imageLogo = [UIImage imageWithContentsOfFile:self.showCard.logo];
        self.imageViewOfLogo.image = imageLogo;
    } @catch(NSException *ex){
        NSLog(@"Errore in CardViewController => %@",ex.reason);
    }
}

-(CIImage*)generateBarcode{
    
    CIFilter *barCodeFilter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    NSData *barCodeData = [self.showCard.codiceCliente dataUsingEncoding:NSASCIIStringEncoding];
    [barCodeFilter setValue:barCodeData forKey:@"inputMessage"];
    [barCodeFilter setValue:[NSNumber numberWithFloat:0] forKey:@"inputQuietSpace"];
    
    CIImage *barCodeImage = barCodeFilter.outputImage;
    return barCodeImage;
}

- (CIImage *)generateQrcode{
    NSData *stringData = [self.showCard.codiceCliente dataUsingEncoding: NSISOLatin1StringEncoding];
    
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    
    return qrFilter.outputImage;
}

-(void) getCardColor{
    if([self.showCard.coloreSfondo  isEqual:@"Red"]){
        self.backgroundColor = [[UIColor alloc] initWithRed:1 green:0 blue:0 alpha:1];
    } else if([self.showCard.coloreSfondo  isEqual:@"Green"]){
        self.backgroundColor = [[UIColor alloc] initWithRed:0 green:1 blue:0 alpha:1];
    } else if([self.showCard.coloreSfondo  isEqual:@"Blue"]){
        self.backgroundColor = [[UIColor alloc] initWithRed:0 green:0 blue:1 alpha:1];
    }   else if([self.showCard.coloreSfondo  isEqual:@"Yellow"]){
        self.backgroundColor = [[UIColor alloc] initWithRed:1 green:1 blue:0 alpha:1];
    } else {
        NSLog(@"Errore colore non corrispondente con quelli assegnati!");
    }
}

- (IBAction)infoButtonTapped:(id)sender {
    [self performSegueWithIdentifier: @"showCardDetail" sender: self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showCardDetail"]){
        if([segue.destinationViewController isKindOfClass:[CardDetailTableViewController class]]){
            CardDetailTableViewController *vc = (CardDetailTableViewController *)segue.destinationViewController;
            vc.theCard = self.showCard;
        }
    }
    
    
}


@end
