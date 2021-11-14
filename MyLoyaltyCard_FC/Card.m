//
//  Card.m
//  MyLoyaltyCard_FC
//
//  Created by Fede Cana on 06/05/2021.
//  Copyright © 2021 Fede Cana. All rights reserved.
//

#import "Card.h"

@implementation Card

-(instancetype)initWithValues:(NSString *) column2
                             :(NSString *) column3
                             :(NSString *) column4
                             :(NSString *) column5
                             :(NSString *) column6
                             :(NSString *) column7
                             :(NSString *) column8{
    self = [super init];
    if (self) {
        //_autoincrement = column1;
        _nomeAzienda = column2;
        _logo = column3;
        _codiceCliente = column4;
        _formatoCodice = column5;
        _coloreSfondo = column6;
        _latitudine = column7;
        _longitudine = column8;
    }
    return self;
}

@end
