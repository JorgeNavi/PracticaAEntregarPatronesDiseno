final class HeroDetailBuilder {
    
    static func build(heroId: String) -> HeroDetailViewController {
        let viewModel = HeroDetailViewModel(heroId: heroId)
        let viewController = HeroDetailViewController(viewModel: viewModel)
        return viewController
    }
}
