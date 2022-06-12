//
//  ViewController.swift
//  News
//
//  Created by Леонид Исраелян on 12.06.2022.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var NewsTableView: UITableView!
    
    var news: [Articles] = []
    
    let apiToken = "56be38a24cae4ae795d93ee0f68d1225"
    
    let placeholderURL = "https://www.industry.gov.au/sites/default/files/August%202018/image/news-placeholder-738.png"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NewsTableView.delegate = self
        NewsTableView.dataSource = self
        
        getNews()
        
    }
    
    func getNews() {
        
        let stringURL = "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiToken)"
        guard let url = URL(string: stringURL) else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { [weak self]
            data, responce, error in
            guard let this = self else { return }
            
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let keys = try JSONDecoder().decode(Model.self, from: data)
                print(keys)
                
                this.news = keys.articles
            }
            
            catch {
                print(error)
            }
            
            DispatchQueue.main.async {
                
            }
        }
        .resume()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? TableViewCell {
            let item = news[indexPath.row]
            
            let imageURL = URL(string: item.urlToImage ?? placeholderURL)
            
            cell.author.text = item.author
            cell.mainDescription.text = item.description
            cell.mainImage.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "Placeholder"), completed: nil)

            
            
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    
    
}

