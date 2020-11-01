//
//  MoviesViewController.swift
//  NYDimes
//
//  Created by John Kim on 10/31/20.
//

import UIKit

class MoviesViewController :UIViewController {
    
    //MARK:-- Properties
    @IBOutlet weak var typePicker: UIPickerView!
    @IBOutlet weak var searchButton: NYSearchButton!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    var movieReviews = [MovieModel]()
    let viewModel = MoviesViewModel()
    
    let pickerTypeLabels = Const.Movies.typePickerData
    let pickerOrderLabels = Const.Movies.orderPickerData
    
    var type : String?
    var order : String?
    
    //MARK:-- User Interaction
    @IBAction func searchMovies(_ sender: Any) {
        guard let type = type, let order = order else {return}
        fetchMovies(type: type, order: convertOrderText(order: order))
    }
    
    //MARK:-- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewConfig()
        configPickerView()
        fetchMovies(type: pickerTypeLabels[0], order: convertOrderText(order: pickerOrderLabels[0]))
        
    }
    
    //MARK:-- VC Configurations
    
    func collectionViewConfig(){
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        moviesCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
    }
    
    func configPickerView(){
        typePicker.delegate = self
        typePicker.dataSource = self
        typePicker.layer.cornerRadius = 15
        typePicker.setValue(UIColor.black, forKeyPath: "textColor")
    }
    
    func fetchMovies(type: String, order: String){
        viewModel.getMovies(type: type, order: order){ (moviesResult) in
            DispatchQueue.main.async {
                print("triggered")
                self.movieReviews = moviesResult
                self.moviesCollectionView.reloadData()
            }
        }
    }
    
}
//MARK: - CollectionView Datasource
extension MoviesViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieReviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        //setting cell properties here
        var currentMovie = movieReviews[indexPath.row]
        if let imgUrl = currentMovie.multimedia?.src {
            cell.imageURL = imgUrl
        }
        cell.movieTitle.text = currentMovie.display_title
        cell.movieDescription.text = currentMovie.summary_short
        cell.moviePublished.text = currentMovie.publication_date
        
        return cell
        
    }
    
    
}
//MARK: - CollectionView Delegate
extension MoviesViewController : UICollectionViewDelegate{
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        <#code#>
//    }
    
    
}

//MARK: - CollectionView Delegate Framing Layout
extension MoviesViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.width * 0.95, height: collectionView.frame.height * 0.25)

    }
}

//MARK:-- UIPicker Delegate

extension MoviesViewController: UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(component == 1){
            type = pickerTypeLabels[row]
        }
        if(component == 3){
            order = pickerOrderLabels[row]
        }
    }
}
extension MoviesViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 1){
            return pickerTypeLabels.count
        }else if(component == 3){
            return pickerOrderLabels.count
        }else{
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? NYPickerLabel) ?? NYPickerLabel()
        let titleLabel = (view as? NYPickerTitleLabel) ?? NYPickerTitleLabel()

        // where data is an Array of String
        switch component {
        case 0:
            titleLabel.text = "Type:"
            return titleLabel
        case 1:
            label.text = pickerTypeLabels[row]
        case 2:
            titleLabel.text = "Order:"
            return titleLabel
        case 3:
            label.text = "\(pickerOrderLabels[row])"
        default:
            print("nothing")
        }
        
        return label
    }
    
}


