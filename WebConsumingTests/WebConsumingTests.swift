//
//  WebConsumingTests.swift
//  WebConsumingTests
//
//  Created by Rodrigo Yukio Okido on 11/05/22.
//

import XCTest
@testable import WebConsuming

enum Type_test {
    case POP_MOVIE_DATA, NOW_MOVIE_DATA, GENRE_DATA
}

class MockURLService: URLService {
    
    var type_test: Type_test
    
    init (type: Type_test) {
        type_test = type
    }
    
    func request(with urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
//        print(urlRequest.url)
        let mockData: URL
        
        switch type_test {
        case .NOW_MOVIE_DATA:
            mockData = Bundle(for: Self.self).url(forResource: "mock_nowPlaying", withExtension: "json")!
        case .POP_MOVIE_DATA:
            mockData = Bundle(for: Self.self).url(forResource: "mock_popular", withExtension: "json")!
        case .GENRE_DATA:
             mockData = Bundle(for: Self.self).url(forResource: "mock_genres", withExtension: "json")!
        }
        
        let data = try! Data(contentsOf: mockData)
        completionHandler(data, HTTPURLResponse(url: urlRequest.url!, statusCode: 200, httpVersion: "1.1", headerFields: nil), nil)
    }
}

class WebConsumingTests: XCTestCase {

    var sut_nowPlay: RequestMoviesAPI_TMDB!
    var sut_popMovies: RequestMoviesAPI_TMDB!
    var sut_genres: GenresTMDB!
    
    
    override func setUpWithError() throws {
        sut_nowPlay = RequestMoviesAPI_TMDB(urlService: MockURLService(type: .NOW_MOVIE_DATA), request_name: .NOW_PLAYING)
        sut_popMovies = RequestMoviesAPI_TMDB(urlService: MockURLService(type: .POP_MOVIE_DATA), request_name: .POPULAR_MOVIES)
        sut_genres = GenresTMDB(urlService: MockURLService(type: .GENRE_DATA))
        
    }

    override func tearDownWithError() throws {
        sut_nowPlay = nil
        sut_popMovies = nil
        sut_genres = nil

    }

    func testLoadNowPlaying() throws {
        var now_playing: [Movie] = []

        sut_nowPlay.request_movies { movieList in
            
            now_playing = movieList
        }
        
        XCTAssertNotNil(now_playing, "List must be not nil")
    }
    
    func testLoadPopularMovies() throws {
        var popular_movies: [Movie] = []
        let popMoviesExpectation = expectation(description: "Load popular movies")
        
        sut_popMovies.request_movies { movieList in
            popular_movies = movieList
            popMoviesExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 2)
        XCTAssertNotNil(popular_movies, "List must be not nil")
    }
    
    func testGenres() throws {
        var movie_genres: [Genre] = []

        sut_genres.request_allGenres(completionHandler: { genres in
            movie_genres = genres
        })
        
        XCTAssertNotNil(movie_genres, "List must be not nil")
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
