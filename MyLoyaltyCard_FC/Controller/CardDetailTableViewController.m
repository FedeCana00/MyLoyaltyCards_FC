//
//  CardDetailTableViewController.m
//  MyLoyaltyCard_FC
//
//  Created by Fede Cana on 06/05/2021.
//  Copyright © 2021 Fede Cana. All rights reserved.
//

#import "CardDetailTableViewController.h"

@interface CardDetailTableViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labelNomeAzienda;
@property (weak, nonatomic) IBOutlet UILabel *labelCodiceCliente;
@property (weak, nonatomic) IBOutlet UILabel *labelFormatoCodice;
@property (weak, nonatomic) IBOutlet UILabel *labelLatitudine;
@property (weak, nonatomic) IBOutlet UILabel *labelLongitudine;
//@property (weak, nonatomic) IBOutlet UIButton *buttonElimina; //verificare se necessario

@end

@implementation CardDetailTableViewController

- (void)viewDidLoad {
    @try{
        [super viewDidLoad];
        self.title = @"Dettagli carta fedeltà";
        self.labelNomeAzienda.text = self.theCard.nomeAzienda;
        self.labelCodiceCliente.text = self.theCard.codiceCliente;
        self.labelFormatoCodice.text = self.theCard.formatoCodice;
        self.labelLatitudine.text = self.theCard.latitudine;
        self.labelLongitudine.text = self.theCard.longitudine;
        // Uncomment the following line to preserve selection between presentations.
        // self.clearsSelectionOnViewWillAppear = NO;
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    } @catch(NSException *ex){
        NSLog(@"Errore in CardDetailTableViewController => %@", ex.reason);
    }
}
- (IBAction)deleleCardFromList:(id)sender {
    NSLog(@"Inizio eliminazione!");
    //da gestire con le notifiche!
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section){
        case 0:
            return 3;
        case 1:
            return 2;
        case 2:
            return 1;
        default:
            NSLog(@"Errore sezione non realmente creata!");
            return 0;
    }
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
