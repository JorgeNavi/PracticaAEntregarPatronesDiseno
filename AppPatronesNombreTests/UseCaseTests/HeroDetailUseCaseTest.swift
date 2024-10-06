@testable import AppPatronesNombre
import XCTest

// Mock para GetAllHeroesUseCaseContract
final class GetAllHeroesUseCaseMock: GetAllHeroesUseCaseContract {
    var mockResult: Result<[Hero], Error>
    
    init(mockResult: Result<[Hero], Error>) {
        self.mockResult = mockResult
    }
    
    func execute(completion: @escaping (Result<[Hero], Error>) -> Void) {
        completion(mockResult)
    }
}

// Clase de test para HeroDetailUseCase
final class HeroDetailUseCaseTests: XCTestCase {
    
    func testExecuteSuccess() {
        // Configuramos el héroe de prueba
        let hero = Hero(identifier: "hero123", name: "Goku", description: "Saiyan", photo: "url", favorite: false)
        let getAllHeroesUseCaseMock = GetAllHeroesUseCaseMock(mockResult: .success([hero]))
        
        let sut = HeroDetailUseCase(getAllHeroesUseCase: getAllHeroesUseCaseMock)
        
        let expectation = self.expectation(description: "HeroDetailUseCaseSuccess")
        
        sut.execute(heroId: "hero123") { result in
            switch result {
            case .success(let returnedHero):
                XCTAssertEqual(returnedHero.identifier, hero.identifier)
                XCTAssertEqual(returnedHero.name, hero.name)
                XCTAssertEqual(returnedHero.description, hero.description)
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }
        
        waitForExpectations(timeout: 5)
    }
    
    func testExecuteFailureHeroNotFound() {
        // Caso donde no se encuentra el héroe
        let getAllHeroesUseCaseMock = GetAllHeroesUseCaseMock(mockResult: .success([]))
        
        let sut = HeroDetailUseCase(getAllHeroesUseCase: getAllHeroesUseCaseMock)
        
        let expectation = self.expectation(description: "HeroDetailUseCaseHeroNotFound")
        
        sut.execute(heroId: "nonExistentHeroId") { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error as NSError):
                XCTAssertEqual(error.code, 404)
                XCTAssertEqual(error.domain, "Cannot find Character")
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5)
    }
    
}
