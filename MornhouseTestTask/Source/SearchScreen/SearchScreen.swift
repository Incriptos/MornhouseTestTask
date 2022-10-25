import UIKit
import RealmSwift

final class SearchScreen: UIViewController {

  //MARK: - UI Properties
  private lazy var searchButton: UIButton = {
    let button = UIButton()
    button.setTitle("Get fact", for: .normal)
    button.backgroundColor = .systemBlue
    button.cornerRadius = 8.0
    button.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
    return button
  }()
  
  private lazy var randomNumberButton: UIButton = {
    let button = UIButton()
    button.setTitle("Get fact about random number", for: .normal)
    button.backgroundColor = .systemBlue
    button.cornerRadius = 8.0
    button.addTarget(self, action: #selector(randomNumberTapped), for: .touchUpInside)
    return button
  }()
  
  private lazy var searchTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Enter number ..."
    textField.keyboardType = .numberPad
    textField.borderStyle = .roundedRect
    textField.textAlignment = .center
    return textField
  }()
  
  private lazy var searchHistoryTableView: UITableView = {
    let tv = UITableView(frame: .zero, style: .plain)
    tv.backgroundColor = .none
    tv.estimatedRowHeight = 80.0
    tv.delegate = self
    tv.dataSource = self
    tv.register(cell: SearchHistoryCell.self)
    return tv
  }()
  
  //MARK: - Properties
  private var searchHistoryList: [NumberViewModel] = [] {
    didSet {
      searchHistoryTableView.reloadOnMain()
    }
  }
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    loadDataFromRealm()
    setupController()
    setupLayout()
  }
    
  //MARK: - Privates
  private func loadDataFromRealm() {
    searchHistoryList.removeAll()
    let realm = try? Realm()
    let objects = realm?.objects(NumberObject.self)
    objects?.forEach { object in
      searchHistoryList.append(NumberViewModel(object))
    }
  }
  
  public func deleteObject(_ object: Object) {
    let realm = try? Realm()
    realm?.delete(object)
  }
  
  //MARK: - Actions
  @objc private func searchTapped() {
    guard let text = searchTextField.text, !text.isEmptyOrWhitespace() else { return }
    switch text.isNumber() {
    case true:
      debugPrint(text)
      NetworkManager.shared.getNumber(number: text) {
        //
      } onFinish: {
        //
      } completion: { [weak self] result in
        guard let this = self else { return }
        switch result {
        case .success(let model):
          model.toPersistable()?.persist({ result in
            switch result {
            case true:
              this.loadDataFromRealm()
            case false:
              print("error")
            }
          })
        case .failure(let error):
          print(error)
        }
      }
    case false:
      debugPrint("No value in text field")
      return
    }
  }
  
  @objc private func randomNumberTapped() {
    NetworkManager.shared.getRandomNumber {
      //
    } onFinish: {
      //
    } completion: { [weak self] result in
      guard let this = self else { return }
      switch result {
      case .success(let model):
        this.searchTextField.text = model.number.toString()
        model.toPersistable()?.persist({ result in
          switch result {
          case true:
            this.loadDataFromRealm()
          case false:
            print("error")
          }
        })
      case .failure(let error):
        print(error)
      }
    }
  }
  
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension SearchScreen: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchHistoryList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(for: SearchHistoryCell.self, for: indexPath)
    let item = searchHistoryList[indexPath.row]
    cell.populate(item)
    return cell
  }
    
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc: NumberDetailScreen = NumberDetailScreen()
    let item = searchHistoryList[indexPath.row]
    vc.model = item
    navigationController?.pushViewController(vc, animated: true)
  }
        
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header: SearchHistoryHeader = SearchHistoryHeader()
    return header
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 32.0
  }
  
}

//MARK: - Setups
extension SearchScreen {
  
  private func setupController() {
    view.backgroundColor = .white
    navigationItem.title = "Number search"
  }
  
  private func setupLayout() {
    [searchButton, searchTextField, randomNumberButton, searchHistoryTableView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    NSLayoutConstraint.activate([
      searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
      searchButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
      searchButton.heightAnchor.constraint(equalToConstant: 40.0),
      searchButton.widthAnchor.constraint(equalToConstant: 100.0),
      searchTextField.centerYAnchor.constraint(equalTo: searchButton.centerYAnchor),
      searchTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
      searchTextField.rightAnchor.constraint(equalTo: searchButton.leftAnchor, constant: -8),
      searchTextField.heightAnchor.constraint(equalToConstant: 40.0),
      randomNumberButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 8),
      randomNumberButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
      randomNumberButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
      randomNumberButton.heightAnchor.constraint(equalToConstant: 40),
      searchHistoryTableView.topAnchor.constraint(equalTo: randomNumberButton.bottomAnchor, constant: 8),
      searchHistoryTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
      searchHistoryTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
      searchHistoryTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}
