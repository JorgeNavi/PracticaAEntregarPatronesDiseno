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
        viewModel.load()
        bind()

    }
    
    @IBAction func onRetryTapped(_ sender: Any) {
    }
    
    // Definimos la funcionalidad para cada estado
    private func bind() {
        viewModel.onStateChanged.bind { [weak self] state in
            switch state {
            case .loading:
                self?.renderLoading()
            case .loaded:
                self?.renderLoaded()
                print("hero id in view is: \(self!.viewModel.hero!.identifier)")
                //"14BB8E98-6586-4EA7-B4D7-35D6A63F5AA3"
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
    
  
    
    private func renderLoaded() {
        spinner.stopAnimating()
        heroNameLabel.text = viewModel.hero?.name
        heroDescriptionLabel.text = viewModel.hero?.description
        heroImageView.setImage(viewModel.hero!.photo)
        heroImageView.isHidden = false
        heroNameLabel.isHidden = false
        heroDescriptionLabel.isHidden = false
        retryBotton.isHidden = true
        errorContainer.isHidden = true
        errorLabel.isHidden = true
    }
    
    
}
