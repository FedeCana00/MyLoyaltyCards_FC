//
//  CardsListTableViewController.m
//  MyLoyaltyCard_FC
//
//  Created by Fede Cana on 06/05/2021.
//  Copyright © 2021 Fede Cana. All rights reserved.
//

#import "CardsListTableViewController.h"
#import "CardViewController.h"
#import "OperationCardDataSource.h"
#import "AddCardViewController.h"

@interface CardsListTableViewController ()

@property(nonatomic, strong)CardList *cards;
//tableView IBOutlet per ricaricare i dati in tabella dopo averli aggiornati
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (void)addSomeCard:(NSNotification *) info;
@end

@implementation CardsListTableViewController
@dynamic tableView; //per eliminare il warning

- (void)viewDidLoad {
    @try{
        [super viewDidLoad];
        self.title = @"Le mie carte fedeltà";
        self.dataSource = [[OperationCardDataSource alloc] init];
        if(self.dataSource != nil){
            self.cards = [self.dataSource getCard];
        }
        NSLog(@"Numero di carte: %lu", self.cards.size);
        [[NSNotificationCenter defaultCenter] addObserver:self                          // this object is the observer
                                                 selector:@selector(addSomeCard:)          // the method updateUI: will be executed
                                                     name:@"AddCard"    // when CounterChangedNotification is received
                                                   object:nil];                // the object sending the notificaction is our counter instance
        // Uncomment the following line to preserve selection between presentations.
        // self.clearsSelectionOnViewWillAppear = NO;
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }@catch(NSException *ex){
        NSLog(@"Errore in CardListTableViewController => %@", ex.reason);
    }
}

- (void)addSomeCard:(NSNotification *) notification{
    //aggiungo alla lista dataSource la carta
    [self.dataSource addCards:[notification.userInfo objectForKey:@"AddCard"]];
    //Passo il dataSource alla lista della view
    self.cards = [self.dataSource getCard];
    //aggiorno i dati presenti in tabella
    [self.tableView reloadData];
    NSLog(@"Numero di carte: %lu", self.cards.size);
    NSLog(@"Carta aggiunta!");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cards.size;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cardRow";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    Card *card = [[Card alloc] init];
    card = [self.cards getAtIndex:indexPath.row];
    cell.textLabel.text = card.nomeAzienda; //nome della carta fedeltà
    
    return cell;
}

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


//azione che parte se viene cliccato il disclosure
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier: @"showCard" sender: [tableView cellForRowAtIndexPath: indexPath]];
}

- (IBAction)addButtonTapped:(id)sender {
    [self performSegueWithIdentifier: @"addCard" sender: self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"showCard"]){
        if([segue.destinationViewController isKindOfClass:[CardViewController class]]){
            CardViewController *vc = (CardViewController *)segue.destinationViewController;
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            Card *c = [self.cards getAtIndex:indexPath.row];
            vc.showCard = c;
        }
    }
    
    if([segue.identifier isEqualToString:@"addCard"]){
        if([segue.destinationViewController isKindOfClass:[AddCardViewController class]]){
            AddCardViewController *vc = (AddCardViewController *)segue.destinationViewController;
            vc.numberOfCard = [self.cards size];
        }
    }
}

@end
