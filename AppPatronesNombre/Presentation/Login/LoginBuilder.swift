//Los Builder tienen todos la misma estructura:

//Un inicializador que incia

//Unos setter que responden siempre la misma estancia (el propio builder)

//Un método build() que nos devuelve la instancia



import UIKit

final class LoginBuilder {
    func build() -> UIViewController { //Establecemos una función build() que instancia un UIViewController
        let viewModel = LoginViewModel()
        let viewController = LoginViewController(viewModel: viewModel)
        return viewController //Al haber metido el viewModel en el inicializador en la clase de LoginViewController, esta función lo que hace es introducir el LoginViewModel en una constante a la que nombramos viewModel. Acto seguido se le pide que retorne el LoginViewController con dicha constante como parámetro
    }
}
