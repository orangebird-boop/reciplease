import UIKit

class SerachTableViewCell: UITableViewCell{
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
        {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupViews()
        }

        private func setupViews()
        {
            // Nothing yet.
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
