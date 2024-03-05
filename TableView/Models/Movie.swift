//
//  Movie.swift
//  TableView
//
//  Created by 이가을 on 3/5/24.
//

import UIKit

struct Movie {
    var movieImage: UIImage? // 이미지가 없어도 에러가 안나게 옵셔널로 선언
    let movieName: String
    let movieDescription: String
}
