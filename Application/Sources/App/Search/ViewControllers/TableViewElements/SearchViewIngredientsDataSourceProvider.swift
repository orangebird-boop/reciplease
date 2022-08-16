import UIKit

struct SearchViewIngredientsDataSourceProvider {

    enum Section {
        case first
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Section, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, String>

    let tableView: UITableView
    
//    var dataSource = SearchDataSource(tableView: tableView, cellProvider: (UITableView, IndexPath, RecipeIngredient))
    var dataSource: DataSource {
        makeDataSource()
    }

    func applySnapshot(ingredients: [String], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        
        snapshot.appendSections([.first])
        
        snapshot.appendItems(ingredients)
        
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    func makeDataSource() -> DataSource {
        DataSource(tableView: tableView) { tableView, indexPath, model in
            guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
                fatalError("This cell should be registerd")
            }
            
            tableViewCell.configure(with: model)
            
            return tableViewCell
        }
    }
    
}
