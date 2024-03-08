//
//  ViewController.swift
//  TableView
//
//  Created by 이가을 on 3/5/24.
//

import UIKit

// tableView를 사용할 땐 UITableViewDataSource 프로토콜을 채택해줘야 함
class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movieDataManager = DataManager() // mvc패턴을 위한 데이터 매니저(배열 관리 - 데이터)
    var moviesArray: [Movie] = [] // 테이블뷰의 데이터를 표시하기 위한 배열
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        setUpData()
    }
    
    func setUpTableView() {
        // 델리게이트 패턴의 대리자 설정
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 120
        title = "영화목록"
    }
    
    func setUpData() {
        movieDataManager.makeMovieData()
        moviesArray = movieDataManager.getMovieData()
    }
    
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        movieDataManager.updateMovieData()
        moviesArray = movieDataManager.getMovieData()
        tableView.reloadData() // 데이터 다시 불러오기
    }
    
    
}

extension ViewController: UITableViewDataSource {
    // UITableViewDataSource 프로토콜을 채택하면 아래의 두 메서드는 필수적으로 구현해주어야 함
    
    // 1) 테이블뷰에게 몇개의 데이터를 표시할 것인지(셀이 몇개인지)를 뷰컨에게 물어봄
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(#function)
        
        return moviesArray.count
    }
    
    // 2) 셀의 구성(셀에 표시하고자 하는 데이터 표시)을 뷰컨에게 물어봄
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print(#function)
        
        // (힙에 올라간)재사용 가능한 셀을 꺼내서 사용하는 메서드
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell // 타입캐스팅 해줘야 함
        
        let movie = moviesArray[indexPath.row]
        
        cell.mainImageView.image = movie.movieImage
        cell.movieTitleLabel.text = movie.movieName
        cell.descriptionLabel.text = movie.movieDescription
        
        cell.selectionStyle = .none
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    // 셀이 선택 되었을 때 어떤 동작을 할 것인지 뷰컨에게 물어봄
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toDetail", sender: indexPath)
    }
    
    // 세그웨이 실행 전 데이터 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetail" {
            let detailVC = segue.destination as! DetailViewController
            
            let indexPath = sender as! IndexPath
            detailVC.movieData = moviesArray[indexPath.row]
        }
        
    }
}
