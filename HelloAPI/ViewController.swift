//
//  ViewController.swift
//  HelloAPI
//
//  Created by Siraj Zaneer on 9/9/17.
//  Copyright © 2017 Siraj Zaneer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let baseURL = "https://pokeapi.co"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadFromAPI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadFromAPI() {
       
        guard let url = URL(string: "http://sirajzaneer.com/HelloAPI.json") else {
            return
        }
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                
            }
        }.resume()
    }


}

