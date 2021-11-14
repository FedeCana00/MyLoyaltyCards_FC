//
//  CardDataSource.h
//  MyLoyaltyCard_FC
//
//  Created by Fede Cana on 08/05/2021.
//  Copyright © 2021 Fede Cana. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CardList.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CardDataSource <NSObject>

- (CardList *) getCard;
- (void) addCards:(Card *)newCard;

@end

NS_ASSUME_NONNULL_END

