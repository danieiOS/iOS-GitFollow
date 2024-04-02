
import UIKit

class NetworkManager {
	static let shared = NetworkManager() // singleton
	private let baseURL = "https://api.github.com/users/"
	//image 캐쉬를 하기 위한 NSString과 UIImage타입을 받는 NSCache 인스턴스 생성
	let cache = NSCache<NSString, UIImage>()
	
	private init() { }
	
	// custom completed handler
	func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
		let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
		
		guard let url = URL(string: endpoint) else {
			completed(.failure(.InvalidUsername))
			return
		}
		
		/// 데이터를 불러오는 일을 처리하기 위한 task
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			if let _ = error {
				//enum으로 error를 관리
				completed(.failure(.unableToComplete))
			}
			
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				completed(.failure(.invalidResponse))
				return
			}
			
			guard let data = data else {
				completed(.failure(.invalidData))
				return
			}
			
			// Codable - decoding
			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				let followers = try decoder.decode([Follower].self, from: data)
				completed(.success(followers))
			} catch {
				completed(.failure(.invalidData))
			}
		}
		
		task.resume()
	}
	
	// custom completed handler 를 이용해서 userInfo 가져오기
	func getUserInfo(for username: String, completed: @escaping (Result<User, GFError>) -> Void) {
		let endpoint = baseURL + "\(username)"
		
		guard let url = URL(string: endpoint) else {
			completed(.failure(.InvalidUsername))
			return
		}
		
		/// 데이터를 불러오는 일을 처리하기 위한 task
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			if let _ = error {
				//enum으로 error를 관리
				completed(.failure(.unableToComplete))
			}
			
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				completed(.failure(.invalidResponse))
				return
			}
			
			guard let data = data else {
				completed(.failure(.invalidData))
				return
			}
			
			// Codable - decoding
			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				/// string타입인 날짜값을 Date 타입으로 변경시켜 디코딩해줌
				decoder.dateDecodingStrategy = .iso8601
				let user = try decoder.decode(User.self, from: data)
				completed(.success(user))
			} catch {
				completed(.failure(.invalidData))
			}
		}
		
		task.resume()
	}
	
	//NSCache를 이용한 이미지 캐싱 구현
	func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
		let cacheKey = NSString(string: urlString)
		
		if let image = cache.object(forKey: cacheKey) {
			completed(image)
			return
		}
		
		guard let url = URL(string: urlString) else {
			completed(nil)
			return
		}
		
		let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
			guard let self = self,
						error == nil,
						let response = response as? HTTPURLResponse, response.statusCode == 200,
						let data = data,
						let image = UIImage(data: data) else {
				completed(nil)
				return
			}
			
			self.cache.setObject(image, forKey: cacheKey)
			
			// main thread 를 우선적 점유
			completed(image)
		}
		
		task.resume()
	}
}
