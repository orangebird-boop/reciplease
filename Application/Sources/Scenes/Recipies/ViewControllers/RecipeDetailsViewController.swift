import Foundation
import UIKit

class RecipeDetailsViewController: UIViewController {

    // MARK: - Properties

    let viewModel: RecipeDetailsViewModel

    // MARK: - Initialization
    
    init(viewModel: RecipeDetailsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
    }
}
