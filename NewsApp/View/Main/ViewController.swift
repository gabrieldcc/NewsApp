//
//  ViewController.swift
//  NewsApp
//
//  Created by Gabriel de Castro Chaves on 04/08/22.
//

import UIKit

final class ViewController: UIViewController {
    
    //MARK: - Vars
    private let service = Service()
    private var selectedItem: Item?
    var newsData: News?
    
    
    
    //MARK: - IBOutlets
    @IBOutlet weak private var tableView: UITableView!
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        apiRequest()
    }
    
    //MARK: - Funcs
    private func apiRequest() {
        service.makeRequest { [weak self] data in
            if let self = self {
                self.newsData = data
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let webViewController = segue.destination as? WebViewController else {
            return
        }
        webViewController.stringURL = self.selectedItem?.link
    }
    
}

//MARK: - Tableview
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = newsData?.rss.channel.item.count ?? 0
        
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as? NewsTableViewCell else {
            fatalError("error to create cell")
        }
        
        let item = self.newsData?.rss.channel.item[indexPath.row]
        let newsTitle = item?.title ?? String()
        let newsImage = item?.mediaContent?.empty.url ?? String()
        let newsDescription = item?.itemDescription.stripOutHtml() ?? String()
        let newsDate = item?.pubDate ?? String()
        guard let endOfSentence = newsDate.firstIndex(of: "-") else { return UITableViewCell() }
        let newsDateFomatted = String(newsDate[...endOfSentence])
        
        cell.setupCell(image: newsImage, title: newsTitle, description: newsDescription, pubDate: newsDateFomatted)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = newsData?.rss.channel.item[indexPath.row]
        performSegue(withIdentifier: "showWebView", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        430
    }

}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = Bundle.main.loadNibNamed("HomeHeader", owner: self, options: nil)?.first as? HomeHeader
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }

}


