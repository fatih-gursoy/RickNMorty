//
//  ViewController.swift
//  RickNMorty
//
//  Created by Fatih Gursoy on 4.07.2022.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet private weak var listCollectionView: UICollectionView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    private var notificationCenter = NotificationCenter.default
    private var viewModel = CharacterListViewModel()
    private var pickerView = UIPickerView()
    private var toolBar = UIToolbar()
    
    private var isListView: Bool = false
    private var cellName = CharacterGridCell.identifier {
        didSet {
            configureCollectionView(with: self.cellName)
        }
    }
    
    private var isPageLoading: Bool = false
    private var pageNum: Int = 1 {
        didSet {
            getData()
        }
    }
    
    let changeViewButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        
        viewModel.delegate = self
        
        configureCollectionView(with: cellName)
        configureNavBar()
        getData()
        
        notificationCenter.addObserver(self, selector: #selector(update), name: NSNotification.Name(rawValue: "RefreshFavorites"), object: nil)
    }
    
    func getData() {
        viewModel.fetchCharacters(pageNum: pageNum)
    }
    
    @objc func update() {
        getData()
    }
    
    func configureNavBar() {
        
        let filterButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(configurePickerView))
        self.navigationItem.rightBarButtonItem = filterButton
        
        changeViewButton.setImage(UIImage(systemName: "square.grid.2x2.fill"), for: .normal)
        changeViewButton.setImage(UIImage(systemName: "list.bullet.rectangle.fill"), for: .selected)
        changeViewButton.addTarget(self, action: #selector(changeViewtapped), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: changeViewButton)
        
    }
    
    func configureCollectionView(with cellName: String) {
        
        listCollectionView.register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellName)
        listCollectionView.reloadData()
        
    }
    
    @objc func changeViewtapped() {
        
        changeViewButton.isSelected.toggle()
        isListView.toggle()
        
        if !isListView {
            cellName = CharacterGridCell.identifier
        } else {
            cellName = CharacterListCell.identifier
        }
        
    }
    
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.characters.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let characterVM = CharacterViewModel(character: viewModel.characters[indexPath.row])
        
        switch isListView {
            
        case false:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as? CharacterGridCell else { fatalError("Could not load") }
            cell.configureCell(viewModel: characterVM)
            return cell
            
        case true:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as? CharacterListCell else { fatalError("Could not load") }
            cell.configureCell(viewModel: characterVM)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var widthFactor, heightFactor: Double
        
        switch isListView {
            
        case true:
            widthFactor = 0.95
            heightFactor = 0.20
            
        case false:
            widthFactor = 0.45
            heightFactor = 0.45
        }
        
        let width = collectionView.bounds.width * widthFactor
        let height = collectionView.bounds.height * heightFactor
        return CGSize(width: width, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC else {fatalError("Couldn't load") }
        
        let characterVM = CharacterViewModel(character: viewModel.characters[indexPath.row])
        detailVC.viewModel = characterVM
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let contentHeight = listCollectionView.contentSize.height
        let scrollOffset = listCollectionView.contentOffset.y
        
        if (scrollOffset > contentHeight - listCollectionView.bounds.size.height) && !isPageLoading  {
            pageNum += 1
        }
    }
    
}

extension HomeVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        viewModel.filterByName(pageNum: 1, name: searchText)
        
    }
    
}

extension HomeVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    @objc func configurePickerView() {
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerView.contentMode = .bottom
        pickerView.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        
        pickerView.backgroundColor = UIColor.systemBackground
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        
        toolBar.barStyle = .black
        toolBar.items = [UIBarButtonItem.init(title: "Filter", style: .done, target: self, action: #selector(doneButtonTapped))]
        
        toolBar.sizeToFit()
        
        UIView.transition(with: self.view, duration: 0.5, options: [.transitionCrossDissolve] , animations: {
            self.view.addSubview(self.pickerView)
            self.view.addSubview(self.toolBar)
        })

    }
    
    @objc func doneButtonTapped() {
        
        viewModel.filterByStatus(pageNum: 1, status: "Alive")
        pickerView.removeFromSuperview()
        toolBar.removeFromSuperview()
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Status.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Status.allCases[row].rawValue
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        viewModel.filterByStatus(pageNum: 1, status: Status.allCases[row].rawValue)
        
    }
    
}


extension HomeVC: CharacterListDelegate {
    
    func updateUI() {
        
        isPageLoading = true
        
        DispatchQueue.main.async {
            self.listCollectionView.reloadData()
            self.isPageLoading = false
        }
    }
}

