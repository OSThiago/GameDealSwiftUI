//
//  GameDealSwiftUITests.swift
//  GameDealSwiftUITests
//
//  Created by Thiago de Oliveira Sousa on 15/06/23.
//

import XCTest
@testable import GameDealSwiftUI

final class GameDealSwiftUITests: XCTestCase {

    private var sut: DealsServiceImpelentation!
    
    override func setUpWithError() throws {
        self.sut = DealsServiceImpelentation()
    }

    override func tearDownWithError() throws {
        self.sut = nil
    }
    
    func test_get_url() throws {
        // Given
        let query:[DealsQuery] = [
            .pageNumber(number: 0),
            .pageSize(size: 10),
            .sortBy(option: CheapSharkSortDeals.DEALRATING.rawValue),
            .AAA(isActive: false),
            .storeID(id: "1")
        ]
        
        let enpoint = DealsEndPoint.dealsList(queryItens: query)
        
        let expectedResult = "https://www.cheapshark.com/api/1.0/deals?&pageNumber=0&pageSize=10&sortBy=Deal Rating&AAA=0&storeID=1"
        
        // When
        let url = sut.url(endpoint: enpoint)
        
        // Then
        XCTAssertEqual(url, expectedResult)
        
    }
}
