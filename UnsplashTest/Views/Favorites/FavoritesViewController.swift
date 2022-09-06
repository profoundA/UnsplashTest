//
//  FavoritesViewController.swift
//  UnsplashTest
//
//  Created by Andrey Lobanov on 05.09.2022.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var favoritePhotos = [Photo]()
    
    var viewModel: PhotosViewModel?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PhotosViewModelImpl()
        setupViews()
        setupDelegates()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        tableView.frame = view.bounds
        view.addSubview(tableView)
        navigationItem.title = "Избранное"
    }
    
    private func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: TableView delegate & data source
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoritePhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let photo = favoritePhotos[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.imageView?.sd_setImage(with: URL(string: photo.urls.regular))
        cell.imageView?.contentMode = .scaleAspectFit
        cell.textLabel?.text = photo.user.name
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.pushDetailsfromFav(navigationController!, at: indexPath, photo: favoritePhotos)
    }
}
