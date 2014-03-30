//
//  Product.m
//  SalesTaxes
//
//  Created by Enrico Quarantini on 30/03/14.
//  Copyright (c) 2014 Enrico Quarantini. All rights reserved.
//

#import "Product.h"

@implementation Product

- (id)initWithString:(NSString *)string {
    self = [super init];
    
    if (self) {
        NSError *error;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(\\d+)\\s(.+)\\sat\\s(\\d+.\\d+)"
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:&error];
        if (error) {
            NSLog(@"ERROR: string not compatible");
            return nil;
        }
        
        NSTextCheckingResult* result = [regex firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
        
        if (result && result.numberOfRanges == 4) {
            _quantity = [[string substringWithRange:[result rangeAtIndex:1]] intValue];
            _name = [string substringWithRange:[result rangeAtIndex:2]];
            if ([self nameContainsSubString:@"imported"]) {
                _imported = YES;
                _name = [_name stringByReplacingOccurrencesOfString:@"imported " withString:@""options:NSCaseInsensitiveSearch range:NSMakeRange(0, [_name length])];
            } else
                _imported = NO;
            _price = [[string substringWithRange:[result rangeAtIndex:3]] floatValue];
        }
    }
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%d %@%@: %.2f", [self quantity], [self isImported] ? @"imported " : @"", [self name], [self priceWithTaxes]];
}

- (float)taxes {
    return ceilf(([self getTaxRate] * _price / 100) * 20.0)/20.0;
}

- (float)priceWithTaxes {
    return (_price + [self taxes]);
}

- (float)getTaxRate {
    float taxRate = 0;
    if (![self isBook] && ![self isFood] && ![self isMedical])
        taxRate += 10;
    if ([self isImported])
        taxRate += 5;
    
    return taxRate;
}

- (BOOL)isBook {
    return [self nameContainsSubString:@"book"];
}

- (BOOL)isFood {
    return [self nameContainsSubString:@"chocolate"];
}

- (BOOL)isMedical {
    return [self nameContainsSubString:@"pills"];
}

- (BOOL)nameContainsSubString:(NSString *)subString {
    if ([_name rangeOfString:subString options:NSCaseInsensitiveSearch].location == NSNotFound)
        return NO;
    else
        return YES;
}

@end
