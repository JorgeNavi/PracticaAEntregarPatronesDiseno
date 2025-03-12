final class HeroDetailBuilder {
    
    static func build(heroName: String) -> HeroDetailViewController {
        let viewModel = HeroDetailViewModel(heroName: heroName)
        let viewController = HeroDetailViewController(viewModel: viewModel)
        return viewController
    }
}
