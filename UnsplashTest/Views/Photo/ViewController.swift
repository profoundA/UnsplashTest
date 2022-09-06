//
//  ViewController.swift
//  UnsplashTest
//
//  Created by Andrey Lobanov on 05.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    private var viewModel: PhotosViewModel?
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.placeholder = "Найти фото..."
        controller.searchBar.backgroundColor = .clear
        controller.searchBar.sizeToFit()
        controller.searchBar.accessibilityScroll(.down)
        return controller
    }()
    
    private var isFiltering: Bool {
        guard let viewModel = viewModel else { return false }
        return searchController.isActive && !(viewModel.searchBarIsEmpty(searchController))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PhotosViewModelImpl()
        setupCollectionView()
        setupViews()
        setupDeleagtes()
        setupConstraints()
        
        viewModel?.getPhotos {
            self.collectionView?.reloadData()
        }
    }
}

// MARK: Setup views && delegates
private extension ViewController {
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.size.width/3) - 4,
                                 height: (view.frame.size.width/3 - 4))
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseID)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView!.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView!.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView!.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        navigationItem.title = "Фото"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
    private func setupDeleagtes() {
        collectionView?.delegate = self
        collectionView?.dataSource = self
        searchController.searchResultsUpdater = self
    }
}

// MARK: CollectioView data source
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.photosCount(isFiltering: isFiltering) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        viewModel?.setupCollection(collection: collectionView, indexPath: indexPath, isFiltering: isFiltering) ?? UICollectionViewCell()
    }
}

// MARK: CollectioView delegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.pushDetailsVC(self.navigationController!, at: indexPath, isFiltering: isFiltering)
    }
}

// MARK: CollectioView flow layout delegate
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewModel?.collectionItemSize(indexPath: indexPath, view: view, isFiltering: isFiltering) ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        viewModel?.getInsets() ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        viewModel?.getInsets().left ?? .zero
    }
}

// MARK: Search result updating
extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel?.filterSearchContent(searchController.searchBar.text!, completion: {
            self.collectionView?.reloadData()
        })
    }
}
