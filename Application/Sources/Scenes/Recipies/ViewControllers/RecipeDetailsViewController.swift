import Foundation
import UIKit

class RecipeDetailsViewController: UIViewController {
    let viewModel: SearchResultViewModel
    private (set) var recipes: [EdamamRecipe] = []
    
    init(viewModel: SearchResultViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
