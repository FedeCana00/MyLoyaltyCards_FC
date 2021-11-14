//
//  CardList.h
//  MyLoyaltyCard_FC
//
//  Created by Fede Cana on 08/05/2021.
//  Copyright © 2021 Fede Cana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface CardList : NSObject

-  (long)size;
-  (NSArray *)getAllCards;
-  (void)add:(Card *)c;
- (Card *)getAtIndex:(NSInteger)index;

@end

