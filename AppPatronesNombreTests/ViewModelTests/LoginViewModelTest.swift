@testable import AppPatronesNombre
import XCTest

// Mock del caso de uso exitoso
private final class SuccessfulLoginUseCaseMock: LoginUseCaseContract {
    func execute(credentials: Credentials, completion: @escaping (Result<Void, LoginUsecaseError>) -> Void) {
        completion(.success(())) // Simula un inicio de sesión exitoso
    }
}


final class LoginViewModelTests: XCTestCase {
    
    func testLoginSuccess() {
        let expectation = expectation(description: "Login success")
        let useCaseMock = SuccessfulLoginUseCaseMock()
        let sut = LoginViewModel(useCase: useCaseMock)
        
        sut.onStateChanged.bind { state in
            if case .loading = state {
                // El estado cambia a loading
            } else if case .success = state {
                expectation.fulfill() // Se cumple la expectativa al recibir un estado de éxito
            }
        }
        
        sut.sigIn("validUsername", "validPassword") // Ejecuta el método de inicio de sesión
        waitForExpectations(timeout: 5)
    }
    
}
