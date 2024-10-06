import Foundation

enum HeroDetailState {
    case loading
    case loaded(hero: Hero)
    case error(reason: String)
}

final class HeroDetailViewModel {
    let onStateChanged = Binding<HeroDetailState>()
    private let hero: Hero
    
    init(hero: Hero) {
        self.hero = hero
    }
    
    func load() {
        onStateChanged.update(newValue: .loaded(hero: hero))
    }
    
    
}
