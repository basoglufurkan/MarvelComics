//
//  CharacterDetailVC.swift
//  MarvelProject
//
//  Created by Furkan Başoğlu on 4.09.2021.
//

import UIKit

class CharacterDetailVC: UIViewController {
    
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var tblCharacterDetails: UITableView!
    
    var character:Character!
    private var viewModel: CharacterDetailViewModel!

    override func viewDidLayoutSubviews() {
        characterImageView.layer.cornerRadius = 10
        characterImageView.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblCharacterDetails.rowHeight = 50
        self.viewModel = CharacterDetailViewModel(character: character)
        self.viewModel.loadCharacterData()
        tblCharacterDetails.reloadData()
        updateHeader()
 
    }
        
        func updateHeader(){
            let headerModel:CharacterDetailHeaderModel = viewModel.getHeaderModel()
            favoriteImageView.isHidden = !headerModel.favorited
            lblTitle.text = headerModel.title
            //characterImageView.image =
             if let url = headerModel.imageURL {
                 characterImageView.setImgWebUrl(url: url, isIndicator: true)
           }
        }

    @IBAction func optionButtonAction(_ sender: UIBarButtonItem) {
        
        let options = CharacterOption.allCases.filter { (option) -> Bool in
            switch option {
            case .favorite:
                return !GFunctions.shared.isFavorited(character)
            case .unfavorite:
                return GFunctions.shared.isFavorited(character)
            }
        }
        
        let alert = UIAlertController(title: "", message: "\(String(describing: character.name))", preferredStyle: .actionSheet)
            
        alert.addAction(UIAlertAction(title: options.first?.title, style: .default , handler:{ (UIAlertAction)in
            
            if self.favoriteImageView.isHidden{
                if GFunctions.shared.favorite(self.character){
                    self.favoriteImageView.isHidden = false
                }
            }else{
                if GFunctions.shared.unfavorite(self.character){
                    self.favoriteImageView.isHidden = true

                    print("Successfully Done")
                }
            }
            }))
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
                print("User click Dismiss button")
            }))
            self.present(alert, animated: true, completion: {
                print("completion block")
            })
    }
}

extension CharacterDetailVC: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        print("viewModel.numberOfSections:\(viewModel.numberOfSections)")
        return viewModel.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(at: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let model = viewModel.viewModelForCell(at: indexPath)

        switch model {
        case let model as CharacterDetailHeaderModel:
            return UITableViewCell()
            
        case let dto as CharacterSectionContent:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterDetailTableViewCell", for: indexPath) as! CharacterDetailTableViewCell
            cell.lblName.text = dto.title
            return cell
            
        case let dto as NoContent:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            cell.textLabel?.text = dto.title
            return cell
         
        default:
            return UITableViewCell()

            //return UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }

//        switch cell {
//        case _ as ActionTableViewCell:
//
//            let section = viewModel.characterDetailSection(at: indexPath)
//            let animation = UITableView.RowAnimation.fade
//
//            tableView.beginUpdates()
//
//            if section.preview {
//                tableView.insertRows(at: viewModel.updatePreviewForContent(at: indexPath), with: animation)
//            } else {
//                tableView.deleteRows(at: viewModel.updatePreviewForContent(at: indexPath), with: animation)
//            }
//
//            tableView.endUpdates()
//
//            tableView.beginUpdates()
//            tableView.reloadRows(
//                at: [viewModel.indexPathForAction(at: indexPath)],
//                with: animation
//            )
//            tableView.endUpdates()
//
//        default:
//            break
//        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeader(at: section)
    }

}
