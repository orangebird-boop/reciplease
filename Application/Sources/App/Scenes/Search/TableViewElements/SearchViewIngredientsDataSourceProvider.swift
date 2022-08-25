import UIKit

struct SearchViewIngredientsDataSourceProvider {
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, String>

    let tableView: UITableView
    
    var dataSource: SearchDataSource
    
    init(tableView: UITableView) {
        self.tableView = tableView
        dataSource = Self.makeDataSource(for: self.tableView)
    }

    func applySnapshot(ingredients: [String], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        
        snapshot.appendSections([.first])
        
        snapshot.appendItems(ingredients)
        
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    static func makeDataSource(for tableView: UITableView) -> SearchDataSource {
        SearchDataSource(tableView: tableView) { tableView, indexPath, model in
            guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
                fatalError("This cell should be registerd")
            }
            
            tableViewCell.configure(with: model)
            
            return tableViewCell
        }
    }
    
}
