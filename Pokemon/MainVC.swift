
import UIKit

let cellIdentifier = "cell"

class MainVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(Cell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        
        setUI()
        
      
    }
    
    func setUI() {
        title = "Pokemon"
        let backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.contentMode = UIViewContentMode.scaleToFill
        backgroundImageView.image = UIImage(named: "background")
        view.addSubview(backgroundImageView)
        view.addSubview(collectionView!)
        collectionView?.backgroundColor = UIColor.clear
        
        // set constraints for collectionView
        collectionView?.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        collectionView?.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        view.rightAnchor.constraint(equalTo: (collectionView?.rightAnchor)!, constant: 8).isActive = true
        view.bottomAnchor.constraint(equalTo: (collectionView?.bottomAnchor)!, constant: 8).isActive = true
    }
    

    // UICollectionView delegates & datasource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? Cell {
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width/4, height: view.bounds.width/4)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
}
