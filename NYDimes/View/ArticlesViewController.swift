//
//  ArticlesViewController.swift
//  NYDimes
//
//  Created by John Kim on 10/15/20.
//

import UIKit
import NVActivityIndicatorView

class ArticlesViewController: UIViewController{
    
    //MARK:- IBOutlets
    @IBOutlet weak var articleCollectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var typePicker: UIPickerView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var loadingIcon: NVActivityIndicatorView!
    
    //MARK:- Properties
    let viewModel = ArticlesViewModel()
    var listOfArticles = [ArticleModel]()
    let typePickerData = ["emailed","shared","viewed"]
    let daysPickerData = [1,7,30]
    var type = "emailed"
    var days = 1
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        getArticles()
        configureCollectionView()
        configureLoading()
        configPickerView()
//        configButton()
    }
    
    //MARK:-- Configuration & Layout
    func getArticles(){
        viewModel.articleAPI.delegate = self
        viewModel.getArticles(type, days){ (articleArray) in
            DispatchQueue.main.async {
                self.loadingIcon.stopAnimating()
                self.listOfArticles = articleArray
                self.articleCollectionView.reloadData()
            }
        }
    }
    
    func configureCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.size.width/3, height: view.frame.size.height/3)
        
        articleCollectionView.delegate = self
        articleCollectionView.dataSource = self
        articleCollectionView.register(ArticleCell.self, forCellWithReuseIdentifier: ArticleCell.identifier)
    }
    
    func configureLoading(){
        
    }
    
    func configPickerView(){
        typePicker.delegate = self
        typePicker.dataSource = self
        typePicker.layer.cornerRadius = 15
        typePicker.setValue(UIColor.black, forKeyPath: "textColor")
//        typePicker.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.7)
    }
    
//    func configButton(){
//        searchButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.3)
//    }
    
    //MARK:- User Interaction
    
    @IBAction func searchButton(_ sender: UIButton) {
        getArticles()
    }
}

//MARK:- CollectionView Data Source
extension ArticlesViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCell.identifier, for: indexPath) as! ArticleCell
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        
        //datasource for all cell properties
        cell.article = listOfArticles[indexPath.row]
        cell.configureImage(with: #imageLiteral(resourceName: "exampleBackground2"))
        cell.configureTitle(with: listOfArticles[indexPath.row].title ?? "No Title")
        cell.configureButton()
        cell.configureAuthors(authors: listOfArticles[indexPath.row].author ?? "Authors Unknown")
        cell.configureArrowButton()
        
        return cell
    }

}


//MARK: - CollectionView Delegate Framing Layout
extension ArticlesViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.width * 0.95, height: collectionView.frame.height * 0.3)

    }
}

extension ArticlesViewController: UICollectionViewDelegate{
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("deselectie")
    }
    
}
//MARK:-- UIPicker Delegate & DataSource
extension ArticlesViewController: UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(component == 1){
            type = typePickerData[row]
        }
        if(component == 3){
            days = daysPickerData[row]
        }
    }
}
extension ArticlesViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 1){
            return typePickerData.count
        }else if(component == 3){
            return daysPickerData.count
        }else{
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? NYPickerLabel) ?? NYPickerLabel()

        // where data is an Array of String
        switch component {
        case 0:
            label.text = "Type:"
        case 1:
            label.text = typePickerData[row]
        case 2:
            label.text = "Days:"
        case 3:
            label.text = "\(daysPickerData[row])"
        default:
            print("nothing")
        }
        return label
    }
    
}

//MARK:- Loading Delegate
extension ArticlesViewController: ArticleManagerDelegate{
    func isLoading() {
        loadingIcon.startAnimating()
    }
    
    
}
