final class HeroDetailBuilder {
    
    static func build(heroName: String) -> HeroDetailViewController {
        let useCase = HeroDetailUseCase()
        let viewModel = HeroDetailViewModel(heroName: heroName, useCase: useCase)
        let viewController = HeroDetailViewController(viewModel: viewModel)
        return viewController
    }
}
