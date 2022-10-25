import UIKit

final class SearchHistoryHeader: UIView {
  
  //MARK: - UI Properties
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Search history"
    label.textColor = .black
    label.font = .systemFont(ofSize: 12, weight: .semibold)
    return label
  }()
  
  //MARK: - Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
    setupLayout()
  }
  
}

//MARK: - Setups
extension SearchHistoryHeader {
  
  private func setupView() {
    backgroundColor = .white
  }
  
  private func setupLayout() {
    [titleLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    NSLayoutConstraint.activate([
      titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
      titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16)
    ])
  }
    
}
