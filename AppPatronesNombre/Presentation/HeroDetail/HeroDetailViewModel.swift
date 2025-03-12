import Foundation

enum HeroDetailState {
    case loading
    case loaded
    case error(reason: String)
}

final class HeroDetailViewModel {
    
    let onStateChanged = Binding<HeroDetailState>()
    let heroId: String
    private let useCase: HeroDetailUseCase
    private(set) var hero: Hero?

    init(heroId: String, useCase: HeroDetailUseCase = HeroDetailUseCase()) {
        self.heroId = heroId
        self.useCase = useCase
    }


    
    
    func load() {
        onStateChanged.update(newValue: .loading)
        useCase.execute(heroId: heroId) { [weak self] result in
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


/*import Foundation
 
 enum HeroDetailState {
     case loading
     case loaded(hero: Hero)
     case error(reason: String)
 }

 final class HeroDetailViewModel {
     
     let onStateChanged = Binding<HeroDetailState>()
     let heroId: String
     private let useCase: HeroDetailUseCase

     init(heroId: String, useCase: HeroDetailUseCase = HeroDetailUseCase()) {
         self.heroId = heroId
         self.useCase = useCase
     }


     
     
     func load() {
         onStateChanged.update(newValue: .loading)
         useCase.execute(heroId: heroId) { [weak self] result in
             switch result {
                 case .success(let hero):
                     self?.onStateChanged.update(newValue: .loaded(hero: hero))
                     print("id del hero: \(hero.identifier)")
                     //"14BB8E98-6586-4EA7-B4D7-35D6A63F5AA3"
                 case .failure(let error):
                     self?.onStateChanged.update(newValue: .error(reason: error.localizedDescription))
                         }
                     }
         }
 }
*/
