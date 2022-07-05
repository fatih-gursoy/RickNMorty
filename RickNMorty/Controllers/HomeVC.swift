//
//  ViewController.swift
//  RickNMorty
//
//  Created by Fatih Gursoy on 4.07.2022.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet private weak var listCollectionView: UICollectionView!
        
    private var viewModel = CharacterListViewModel()
    private var pageNum: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        getData()
        
    }
    
    func configureCollectionView() {
        
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        
        listCollectionView.register(UINib(nibName: CharacterCell.identifier, bundle: nil), forCellWithReuseIdentifier: CharacterCell.identifier)
        
    }
    
    func getData() {
        
        viewModel.delegate = self
        viewModel.fetchCharacters(pageNum: pageNum)
        
    }


}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.characters.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell else { fatalError("Could not load") }
        
        let characterVM = CharacterViewModel(character: viewModel.characters[indexPath.row])
        cell.configureCell(viewModel: characterVM)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width * 0.45
        let height = collectionView.bounds.height * 0.45
        
        return CGSize(width: width, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC else {fatalError("Couldn't load") }
        
        let characterVM = CharacterViewModel(character: viewModel.characters[indexPath.row])
        detailVC.viewModel = characterVM
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
}

extension HomeVC: CharacterListDelegate {
    
    func updateUI() {
        
        DispatchQueue.main.async {
            self.listCollectionView.reloadData()
        }
    }
    
    
    
    
}

