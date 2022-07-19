import UIKit

class SearchResultViewController: UIViewController {
    
    let viewModel: SearchResultViewModel
    let defaultImage = UIImage(named: "defaultForkKnifeSpoon")
    
    init(viewModel: SearchResultViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:}) has not been implemented")
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.identifier)
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
        
        snapshot.appendItems(viewModel.recipes)
        
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGroupedBackground
        
        tableView.delegate = self
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margins.medium),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Margins.medium),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Margins.medium),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Margins.medium)
        ])
        applySnapshot()
    }
    
    func makeDataSource() -> DataSource {
        DataSource(tableView: tableView) { tableView, indexPath, model in
            guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier, for: indexPath) as? SearchResultTableViewCell else {
                fatalError("This cell should be registerd")
            }
            
            tableViewCell.configure(with: model)
            
            return tableViewCell
        }
    }
}

extension SearchResultViewController: UITableViewDelegate {
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

import SwiftUI

struct SearchResultViewControllerPreview: PreviewProvider {
    static var previews: some View {
        Group {
            SearchResultViewControllerRepresentable()
                .previewDevice("iPhone 13")
            SearchResultViewControllerRepresentable()
                .previewDevice("iPhone SE (2nd generation)")
        }
    }
}

struct SearchResultViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        let recipe = Recipe(name: "Hambourger", foodImage: nil, url: "", yield: 20, ingredientLines: ["lala", "lili"], totalTime: 3)
        let recipe2 = Recipe(name: "Cheeseburger", foodImage: nil, url: "", yield: 20, ingredientLines: ["lolo", "lulu"], totalTime: 4)
        let model = SearchResultViewModel(recipes: [recipe, recipe2])
        let viewController = SearchResultViewController.init(viewModel: model)
        let nvc = UINavigationController(rootViewController: viewController)
        return nvc
    }
    
    typealias UIViewControllerType = UINavigationController
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        
    }
    
}
