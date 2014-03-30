//
//  Product.h
//  SalesTaxes
//
//  Created by Enrico Quarantini on 30/03/14.
//  Copyright (c) 2014 Enrico Quarantini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property int quantity;
@property NSString *name;
@property float price;
@property(getter = isImported) BOOL imported;

- (id)initWithString:(NSString *)string;
- (float)taxes;
- (float)priceWithTaxes;

@end
