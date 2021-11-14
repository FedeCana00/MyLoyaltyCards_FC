//
//  OperationCardDataSource.m
//  MyLoyaltyCard_FC
//
//  Created by Fede Cana on 08/05/2021.
//  Copyright © 2021 Fede Cana. All rights reserved.
//

#import "OperationCardDataSource.h"

@interface OperationCardDataSource()

@property (nonatomic, strong) CardList *cards;

@end

@implementation OperationCardDataSource

- (instancetype) init {
    if(self = [super init]){
        _cards = [[CardList alloc] init];
        //[self addCards];
    }
    return self;
}

-(void) addCards:(Card *)newCard{
    [self.cards add:newCard];
}

-(CardList *) getCard{
    return self.cards;
}
@end
