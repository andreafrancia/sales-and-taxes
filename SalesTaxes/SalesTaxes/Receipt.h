//
//  Receipt.h
//  SalesTaxes
//
//  Created by Enrico Quarantini on 30/03/14.
//  Copyright (c) 2014 Enrico Quarantini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Receipt : NSObject

@property NSArray *products;

- (id)initWithString:(NSString *)string;
- (NSString *)receiptWithTaxes;

@end
