//
//  CharacterVC.swift
//  MarvelProject
//
//  Created by Furkan Başoğlu on 4.09.2021.
//

import UIKit
import CommonCrypto

class CharacterVC: UIViewController {
    @IBOutlet weak var characterCollectionView: UICollectionView!
    
    var viewModel:CharacterViewModel!
    var apiService:ApiService!
    
    internal let leftRightInset: CGFloat = 10
    internal let cellSpacing: CGFloat = 15
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = "Search Characters"
        controller.searchBar.delegate = self
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        
        self.viewModel = CharacterViewModel(apiService: MarvelAPI.shared.characterService)
        self.viewModel.loadCharacters()
        
        self.viewModel.completion = { [weak self] in
            print("CryptoCurrencyViewModel")
            DispatchQueue.main.async {
                self?.characterCollectionView.reloadData()
            }
        }
        
        self.viewModel.searchCompletion = { [weak self] in
            print("searchCompletion")
            DispatchQueue.main.async {
                self?.characterCollectionView.reloadData()
            }
        }

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.characterCollectionView.reloadData()
    }
}


extension CharacterVC : UICollectionViewDataSource, UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfCharacters
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.viewModel(at: indexPath) {
        case let model as CharacterCollectionVCModel:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCVC", for: indexPath) as! CharacterCVC
            cell.configure(with: model)

            return cell
        default:
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let character = viewModel.character(at: indexPath) {
            let detailVC:CharacterDetailVC = self.storyboard!.instantiateViewController(identifier: "CharacterDetailVC") as CharacterDetailVC
            detailVC.character = character
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if self.viewModel.numberOfCharacters >= 20 && self.viewModel.numberOfCharacters - 4 <= indexPath.row {
            self.viewModel.loadNextPage()
        }
    }


   
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CharacterVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let cellWidth : CGFloat = (characterCollectionView.frame.size.width - leftRightInset * 2 - cellSpacing) / 2
            let cellSize = CGSize(width: cellWidth , height:200)
            
                return cellSize
        }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: leftRightInset, left: leftRightInset, bottom: leftRightInset, right: leftRightInset)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
}

extension CharacterVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else {
            viewModel.isFilter = false
            return
        }
        print("text:\(text)")
        viewModel.searchCharacter(with: text)

//        viewModel.reset()
//        viewModel.searchCharacter(with: text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        guard let text = searchBar.text else {
            return
        }
        print("textdgdfg:\(text)")
        //viewModel.reset()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.isFilter = false
        characterCollectionView.reloadData()
    }
}


