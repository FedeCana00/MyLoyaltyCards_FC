//
//  AddCardViewController.m
//  MyLoyaltyCard_FC
//
//  Created by Fede Cana on 07/05/2021.
//  Copyright © 2021 Fede Cana. All rights reserved.
//

#import "AddCardViewController.h"
#import "CardDataSource.h"
#import <MobileCoreServices/MobileCoreServices.h> //libreria per i multimedia
@interface AddCardViewController ()
//segmento controllato per la scelta della generazione del formato del codice
@property (weak, nonatomic) IBOutlet UISegmentedControl *formatoCodiceSegmentedControl;
//textfield
@property (weak, nonatomic) IBOutlet UITextField *nomeAziendaTextField;
@property (weak, nonatomic) IBOutlet UITextField *codiceClienteTextField;
@property (weak, nonatomic) IBOutlet UITextField *latitudineTextField;
@property (weak, nonatomic) IBOutlet UITextField *longitudineTextField;
//pulsanti per la scelta del colore della carta (emulazione radio button)
@property (weak, nonatomic) IBOutlet UIButton *buttonSelectionRed; //colore di deafult impostato
@property (weak, nonatomic) IBOutlet UIButton *buttonSelectionGreen;
@property (weak, nonatomic) IBOutlet UIButton *buttonSelectionBlue;
@property (weak, nonatomic) IBOutlet UIButton *buttonSelectionYellow;
//label per la visibilità di selezione
@property (weak, nonatomic) IBOutlet UILabel *labelHighlightedRed;
@property (weak, nonatomic) IBOutlet UILabel *labelHighlightedGreen;
@property (weak, nonatomic) IBOutlet UILabel *labelHighlightedBlue;
@property (weak, nonatomic) IBOutlet UILabel *labelHighlightedYellow;

@property(nonatomic, strong) NSArray *colori;
@property(nonatomic, strong) NSString *logoPath;
//imageView in cui inserisco una preview del logo che verrà caricato
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

-(BOOL)checkTextFieldText:(NSString *)text;
@end

@implementation AddCardViewController

- (void)viewDidLoad {
    @try{
        [super viewDidLoad];
        self.title = @"Aggiunta carta";
        //imposto il delegato a sè stessi degli UITextField
        self.nomeAziendaTextField.delegate = self;
        self.codiceClienteTextField.delegate = self;
        self.latitudineTextField.delegate = self;
        self.longitudineTextField.delegate = self;
        
        //Setto di default il colore rosso di sfondo
        //Per farlo nascondo i label sottostanti ai pulsanti del colore
        self.labelHighlightedBlue.hidden = YES;
        self.labelHighlightedGreen.hidden = YES;
        self.labelHighlightedYellow.hidden = YES;
        
        //Setto il logo di default
        self.logoImageView.image = [UIImage imageNamed:@"logoDefault"];
        
    } @catch(NSException *ex){
        NSLog(@"Errore in AddCardViewController => %@",ex.reason);
    }
    
}

- (IBAction)addLogoImage:(id)sender {
    @try{
        if([self startCameraController]){ //avvio l'image picker controller
            NSLog(@"Avvio picker controller!");
        }
    } @catch(NSException *ex){
        NSLog(@"Error => %@", ex.reason);
    }
}

//Action per la gestione del colore di sfondo selezionato
- (IBAction)buttonColorTapped:(id)sender {
    //controllo la classe dell'oggetto prima di fare il cast esplicito
    if([sender isKindOfClass: [UIButton class]]){
        UIButton *buttonTapped = (UIButton *)sender;
        //assegno ai button dei tag per identificarli
        switch(buttonTapped.tag){
            case 0: //pulsante rosso
                self.labelHighlightedRed.hidden = NO;
                self.labelHighlightedYellow.hidden = YES;
                self.labelHighlightedGreen.hidden = YES;
                self.labelHighlightedBlue.hidden = YES;
                break;
            case 1: //pulsante verde
                self.labelHighlightedRed.hidden = YES;
                self.labelHighlightedYellow.hidden = YES;
                self.labelHighlightedGreen.hidden = NO;
                self.labelHighlightedBlue.hidden = YES;
                break;
            case 2: //pulsante blu
                self.labelHighlightedRed.hidden = YES;
                self.labelHighlightedYellow.hidden = YES;
                self.labelHighlightedGreen.hidden = YES;
                self.labelHighlightedBlue.hidden = NO;
                break;
            case 3: //pulsante giallo
                self.labelHighlightedRed.hidden = YES;
                self.labelHighlightedYellow.hidden = NO;
                self.labelHighlightedGreen.hidden = YES;
                self.labelHighlightedBlue.hidden = YES;
                break;
            default:
                NSLog(@"Attenzione tag dei button del Action buttonColorTapped:sender non corrisponde a quelli selezionati!");
                break;
        }
    } else {
        NSLog(@"Attenzione il sender del Action buttonColorTapped:sender non è un UIButton!");
    }
}

