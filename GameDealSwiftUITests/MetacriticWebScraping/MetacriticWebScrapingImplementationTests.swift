//
//  MetacriticWebScrapingImplementationTests.swift
//  GameDealSwiftUITests
//
//  Created by Thiago de Oliveira Sousa on 14/07/24.
//

import XCTest
@testable import GameDealSwiftUI

final class MetacriticWebScrapingImplementationTests: XCTestCase {
    
    private var sut: MetacriticWebScrapingProtocol!
    
    override func setUpWithError() throws {
        self.sut = MetacriticWebScrapingImplementation()
    }

    override func tearDownWithError() throws {
        self.sut = nil
    }
    
    func test_get_description() async throws {
        // Given
        let webLink = "https://www.metacritic.com/game/the-witcher-3-wild-hunt/details/"
        let expected = "Description: With the Empire attacking the Kingdoms of the North and the Wild Hunt, a cavalcade of ghastly riders, breathing down your neck, the only way to survive is to fight back. As Geralt of Rivia, a master swordsman and monster hunter, leave none of your enemies standing. Explore a gigantic open world, slay beasts and decide the fates of whole communities with your actions, all in a genuine next generation format."
        let descriptionClass = "c-pageProductDetails_description"
        
        // When
        let htmlContent = await sut.getURLContent(url: webLink)
        let description = sut.getContent(htmlContent: htmlContent, byClass: descriptionClass)
        
        // Then
        XCTAssertEqual(description, expected)
    }
    
    func test_get_platforms() async throws {
        // Given
        let webLink = "https://www.metacritic.com/game/the-witcher-3-wild-hunt/details/"
        let expected = ["PC","Xbox One","PlayStation 4","Nintendo Switch"]
        
        // When
        let htmlContent = await sut.getURLContent(url: webLink)
        let filteredContent = sut.filterRawHtmlContent(fullHtmlContent: htmlContent, byClass: "c-gameDetails_Platforms")
        let platforms = sut.getContents(htmlContent: filteredContent, byElementsTag: "li")
        
        // Then
        XCTAssertEqual(platforms, expected)
    }
    
    func test_get_release_date_by_array() async throws {
        // Given
        let webLink = "https://www.metacritic.com/game/the-witcher-3-wild-hunt/details/"
        let className = "c-gameDetails_ReleaseDate"
        let expected = ["Initial Release Date:", "May 19, 2015"]
        
        // When
        let htmlContent = await sut.getURLContent(url: webLink)
        let filteredContent = sut.filterRawHtmlContent(fullHtmlContent: htmlContent, byClass: className)
        let release = sut.getContents(htmlContent: filteredContent, byElementsTag: "span")
        
        // Then
        XCTAssertEqual(release, expected)
    }
    
    func test_get_release_data_by_string() async throws {
        // Given
        let webLink = "https://www.metacritic.com/game/the-witcher-3-wild-hunt/details/"
        let className = "c-gameDetails_ReleaseDate"
        let expected = "Initial Release Date: May 19, 2015"
        
        // When
        let htmlContent = await sut.getURLContent(url: webLink)
        let release = sut.getContent(htmlContent: htmlContent, byClass: className)
        
        // Then
        XCTAssertEqual(release, expected)
    }
    
    func test_get_developers() async throws {
        // Given
        let webLink = "https://www.metacritic.com/game/the-witcher-3-wild-hunt/details/"
        let className = "c-gameDetails_Developer"
        let tag = "li"
        let expected = ["CD Projekt Red Studio"]
        
        // When
        let htmlContent = await sut.getURLContent(url: webLink)
        let developerClassContent = sut.filterRawHtmlContent(fullHtmlContent: htmlContent, byClass: className)
        let developers = sut.getContents(htmlContent: developerClassContent, byElementsTag: tag)
        
        // Then
        XCTAssertEqual(developers, expected)
    }
    
    func test_get_publisher() async throws {
        // Given
        let webLink = "https://www.metacritic.com/game/the-witcher-3-wild-hunt/details/"
        let className = "c-gameDetails_Distributor"
        let expected = "Publisher: Warner Bros. Interactive Entertainment"
        
        // When
        let htmlContent = await sut.getURLContent(url: webLink)
        let publisher = sut.getContent(htmlContent: htmlContent, byClass: className)
        
        // Then
        XCTAssertEqual(publisher, expected)
    }
    
    func test_get_genres() async throws {
        // Given
        let webLink = "https://www.metacritic.com/game/the-witcher-3-wild-hunt/details/"
        let className = "c-genreList"
        let tag = "span"
        let expected = ["Action RPG"]
        
        // When
        let htmlContent = await sut.getURLContent(url: webLink)
        let filtered = sut.filterRawHtmlContent(fullHtmlContent: htmlContent, byClass: className)
        let genres = sut.getContents(htmlContent: filtered, byElementsTag: tag)
        
        // Then
        XCTAssertEqual(genres, expected)
    }
}
