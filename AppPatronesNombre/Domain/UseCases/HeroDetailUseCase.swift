import Foundation

// Protocolo que define el contrato para el caso de uso de detalles del héroe.
protocol HeroDetailUseCaseContract {
    // Función que ejecuta el caso de uso, toma un identificador de héroe y un cierre para manejar el resultado.
    func execute(heroName: String, completion: @escaping (Result<Hero, Error>) -> Void)
}

enum HeroDetailUseCaseError: Error {
    case notFound
}

// Clase final que implementa el contrato de uso de detalle de héroe.
final class HeroDetailUseCase: HeroDetailUseCaseContract {
    
    
    // Implementación de la función de ejecución del caso de uso.
    func execute(heroName: String, completion: @escaping (Result<Hero, Error>) -> Void) {
        
        //usamos la request para pedir un solo heroe pasandole el nombre
        GetHeroesAPIRequest(name: heroName).perform { result in
                do {
                    guard let hero = try result.get().first
                    else {
                        return completion(.failure(HeroDetailUseCaseError.notFound))
                    }
                    completion(.success(hero))
                            
                } catch {
                    completion(.failure(error))
                }
            }
        }
}
