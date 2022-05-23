import UIKit

protocol RecipeDetailsViewDelegate: AnyObject {
    
}

class RecipeDetailsView: UIView {
    let recipeTitle = UILabel()
    let recipeDetails = UITextView()
    
    weak var delegate: RecipeDetailsViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupRecipeDetailsView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupRecipeDetailsView() {
        setupView()
        setupLayout()
    }
    
    private func setupView() {
        recipeTitle.text = "From Euro:"
        recipeTitle.font = UIFont.preferredFont(forTextStyle: .title1)
        recipeTitle.textAlignment = .left
        recipeTitle.textColor = .darkGray
        addSubview(recipeTitle)
        
    }

    func setupLayout() {

    }
}
