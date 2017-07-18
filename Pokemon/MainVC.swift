
import UIKit
import AVFoundation

let cellIdentifier = "cell"

class MainVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var pokemonArray: [Pokemon]!
    var musicPlayer: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonArray = [Pokemon]()
        
        collectionView?.register(Cell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        
        setUI()
        
        parsePokemonCSV()
        
        initAudio()
    }
    
    func setUI() {
        
        // use pokemon.ttf fonts
        let titleLabel = UILabel(frame: (navigationController?.navigationBar.bounds)!)
        titleLabel.font = UIFont(name: "pokemon", size: 14)
        titleLabel.textAlignment = .center
        titleLabel.text = "Pokemon!"
        navigationController?.navigationBar.addSubview(titleLabel)
        
        // add a music barButton and assign function call to it
        let musicButton = UIButton(type: UIButtonType.custom)
        musicButton.setBackgroundImage(UIImage(named: "music"), for: UIControlState.normal)
        musicButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let musicBarButton = UIBarButtonItem(customView: musicButton)
        navigationItem.rightBarButtonItem = musicBarButton
        // register function to musicBarButton
        musicButton.addTarget(self, action: #selector(musicButtonPressed(sender:)), for: UIControlEvents.touchUpInside)
        
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
    
    func initAudio() {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func musicButtonPressed(sender: UIButton) {
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.6
        }
        else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    func parsePokemonCSV() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                pokemonArray.append(Pokemon(name: name, pokedexId: pokeId))
            }
            print(pokemonArray)
            collectionView?.reloadData()
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
    }

    // UICollectionView delegates & datasource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? Cell {
            
            cell.configureCell(pokemonData: pokemonArray[indexPath.row])
            
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
        return pokemonArray.count
    }
}
