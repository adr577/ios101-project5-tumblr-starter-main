//
//  ViewController.swift
//  ios101-project5-tumbler
//

import UIKit
import Nuke



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
     var posts: [Post] = []
    var refreshControl = UIRefreshControl()

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("🍏 numberOfRowsInSection called with movies count: \(posts.count)")
        return posts.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("🍏 cellForRowAt called for row: \(indexPath.row)")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell

        
        let post = posts[indexPath.row]
        
        cell.overviewLabel.text = post.summary
        
        if let photo = post.photos.first {
            let url = photo.originalSize.url
            
            
            Nuke.loadImage(with: url, into: cell.posterImageLabel)
        }
        
        
        
        return cell
    }
    



    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl

        print("Refresh control added:", tableView.refreshControl != nil)

        fetchPosts()
    }
    
    
    @objc func refreshData(_ sender: Any){
        print("Refreshing data...")

        fetchPosts()
    }
    
    

    
    

    func fetchPosts() {
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork/posts/photo?api_key=1zT8CiXGXFcQDyMFG7RtcfGLwTdDjFUJnZzKJaWTmgyK4lKGYk")!
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                return
            }

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
                print("❌ Response error: \(String(describing: response))")
                return
            }

            guard let data = data else {
                print("❌ Data is NIL")
                return
            }

            do {
                let blog = try JSONDecoder().decode(Blog.self, from: data)

                DispatchQueue.main.async {


                    self.posts = blog.response.posts
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()



                    print("✅ We got \(self.posts.count) posts!")
                    for post in self.posts {
                        print("🍏 Summary: \(post.summary)")
                    }
                }

            } catch {
                print("❌ Error decoding JSON: \(error.localizedDescription)")
            }
        }
        session.resume()
    }
}
