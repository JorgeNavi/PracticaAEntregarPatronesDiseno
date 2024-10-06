import UIKit

final class HeroDetailViewController: UIViewController {
    
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    @IBOutlet private weak var heroImageView: AsyncImageView!
    @IBOutlet private weak var heroNameLabel: UILabel!
    @IBOutlet private weak var heroDescriptionLabel: UILabel!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var retryBotton: UIButton!
    @IBOutlet private weak var errorContainer: UIStackView!
    
    private let viewModel: HeroDetailViewModel
    
    init(viewModel: HeroDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "HeroDetailView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.load()
    }
    
    @IBAction func onRetryTapped(_ sender: Any) {
    }
    
    // Definimos la funcionalidad para cada estado
    private func bind() {
        viewModel.onStateChanged.bind { [weak self] state in
            switch state {
            case .loading:
                self?.renderLoading()
            case .loaded(let hero):
                self?.renderLoaded(hero)
            case .error(let reason):
                self?.renderError(reason)
            }
        }
    }
    
    //Hacemos como en el login funciones para cada estado
    private func renderError(_ reason: String) {
        spinner.stopAnimating()
        errorContainer.isHidden = false
        errorLabel.text = reason
        heroImageView.isHidden = true
        heroNameLabel.isHidden = true
        heroDescriptionLabel.isHidden = true
        retryBotton.isHidden = false
    }
    
    private func renderLoading() {
        spinner.startAnimating()
        errorContainer.isHidden = true
        errorLabel.isHidden = true
        heroImageView.isHidden = true
        heroNameLabel.isHidden = true
        heroDescriptionLabel.isHidden = true
        retryBotton.isHidden = true
    }
    
  
    
    private func renderLoaded(_ hero: Hero) {
        spinner.stopAnimating()
        heroNameLabel.text = hero.name
        heroDescriptionLabel.text = hero.description
        heroImageView.setImage(hero.photo) //Cargamos la imagen con el async
        retryBotton.isHidden = true
        errorContainer.isHidden = true
        errorLabel.isHidden = true
    }
    
    
}
