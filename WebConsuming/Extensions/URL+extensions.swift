//
//  URL+extensions.swift
//  WebConsuming
//
//  Created by Rodrigo Yukio Okido on 11/05/22.
//
import Foundation

protocol URLService {
    func request(with urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
    func request(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)

}

extension URLService {
    func request(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.request(with: URLRequest(url: url), completionHandler: completionHandler)
    }
}

extension URLSession: URLService {
    func request(with urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        dataTask(with: urlRequest, completionHandler: completionHandler).resume()
    }
}
