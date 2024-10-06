@testable import AppPatronesNombre
import XCTest

// Crea un mock del héroe
private final class HeroMock {
    static func makeHero() -> Hero {
        return Hero(identifier: "1234",
                    name: "potato",
                    description: "A potato hero",
                    photo: "http://example.com/potato.png",
                    favorite: false)
    }
}

final class HeroDetailViewModelTests: XCTestCase {
    
    func testLoadHeroDetailsSuccess() {
        let expectation = expectation(description: "Loaded hero details")
        let hero = HeroMock.makeHero()
        let sut = HeroDetailViewModel(hero: hero)
        
        sut.onStateChanged.bind { state in
            if case .loaded(let loadedHero) = state {
                // Verifica que los detalles del héroe son correctos
                XCTAssertEqual(loadedHero.name, hero.name)
                XCTAssertEqual(loadedHero.identifier, hero.identifier)
                XCTAssertEqual(loadedHero.description, hero.description)
                XCTAssertEqual(loadedHero.photo, hero.photo)
                expectation.fulfill()
            }
        }
        
        sut.load() // Llama al método que carga el héroe
        waitForExpectations(timeout: 5)
    }
}
    
