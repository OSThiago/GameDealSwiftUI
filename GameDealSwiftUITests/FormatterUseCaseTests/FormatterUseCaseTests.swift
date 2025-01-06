//
//  FormatterUseCaseTests.swift
//  GameDealSwiftUITests
//
//  Created by Thiago de Oliveira Sousa on 02/01/25.
//

import XCTest
@testable import GameDealSwiftUI

final class FormatterUseCaseTests: XCTestCase {
    
    private var sut: FormatterProcol!
    
    override func setUpWithError() throws {
        self.sut = FormatterUseCaseImplementation()
    }
    
    override func tearDownWithError() throws {
        self.sut = nil
    }
    
    func test_check_url_has_content_success() async throws {
        // Given
        let url = "https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/70/25bee0c9572a4f0dc4de6c773c54d067a4204760/capsule_sm_120.jpg?t=1732327059"

        
        // When
        let hasContent = await sut.checkUrlHasContent(url)

        // Then
        XCTAssertTrue(hasContent)

    }
    
    func test_check_url_has_content_failure() async throws {
        // Given
        let url = "https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/70/25bee0c9572a4f0dc4de6c773c54d067a4204760/header.jpg?t=1732327059"
        
        // When
        let hasContent = await sut.checkUrlHasContent(url)
        
        // Then
        XCTAssertFalse(hasContent)
    }
    
    func test_get_high_quality_imace_success() async throws {
        // Given
        let url = "https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/286690/capsule_sm_120.jpg?t=1725363906"
        let expectedResult = "https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/286690/header.jpg?t=1725363906"
        
        // When
        let result = await sut.getHightQualityImage(url: url)
        
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_get_high_quality_imace_failure() async throws {
        // Given
        let url = "https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/70/25bee0c9572a4f0dc4de6c773c54d067a4204760/capsule_sm_120.jpg?t=1732327059"
        
        // When
        let result = await sut.getHightQualityImage(url: url)
        
        // Then
        XCTAssertEqual(result, url)
    }
}
