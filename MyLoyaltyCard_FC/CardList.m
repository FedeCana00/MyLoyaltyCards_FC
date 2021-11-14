//
//  CardList.m
//  MyLoyaltyCard_FC
//
//  Created by Fede Cana on 08/05/2021.
//  Copyright © 2021 Fede Cana. All rights reserved.
//

#import "CardList.h"

@interface CardList()

@property (nonatomic, strong) NSMutableArray *list;

@end

@implementation CardList

-(instancetype) init{
    self = [super init];
    if (self) {
        _list = [[NSMutableArray alloc] init];
    }
    return self;
}

- (long)size{
    return self.list.count;
}

- (NSArray *)getAllCards{
    return self.list;
}

- (void)add:(Card *)c{
    [self.list addObject:c];
}

- (Card *)getAtIndex:(NSInteger)index{
    return [self.list objectAtIndex:index];
}

@end
