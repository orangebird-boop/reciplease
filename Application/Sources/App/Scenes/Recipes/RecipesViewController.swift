import UIKit

class RecipesViewController: UIViewController {
    
    var viewModel: RecipesViewModelProtocol
    let defaultImage = UIImage(named: "defaultForkKnifeSpoon")

    let loadMoreButton = UIButton()
    
    init(viewModel: RecipesViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:}) has not been implemented")
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(RecipesTableViewCell.self, forCellReuseIdentifier: RecipesTableViewCell.identifier)
        return tableView
    }()
    
    private lazy var dataSource = makeDataSource()

    enum Section {
        case first
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Section, Recipe>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Recipe>
    
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        
        snapshot.appendSections([.first])
        
        snapshot.appendItems(viewModel.getRecipes())
        
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.topItem?.title = "Reciplease"
        
        tableView.delegate = self
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        loadMoreButton.setTitle("Load more recipes", for: .normal)
        loadMoreButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        loadMoreButton.backgroundColor = .systemGreen
        loadMoreButton.addTarget(self, action: #selector(loadMoreRecipes), for: .touchUpInside)
        view.addSubview(loadMoreButton)
        
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        applySnapshot()
    }
    
    func setupLayout() {
        [tableView, loadMoreButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margins.medium),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Margins.medium),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Margins.medium),
            tableView.bottomAnchor.constraint(equalTo: loadMoreButton.topAnchor, constant: -Margins.medium),
            
            loadMoreButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Margins.medium),
            loadMoreButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Margins.medium),
            loadMoreButton.heightAnchor.constraint(equalToConstant: 42),
            loadMoreButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Margins.small)
            ])
    }
    
    func makeDataSource() -> DataSource {
        DataSource(tableView: tableView) { tableView, indexPath, model in
            guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: RecipesTableViewCell.identifier, for: indexPath) as? RecipesTableViewCell else {
                fatalError("This cell should be registerd")
            }
            
            tableViewCell.configure(with: model)
            
            return tableViewCell
        }
    }
      
    func toggleLoadMoreButton(isEnabled: Bool) {
 
        loadMoreButton.isEnabled = isEnabled
        loadMoreButton.backgroundColor = isEnabled ? .systemGreen : .systemGray
        
    }
    
    @objc
    func loadMoreRecipes() {
        viewModel.loadMoreRecipes()
    }
}

extension RecipesViewController: RecipesViewModelDelegate {
    
    func didFindRecipes() {
        applySnapshot()
    }
    
    func noMoreRecipesToLoad() {
        loadMoreButton.isEnabled = false
        loadMoreButton.backgroundColor = .systemGray
}
    
}

extension RecipesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260.0 // Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recipe = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        let viewController = RecipeDetailsViewController(viewModel: RecipeDetailsViewModel(recipe: recipe))
        
        navigationController?.pushViewController(viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true )
    }
    
}
