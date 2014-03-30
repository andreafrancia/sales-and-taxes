//
//  Receipt.m
//  SalesTaxes
//
//  Created by Enrico Quarantini on 30/03/14.
//  Copyright (c) 2014 Enrico Quarantini. All rights reserved.
//

#import "Receipt.h"
#import "Product.h"

@implementation Receipt

- (id)initWithString:(NSString *)string {
    self = [super init];
    
    if (self) {
        NSArray *productStrings = [string componentsSeparatedByString:@"\n"];
        
        NSMutableArray *products = [NSMutableArray array];
        [productStrings enumerateObjectsUsingBlock:^(NSString *string, NSUInteger idx, BOOL *stop) {
            Product *product = [[Product alloc] initWithString:string];
            if (product)
                [products addObject:product];
        }];
        _products = [products copy];
    }
    
    return self;
}

- (NSString *)receiptWithTaxes {
    NSString *receiptWithTaxes = @"";
    float taxes = 0;
    float totalPrice = 0;
    
    for (Product *product in _products) {
        taxes += [product taxes];
        totalPrice += [product priceWithTaxes];
        NSString *productString = [NSString stringWithFormat:@"%@", [product description]];
        receiptWithTaxes = [[receiptWithTaxes stringByAppendingString:productString] stringByAppendingString:@"\n"];
    }
    receiptWithTaxes = [receiptWithTaxes stringByAppendingString:[NSString stringWithFormat:@"Sales Taxes: %.2f", taxes]];
    receiptWithTaxes = [receiptWithTaxes stringByAppendingString:[NSString stringWithFormat:@"\nTotal: %.2f", totalPrice]];
    
    return receiptWithTaxes;
}

@end
