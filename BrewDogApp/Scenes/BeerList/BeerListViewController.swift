//
//  BeerListViewController.swift
//  BrewDogApp
//
//  Created by Pia on 27/11/2017.
//  Copyright (c) 2017 Pia. All rights reserved.
//

import UIKit
import Cartography

class BeerListViewController: UIViewController {

    //MARK: - Stored properties
    var presenter: BeerListPresenterProtocol!
    
    var collectionView: UICollectionView? = nil
    
    var searchBar: UISearchBar {
        let bar: UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width * 2/3, height: 20))
        bar.placeholder = Style.ListTypes.searchPlaceholder
        bar.delegate = self
        bar.barStyle = .blackTranslucent
        bar.returnKeyType = .search
        
        return bar
    }
    
    var items: [BeerViewModel] = []
    var ascendant: Bool = true
    
    var spinner: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)

    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        layout()
    }

    //MARK: - Private API
    private func layout() {
        
        view.backgroundColor = Style.ListTypes.collectionBGColor
        
        //Collection view setup
        collectionView = {
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
            layout.itemSize = CGSize(width: self.view.frame.width, height: (self.view.frame.height/3))
            
            let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(BeerCell.self, forCellWithReuseIdentifier: "BeerCell")
            collectionView.backgroundColor = Style.ListTypes.collectionBGColor
            
            return collectionView
        }()
        
        //Navigation
        //Add search bar and %order button
        self.navigationController?.navigationBar.tintColor = Style.ListTypes.titleColor
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
        self.navigationItem.rightBarButtonItem =
            UIBarButtonItem(
                title: Style.ListTypes.orderButton,
                style: UIBarButtonItemStyle.plain,
                target: self,
                action: #selector(orderList))
        
        //Add collection view
        guard let collection = collectionView else { return }
        self.view.addSubview(collection)
        
        //Add spinner
        self.view.addSubview(spinner)
        constrain(spinner) { spinner in
            let parent = spinner.superview!
            
            spinner.centerX == parent.centerX
            spinner.centerY == parent.centerY
        }
    }
    
    @objc private func orderList() {
        //If spinner is animating (previous search in progress) ignore order
        guard !spinner.isAnimating else { return }
        
        print("order list clicked")
        ascendant = !ascendant
        ascendant == true ? orderItemsAscendant() : orderItemsDescendant()
    }
    
    private func orderItemsAscendant() {
        items = items.sorted{ $0.abv < $1.abv }
        print(items.map { $0.abv })
        
        //Reload data and scroll to top
        guard items.count > 0 else { return }
        collectionView?.reloadSections(IndexSet(integer: 0))
        collectionView?.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    private func orderItemsDescendant() {
        items = items.sorted{ $0.abv > $1.abv }
        print(items.map { $0.abv })
        
        //Reload data and scroll to top
        collectionView?.reloadSections(IndexSet(integer: 0))
        collectionView?.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
}

extension BeerListViewController: BeerListUserInterfaceProtocol {
    func configureFor(viewModel: [BeerViewModel]) {
        spinner.stopAnimating()
        
        self.items = viewModel
        ascendant = true
        orderItemsAscendant()
    }
    
    func showSpinner() {
        spinner.startAnimating()
    }
    
    func removeSpinner() {
        spinner.stopAnimating()
    }
}

extension BeerListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BeerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BeerCell", for: indexPath) as! BeerCell
        cell.configure(model: self.items[indexPath.item])
        return cell
    }
}

extension BeerListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Action when item clicked
    }
}

extension BeerListViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        //If spinner is animating (previous search in progress) keyboard does not show
        guard !spinner.isAnimating else { return false }
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        //If spinner is animating (previous search in progress)
        guard let text = searchBar.text,
        !spinner.isAnimating else { return }
        presenter.askedFood(text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
