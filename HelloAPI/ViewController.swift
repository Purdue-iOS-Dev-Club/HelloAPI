//
//  ViewController.swift
//  HelloAPI
//
//  Created by Siraj Zaneer on 9/9/17.
//  Copyright © 2017 Siraj Zaneer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var spriteView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var spAttack: UILabel!
    @IBOutlet weak var spDefense: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    let baseURL = "https://pokeapi.co"
    var currId = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        previousButton.layer.cornerRadius = 5
        nextButton.layer.cornerRadius = 5
        
        loadFromAPI(id: currId)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadFromAPI(id: Int) {
        
        guard let url = URL(string: "http://127.0.0.1:5000/pokemon?id=\(id)") else {
            return
        }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                let JSON = try! JSONSerialization.jsonObject(with: data!, options: [])
                let pokeInfo = JSON as! Dictionary<String, Any>
                
                DispatchQueue.main.async {
                    self.nameLabel.text = pokeInfo["name"] as? String
                    
                    self.descriptionLabel.text = pokeInfo["description"] as? String
                    self.descriptionLabel.sizeToFit()
                    self.idLabel.text = "\(pokeInfo["id"]!)"
                    self.defenseLabel.text = "\(pokeInfo["defense"]!)"
                    self.attackLabel.text = "\(pokeInfo["attack"]!)"
                    self.spAttack.text = "\(pokeInfo["sp_attack"]!)"
                    self.spDefense.text = "\(pokeInfo["sp_defense"]!)"
                    
                    self.heightLabel.text = pokeInfo["height"] as? String
                    self.weightLabel.text = pokeInfo["weight"] as? String
                    
                    self.typeLabel.text = (pokeInfo["types"] as! NSArray)[0] as! String as String
                }
                
                let spriteURL = URL(string: pokeInfo["sprite"] as! String)!
                
                self.loadImage(url: spriteURL)
            }
        }.resume()
    }
    
    func loadImage(url: URL) {
        DispatchQueue.global().async {
            let spriteData = try! NSData(contentsOf: url, options: [])
            let spriteImage = UIImage(data: spriteData as Data)
            DispatchQueue.main.async {
                self.spriteView.image = spriteImage
            }
        }
        
        
        
    }
    
    @IBAction func onPrevious(_ sender: Any) {
        currId -= 1
        if currId < 1 {
            currId = 718
        }
        loadFromAPI(id: currId)
    }
    
    @IBAction func onNext(_ sender: Any) {
        currId += 1
        if currId > 718 {
            currId = 1
        }
        loadFromAPI(id: currId)
    }
}

