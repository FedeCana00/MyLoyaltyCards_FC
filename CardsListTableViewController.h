//
//  CardsListTableViewController.h
//  MyLoyaltyCard_FC
//
//  Created by Fede Cana on 06/05/2021.
//  Copyright © 2021 Fede Cana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardsListTableViewController : UITableViewController

@property (nonatomic, strong) id<CardDataSource> dataSource;

@end

NS_ASSUME_NONNULL_END
