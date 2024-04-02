
import Foundation

enum PersistenceActionType {
	case add, remove
}

enum PersistenceManager {
	static private let defaults = UserDefaults.standard
	
	//key 값을 enum으로 관리
	enum Keys {
		static let favorites = "favorites"
	}
	
	//action타입을 enum으로 관리해서 코드 재사용성을 올려줌
	static func update(favorite: Follower, actionType: PersistenceActionType, completed: @escaping (GFError?) -> Void) {
		retrieveFavorites { result in
			switch result {
			case .success(let favorites):
				var retrievedFavorites = favorites
				
				switch actionType {
				case .add:
					guard !retrievedFavorites.contains(favorite) else {
						completed(.alreadyInFavorites)
						return
					}
					
					retrievedFavorites.append(favorite)
					
				case .remove:
					///조건이 되었을 떄 지움
					retrievedFavorites.removeAll { $0.login == favorite.login }
				}
				
				completed(save(favorites: retrievedFavorites))
				
			case .failure(let error):
				completed(error)
			}
		}
	}
	
	static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>)-> Void) {
		guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
			completed(.success([]))
			return
		}
		
		do {
			let decoder = JSONDecoder()
			let favorites = try decoder.decode([Follower].self, from: favoritesData)
			completed(.success(favorites))
		} catch {
			completed(.failure(.unableToFavorite))
		}
	}
	
	static func save(favorites: [Follower]) -> GFError? {
		do {
			let encoder = JSONEncoder()
			let encodedFavorites = try encoder.encode(favorites)
			defaults.setValue(encodedFavorites, forKey: Keys.favorites)
			return nil
		} catch {
			return .unableToFavorite
		}
	}
}
