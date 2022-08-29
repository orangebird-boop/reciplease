import UIKit

enum Section {
    case first
}

protocol SearchDataSourceDelegate: AnyObject {
    func didDelete(ingredient: String)
}

class SearchDataSource: UITableViewDiffableDataSource<Section, String> {
    
    weak var delegate: SearchDataSourceDelegate?
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete, let item = itemIdentifier(for: indexPath) {
                delegate?.didDelete(ingredient: item)
        }
    }
}
