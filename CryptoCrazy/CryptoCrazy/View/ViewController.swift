//
//  ViewController.swift
//  CryptoCrazy
//
//  Created by Şevval Mertoğlu on 29.05.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    private var cryptoListViewModel : CryptoListViewModel!
    
    var colorArray = [UIColor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        self.colorArray = [
            UIColor(red: 20/255, green: 57/255, blue: 200/255, alpha: 1.0),
            UIColor(red: 55/255, green: 59/255, blue: 100/255, alpha: 1.0),
            UIColor(red: 100/255, green: 207/255, blue: 20/255, alpha: 1.0),
            UIColor(red: 100/255, green: 100/255, blue: 250/255, alpha: 1.0),
            UIColor(red: 75/255, green: 16/255, blue: 250/255, alpha: 1.0),
            UIColor(red: 207/255, green: 10/255, blue: 35/255, alpha: 1.0),
        ]
        
      getData()
    }

    func getData() {
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        
        Webservice().downloadCurrencies(url: url) { (cryptos) in
            if let cryptos = cryptos {
                
                self.cryptoListViewModel = CryptoListViewModel(cryptoCurrencyList: cryptos)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cryptoListViewModel == nil ? 0 : self.cryptoListViewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell", for: indexPath) as! CryptoTableViewCell
        
        let cryptoViewModel = self.cryptoListViewModel.cryptoAtIndex(indexPath.row)
        
        cell.priceText.text = cryptoViewModel.price
        cell.currencyText.text = cryptoViewModel.name
        cell.backgroundColor = self.colorArray[indexPath.row % 6]
        
        return cell
    }
    
}

