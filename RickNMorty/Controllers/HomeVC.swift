//
//  ViewController.swift
//  RickNMorty
//
//  Created by Fatih Gursoy on 4.07.2022.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var listCollectionView: UICollectionView!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        
        
    }
    
    func configureCollectionView() {
        
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        
        listCollectionView.register(UINib(nibName: CharacterCell.identifier, bundle: nil), forCellWithReuseIdentifier: CharacterCell.identifier)
        
    }


}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 15
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell else { fatalError("Could not load") }

        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width * 0.3
        let height = collectionView.bounds.height * 0.3
        
        return CGSize(width: width, height: height)
        
    }
    
    
    
    
}

