//
//  SalesTaxes_Tests.m
//  SalesTaxes Tests
//
//  Created by Enrico Quarantini on 30/03/14.
//  Copyright (c) 2014 Enrico Quarantini. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Receipt.h"

@interface SalesTaxes_Tests : XCTestCase

@end

@implementation SalesTaxes_Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test1
{
    NSString *test1 = @"1 book at 12.49\n1 music CD at 14.99\n1 chocolate bar at 0.85";
    NSString *test1Result = @"1 book: 12.49\n1 music CD: 16.49\n1 chocolate bar: 0.85\nSales Taxes: 1.50\nTotal: 29.83";
    
    [self testReceiptWithTextString:test1 andResultString:test1Result];
}

- (void)test2
{
    NSString *test2 = @"1 imported box of chocolates at 10.00\n1 imported bottle of perfume at 47.50";
    NSString *test2Result = @"1 imported box of chocolates: 10.50\n1 imported bottle of perfume: 54.65\nSales Taxes: 7.65\nTotal: 65.15";
    
    [self testReceiptWithTextString:test2 andResultString:test2Result];
}

- (void)test3
{
    NSString *test3 = @"1 imported bottle of perfume at 27.99\n1 bottle of perfume at 18.99\n1 packet of headache pills at 9.75\n1 box of imported chocolates at 11.25";
    NSString *test3Result = @"1 imported bottle of perfume: 32.19\n1 bottle of perfume: 20.89\n1 packet of headache pills: 9.75\n1 imported box of chocolates: 11.85\nSales Taxes: 6.70\nTotal: 74.68";
    
    [self testReceiptWithTextString:test3 andResultString:test3Result];
}

- (void)testReceiptWithTextString:(NSString *)test andResultString:(NSString *)result {
    Receipt *receipt = [[Receipt alloc] initWithString:test];
    XCTAssertEqualObjects([receipt receiptWithTaxes], result);
}

@end
