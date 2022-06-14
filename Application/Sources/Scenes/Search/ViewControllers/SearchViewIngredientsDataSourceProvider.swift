import UIKit

class SearchViewIngredientsDataSourceProvider {

    enum Section {
        case first
    }
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, RecipeIngredient>

    let tableView: UITableView
    
    private (set) var dataSource: DataSource

    var ingredients: [RecipeIngredient] = [] {
        didSet {
            applySnapshot(ingredients: ingredients)
        }
    }

    init(tableView: UITableView) {
        self.tableView = tableView

        dataSource = Self.makeDataSource(tableView: self.tableView)
        dataSource.delegate = self
    }

    func applySnapshot(ingredients: [RecipeIngredient], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        
        snapshot.appendSections([.first])
        
        snapshot.appendItems(ingredients)
        
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    static func makeDataSource(tableView: UITableView) -> DataSource {
        DataSource(tableView: tableView) { tableView, indexPath, model in
            guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
                fatalError("This cell should be registered")
            }
            
            tableViewCell.configure(with: model)
            
            return tableViewCell
        }
    }

    func delete(ingredient: RecipeIngredient) {
        ingredients.removeAll { $0 == ingredient}

        // TODO: Communicate the removal to the viewModel above
        applySnapshot(ingredients: ingredients)
    }
}

extension SearchViewIngredientsDataSourceProvider: DataSourceDelegate {

    func didDelete(ingredient: RecipeIngredient) {
        delete(ingredient: ingredient)
    }
}

protocol DataSourceDelegate: AnyObject {
    func didDelete(ingredient: RecipeIngredient)
}

class DataSource: UITableViewDiffableDataSource<SearchViewIngredientsDataSourceProvider.Section, RecipeIngredient> {

    weak var delegate: DataSourceDelegate?

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let element = itemIdentifier(for: indexPath) else {
                return
            }

            delegate?.didDelete(ingredient: element)
        }
    }
}
