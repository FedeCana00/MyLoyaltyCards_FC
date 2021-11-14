//
//  Card.h
//  MyLoyaltyCard_FC
//
//  Created by Fede Cana on 06/05/2021.
//  Copyright © 2021 Fede Cana. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Card : NSObject

//@property(nonatomic) int autoincrement;
@property(nonatomic, strong)NSString *nomeAzienda;
@property(nonatomic, strong)NSString *logo;
@property(nonatomic, strong)NSString *codiceCliente;
@property(nonatomic, strong)NSString *formatoCodice;
@property(nonatomic, strong)NSString *coloreSfondo;
@property(nonatomic, strong)NSString *latitudine;
@property(nonatomic, strong)NSString *longitudine;

-(instancetype)initWithValues:(NSString *) column2
                             :(NSString *) column3
                             :(NSString *) column4
                             :(NSString *) column5
                             :(NSString *) column6
                             :(NSString *) column7
                             :(NSString *) column8;

@end

NS_ASSUME_NONNULL_END
