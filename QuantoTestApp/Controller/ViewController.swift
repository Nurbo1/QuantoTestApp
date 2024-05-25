//
//  ViewController.swift
//  QuantoTestApp
//
//  Created by Нурбол Мухаметжан on 23.05.2024.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    
    private var photos: [Photo] = []
    private var allData: [Photo] = []
    private var filteredPhotos: [Photo] = []
    private var photoService = PhotoService()
    private var isSearch : Bool = false
    private let refreshControl = UIRefreshControl()
    private var currentPage = 1
    private var isLoading = false
    private var hasMoreData = true
//    let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
    private var previousOrientation: UIInterfaceOrientation?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        loadPhotos(page: currentPage)
        loadAllData()

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    // MARK: - Data
    func loadAllData(){
        photoService.fetchData { [weak self] data in
            self?.allData = data
        }
    }
    
    @objc func loadPhotos(page: Int) {
        guard !isLoading && hasMoreData else { return }
        
        isLoading = true
        
        photoService.fetchPhotos(page: page) { [weak self] newPhotos in
            guard let self = self else { return }
            
            
            if page == 1 {
                self.photos = newPhotos
            } else {
                self.photos.append(contentsOf: newPhotos)
            }
            self.filteredPhotos = self.photos
            self.isLoading = false
            self.refreshControl.endRefreshing()
            self.collectionView.reloadData()
        }
    }
    // MARK: - Actions
    
    @objc func dismissKeyboard() {
        print("dismissed")
        view.endEditing(true)
    }
    
    func deviceRotationTracker(){
        NotificationCenter.default.addObserver(self, selector: #selector(deviceIsRotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc func deviceIsRotated() {
        let currentOrientation = UIApplication.shared.statusBarOrientation
        if let previousOrientation = previousOrientation, previousOrientation != currentOrientation {
            collectionView.collectionViewLayout.invalidateLayout() // Invalidate layout on orientation change
            collectionView.reloadData()
        }
        previousOrientation = currentOrientation
        //        collectionView.reloadData()
    }
    
    func setupRefreshControl(){
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc func refresh(_ sender: AnyObject) {
        if isSearch{
            self.refreshControl.endRefreshing()
            collectionView.reloadData()
        }else{
            currentPage = 1
            hasMoreData = true
            searchBar.text = ""
            loadPhotos(page: currentPage)
        }
        //s
    }
    
    // MARK: - UI Components
    
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        
        searchBar.isUserInteractionEnabled = true
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.layer.cornerRadius = 20
        searchBar.searchTextField.backgroundColor = UIColor.lightGray
        searchBar.searchTextField.textColor = UIColor.black
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.leftView = nil
        searchBar.placeholder = "Search"
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = UIColor(white: 0.9, alpha: 1)
            textField.layer.cornerRadius = 10
            textField.clipsToBounds = true
            textField.textAlignment = .center
        }
        
        return searchBar
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsSelection = true
        collectionView.isUserInteractionEnabled = true
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
//        for recognizer in collectionView.gestureRecognizers ?? [] {
//            .require(toFail: recognizer)
//        }
        
        return collectionView
    }()
    
    
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .white
        setupViews()
        setupLayouts()
        setupRefreshControl()
//        setupTapGesture()
        setupSearchBar()
        deviceRotationTracker()
    }
    
//    func setupTapGesture(){
//        tap.cancelsTouchesInView = false // This allows taps to be recognized by other views
//        view.addGestureRecognizer(tap)
//    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
    }
    
    func setupViews(){
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        collectionView.addSubview(refreshControl)
    }
    
    func setupLayouts(){
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
}

// MARK: - CollectionView Data Source

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {
            fatalError("Failed to dequeue ")
        }
        
        
        let photo =  self.filteredPhotos[indexPath.row]
        cell.setupCell(with: photo)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == photos.count - 1 && !isLoading && !isSearch && hasMoreData{
            currentPage += 1
            loadPhotos(page: currentPage)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tapped")
        let photo = filteredPhotos[indexPath.row]
        let photoDetailViewController = PhotoDetailViewController()
        photoDetailViewController.photo = photo
        present(photoDetailViewController, animated: true, completion: nil)
    }
}

// MARK: - CollectionView Layouts

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        if UIDevice.current.orientation.isLandscape {
            return CGSize(width: (width-100)/3, height: height/2)
        }else{
            return CGSize(width: width * 0.89, height: height * 0.258)
        }
    }
}
// MARK: - SearchBar delegate


extension ViewController: UISearchBarDelegate{
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("started")
        isSearch = true
        searchBar.becomeFirstResponder()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("ended")
        isSearch = false
        dismissKeyboard()
//        collectionView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            print("cleared")
            isSearch = false
            dismissKeyboard()
            filteredPhotos = photos
            collectionView.reloadData()
        } else {
            print("heey")
            self.filteredPhotos = allData.filter { photo in
                return photo.title.range(of: searchText, options: .caseInsensitive) != nil
            }
            isSearch = true
            collectionView.reloadData()
        }
    }
}


