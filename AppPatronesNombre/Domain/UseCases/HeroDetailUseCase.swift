import Foundation

// Protocolo que define el contrato para el caso de uso de detalles del héroe.
protocol HeroDetailUseCaseContract {
    // Función que ejecuta el caso de uso, toma un identificador de héroe y un cierre para manejar el resultado.
    func execute(heroId: String, completion: @escaping (Result<Hero, Error>) -> Void)
}

// Clase final que implementa el contrato de uso de detalle de héroe.
final class HeroDetailUseCase: HeroDetailUseCaseContract {
    
    // Propiedad que mantiene una referencia al caso de uso para obtener todos los héroes.
    private let getAllHeroesUseCase: GetAllHeroesUseCaseContract
    
    // Inicializador que recibe un caso de uso para obtener héroes, con un valor por defecto.
    init(getAllHeroesUseCase: GetAllHeroesUseCaseContract = GetAllHeroesUseCase()) {
        self.getAllHeroesUseCase = getAllHeroesUseCase
    }
    
    // Implementación de la función de ejecución del caso de uso.
    func execute(heroId: String, completion: @escaping (Result<Hero, Error>) -> Void) {
        // Llama al caso de uso que obtiene todos los héroes.
        getAllHeroesUseCase.execute { result in
            // Maneja el resultado de la obtención de héroes.
            switch result {
            case .success(let heroes):
                // Busca el héroe que coincide con el identificador proporcionado.
                if let hero = heroes.first(where: { $0.identifier == heroId }) {
                    // Si se encuentra el héroe, se llama al cierre de éxito con el héroe encontrado.
                    completion(.success(hero))
                } else {
                    // Si no se encuentra el héroe, se llama al cierre de error con un error 404.
                    completion(.failure(NSError(domain: "Cannot find Character", code: 404, userInfo: nil)))
                }
            case .failure(let error):
                // Si hay un error al obtener los héroes, se llama al cierre de error con el error.
                completion(.failure(error))
            }
        }
    }
}
