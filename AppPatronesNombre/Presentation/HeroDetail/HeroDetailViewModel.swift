import Foundation

enum HeroDetailState {
    case loading
    case loaded
    case error(reason: String)
}

final class HeroDetailViewModel {
    
    let onStateChanged = Binding<HeroDetailState>()
    let heroName: String
    private let useCase: HeroDetailUseCase
    private(set) var hero: Hero?

    init(heroName: String, useCase: HeroDetailUseCase = HeroDetailUseCase()) {
        self.heroName = heroName
        self.useCase = useCase
    }


    
    
    func load() {
        onStateChanged.update(newValue: .loading)
        useCase.execute(heroName: heroName) { [weak self] result in
            do {
                self?.hero = try result.get()
                self?.onStateChanged.update(newValue: .loaded)
                print("id del hero: \(String(describing: self?.hero?.identifier))")
                //"14BB8E98-6586-4EA7-B4D7-35D6A63F5AA3"
            } catch {
                    self?.onStateChanged.update(newValue: .error(reason: error.localizedDescription))
                        }
                    }
        }
}