- (IBAction)createNewCard:(id)sender {
    @try{
        Card *newCard = [[Card alloc] init];
        //inserisco latitudine e longitudine
        newCard.latitudine = self.latitudineTextField.text;
        newCard.longitudine = self.longitudineTextField.text;
        //aggiungo il file path per il logo
        newCard.logo = self.logoPath;
        //gestisco l'informazione ricevuto dal segmented control
        switch(self.formatoCodiceSegmentedControl.selectedSegmentIndex){
            case 0: //Barcode selezionato
                newCard.formatoCodice = @"Barcode";
                break;
            case 1: //QRcode selezioanto
                newCard.formatoCodice = @"QRcode";
                break;
            default:
                NSLog(@"selectedSegmentIndex indica un valore al di fuori del range!");
        }
        //ottengo il colore della carta
        if(!self.labelHighlightedRed.hidden){
            newCard.coloreSfondo = @"Red";
        } else if (!self.labelHighlightedGreen.hidden){
            newCard.coloreSfondo = @"Green";
        } else if(!self.labelHighlightedBlue.hidden){
            newCard.coloreSfondo = @"Blue";
        } else {
            newCard.coloreSfondo = @"Yellow";
        }
        //creo alert e lo mostro in caso di errata compilazione dati
        UIAlertView *alertError = [[UIAlertView alloc] initWithTitle:@"Attenzione!"
                                                             message:@""
                                                            delegate:self
                                                   cancelButtonTitle:@"Ho capito"
                                                   otherButtonTitles:nil];
        //ottengo il testo della TextField e lo controllo
        if(![self checkTextFieldText:self.nomeAziendaTextField.text]){
            alertError.message = @"Compila il campo nome azienda.";
            [alertError show]; //visualizzo il messaggio autonomamente
        } else if (![self checkTextFieldText:self.codiceClienteTextField.text]){
            alertError.message = @"Compila il campo codice cliente.";
            [alertError show]; //visualizzo il messaggio autonomamente
        } else{
            //inserisco i valori del nome azienda e del codice cliente
            newCard.nomeAzienda = self.nomeAziendaTextField.text;
            newCard.codiceCliente = self.codiceClienteTextField.text;
            //aggiungo la carta e torno alla schermata principale
            NSDictionary *info = @{@"AddCard":newCard};
            //invio la notifica alla rootView che aggiungerà la carta nella sua lista
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AddCard"   // notification name
                                                                object:self                         // notification sender (this object)
                                                              userInfo:info];
            //dealloco questa view e torno alla precedente
            [self.navigationController popViewControllerAnimated:YES];
        }
    } @catch(NSException *ex){
        NSLog(@"Errore => %@",ex.reason);
    }
}

-(BOOL)checkTextFieldText:(NSString *)text{
    if(text.length > 0){
        return YES;
    }
    return NO;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    //chiuso la keyboard e verifico se ha successo
    if([textField resignFirstResponder]){
        NSLog(@"Chiusura Keyboard avvenuta con successo!");
        return YES;
    } else{
        NSLog(@"Chiusura Keyboard non riuscita!");
        return YES;
    }
}

//TEST-------------------------------------------------------
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
    [picker dismissViewControllerAnimated:YES completion:nil];
}
/* Responding to the user user accepting a newly-captured picture or movie */
/* The info argument is a dictionary containing the original image and the edited image, if an image was picked; or a filesystem URL for the movie, if a movie was picked */
- (void) imagePickerController:(UIImagePickerController *)picker
 didFinishPickingMediaWithInfo:(NSDictionary *)info{
    @try{
        NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        //creo un nome per il logo utilizzando il numero di carta che sto inserendo nella mia lista
        NSString *fileName = [@"Logo" stringByAppendingString:[[NSNumber numberWithLong:self.numberOfCard] stringValue]];
        //create a path where store image
        UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
        NSString *imageName = [fileName stringByAppendingString:@".png"]; //da rivedere il nome con cui viene nominata l'immagine
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
            
            self.logoPath = path; //imposto il path da cui caricare l'immagine
            NSLog(@"URL => %@", path);
            UIImage *image = [UIImage imageWithContentsOfFile:path];
            self.logoImageView.image = image;
            /*  Dismiss the image picker controller */
            [picker dismissViewControllerAnimated:YES completion:nil]; //picker.parentViewController non funziona in questo scenario!
        }
        /*  Handle video capture */
        if (CFStringCompare((CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo)
        {
            //alert in fase di test
            UIAlertView *alertVideo = [[UIAlertView alloc] initWithTitle:@"Attenzione!"
                                                            message:@"Puoi selezionare solamente immagini per il logo."
                                                           delegate:self
                                                  cancelButtonTitle:@"Ho capito"
                                                  otherButtonTitles:nil];
            [alertVideo show]; //visualizzo il messaggio autonomamente
            
        }
    } @catch(NSException *ex){
        NSLog(@"Error => %@", ex.reason);
    }
}
//-------------------------------------------------------------------------------------

/*
//metodo per dismettere la tastiera cliccando fuori dalla stessa
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"getImage"]){
        if([segue.destinationViewController isKindOfClass:[ImagePickerViewController class]]){
            NSLog(@"Segue getImage");
        }
    }
}
*/

@end
