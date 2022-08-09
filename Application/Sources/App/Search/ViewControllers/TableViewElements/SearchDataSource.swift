import UIKit

enum Section {
    case first
}

class SearchDataSource: UITableViewDiffableDataSource<Section, RecipeIngredient> {
    // making editing possible
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var snapshot = self.snapshot()
            
            if let item = itemIdentifier(for: indexPath) {
                snapshot.deleteItems([item])
                apply(snapshot, animatingDifferences: true)
            }
        }
    }
}
