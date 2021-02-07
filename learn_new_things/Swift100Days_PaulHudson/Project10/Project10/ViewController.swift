//
//  ViewController.swift
//  Project10
//
//  Created by Joe Pham on 2021-02-03.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var people = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
    }
    
    // Method to add new image
    @objc func addNewPerson() {
        let picker = UIImagePickerController()
        picker.delegate = self
        UIImagePickerController.availableMediaTypes(for: .camera)
        UIImagePickerController.isSourceTypeAvailable(.camera)
        picker.sourceType = .camera // Allow using the camera
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Get the edited copy of the picked immage
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath) // write copy of image to disk
        }
        
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        collectionView.reloadData()
        
        dismiss(animated: true)
    }
    
    // Custom method to get the Documents directory assigned to the app
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            // Failed to get a PersonCell
            fatalError("Unable to dequeue PersonCell.")
        }
        
        // Otherwise if got a PersonCell, define and return it
        let person = people[indexPath.item] // a specific Person object in the people array
        cell.name.text = person.name
        
        let path = getDocumentsDirectory().appendingPathComponent(person.image) // path of the image
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Allow changing a person's name, or delete, upon tapping a specific collection view item
        let person = people[indexPath.item]
        
        let acMain = UIAlertController(title: "Options", message: "Choose to ename or delete the person", preferredStyle: .actionSheet)
        
        // First define the reusable Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // Define the Rename alert
        let renameAction = UIAlertAction(title: "Rename", style: .default) { [weak self] (action) in
            let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
            ac.addTextField()

            ac.addAction(cancelAction)
            ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
                guard let newName = ac?.textFields?[0].text else { return }
                person.name = newName

                self?.collectionView.reloadData()
            })
            
            self?.present(ac, animated: true)
        }
        
        // Define the Delete alert
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] (action) in
            let ac = UIAlertController(title: "Confirm delete", message: "Are you sure you would like to delete?", preferredStyle: .alert)
            
            ac.addAction(cancelAction)
            ac.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: nil)) // temp nil for now, will learn later in future projects
            self?.present(ac, animated: true)
        }
        
        
        // Add all the actions to acMain
        acMain.addAction(renameAction)
        acMain.addAction(deleteAction)
        acMain.addAction(cancelAction)
        present(acMain, animated: true)
    }
}

