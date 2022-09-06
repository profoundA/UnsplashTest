//
//  PhotosViewModel.swift
//  UnsplashTest
//
//  Created by Andrey Lobanov on 05.09.2022.
//

import UIKit

protocol PhotosViewModel {
    
    func getInsets() -> UIEdgeInsets
    func photosCount(isFiltering: Bool) -> Int
    func getPhotos(completion: @escaping () -> Void)
    func searchBarIsEmpty(_ searchController: UISearchController) -> Bool
    func filterSearchContent(_ text: String, completion: @escaping () -> Void)
    func pushDetailsVC(_ nc: UINavigationController, at indexPath: IndexPath, isFiltering: Bool)
    func pushDetailsfromFav(_ nc: UINavigationController, at indexPath: IndexPath, photo: [Photo])
    func setupCollection(collection: UICollectionView, indexPath: IndexPath, isFiltering: Bool) -> UICollectionViewCell
    func collectionItemSize(indexPath: IndexPath, view: UIView, isFiltering: Bool) -> CGSize
}

class PhotosViewModelImpl: PhotosViewModel {
    
    private let itemsPerRow: CGFloat = 2
    
    private let sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    private var photos = [Photo]()
    
    private var searchPhotos = [Photo]()
    
    func photosCount(isFiltering: Bool) -> Int {
        if isFiltering {
            return searchPhotos.count
        } else {
            return photos.count
        }
    }
    
    func getInsets() -> UIEdgeInsets {
        return sectionInsets
    }
    
    func getPhotos(completion: @escaping () -> Void) {
        NetworkService.shared.fetchPhotos { photos in
            self.photos = photos
            completion()
        }
    }
    
    
    // MARK: Search controller
    func searchBarIsEmpty(_ searchController: UISearchController) -> Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    func filterSearchContent(_ text: String, completion: @escaping () -> Void) {
        NetworkService.shared.searchPhotos(searchText: text) { photos in
            self.searchPhotos = photos!.results
            completion()
        }
    }
    
    // MARK: Details controller
    
    func pushDetailsVC(_ nc: UINavigationController, at indexPath: IndexPath, isFiltering: Bool) {
        let vc = DetailsViewController()
        
        var photo: Photo
        
        if isFiltering {
            photo = searchPhotos[indexPath.row]
        } else {
            photo = photos[indexPath.row]
        }
        
        vc.photo = photo
        vc.imageView.sd_setImage(with: URL(string: photo.urls.regular))
        vc.authorLabel.text = "Author: \(photo.user.name)"
        vc.createdLabel.text = "Created at: \(photo.created_at.prefix(10))"
        vc.locationLabel.text = "Location: \(photo.user.location ?? "No information")"
        vc.downloadsLabel.text = "Downloads: \(photo.downloads ?? 0)"
        
        nc.pushViewController(vc, animated: true)
    }
    
    func pushDetailsfromFav(_ nc: UINavigationController, at indexPath: IndexPath, photo: [Photo]) {
        let photo = photo[indexPath.row]
        let vc = DetailsViewController()
        vc.photo = photo
        vc.imageView.sd_setImage(with: URL(string: photo.urls.regular))
        vc.authorLabel.text = "Author: \(photo.user.name)"
        vc.createdLabel.text = "Created at: \(photo.created_at.prefix(10))"
        vc.locationLabel.text = "Location: \(photo.user.location ?? "No information")"
        vc.downloadsLabel.text = "Downloads: \(photo.downloads ?? 0)"
        vc.favoritesButton.isHidden = true
        nc.pushViewController(vc, animated: true)
    }
    
    // MARK: CollectionView setup
    func setupCollection(collection: UICollectionView, indexPath: IndexPath, isFiltering: Bool) -> UICollectionViewCell {
        guard let cell = collection.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseID, for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        
        var photo: Photo
        
        if isFiltering {
            photo = searchPhotos[indexPath.row]
        } else {
            photo = photos[indexPath.row]
        }
        
        cell.setupCell = photo
        return cell
    }
    
    func collectionItemSize(indexPath: IndexPath, view: UIView, isFiltering: Bool) -> CGSize {
        var photo: Photo
        if isFiltering {
            photo = searchPhotos[indexPath.row]
        } else {
            photo = photos[indexPath.row]
        }
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let height = CGFloat(photo.height) * widthPerItem / CGFloat(photo.width)
        return CGSize(width: widthPerItem, height: height)
    }
    
}
