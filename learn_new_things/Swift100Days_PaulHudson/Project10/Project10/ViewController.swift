//
//  ViewController.swift
//  Project10
//
//  Created by Joe Pham on 2021-02-03.
//

import UIKit

class ViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: Temp use of 10 items, to switch to using an array soon
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            // Failed to get a PersonCell
            fatalError("Unable to dequeue PersonCell.")
        }
        
        // Otherwise if got a PersonCell, return it
        return cell
    }

}

