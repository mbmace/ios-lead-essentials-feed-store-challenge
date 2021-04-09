//
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import CoreData

public final class CoreDataFeedStore: FeedStore {
	private static let modelName = "FeedStore"
	private static let model = NSManagedObjectModel(name: modelName, in: Bundle(for: CoreDataFeedStore.self))
	
	private let container: NSPersistentContainer
	private let context: NSManagedObjectContext
	
	struct ModelNotFound: Error {
		let modelName: String
	}
	
	public init(storeURL: URL) throws {
		guard let model = CoreDataFeedStore.model else {
			throw ModelNotFound(modelName: CoreDataFeedStore.modelName)
		}
		
		container = try NSPersistentContainer.load(
			name: CoreDataFeedStore.modelName,
			model: model,
			url: storeURL
		)
		context = container.newBackgroundContext()
	}
	
	public func retrieve(completion: @escaping RetrievalCompletion) {
		let context = self.context
		context.perform {
			do {
				let request = NSFetchRequest<CoreDataFeed>(entityName: CoreDataFeed.entity().name!)
				request.returnsObjectsAsFaults = false
				if let cache = try context.fetch(request).first {
					completion(.found(
						feed: cache.items
							.compactMap { ($0 as? CoreDataFeedImage) }
							.map {
								LocalFeedImage(id: $0.id, description: $0.descriptionText, location: $0.location, url: $0.url)
							},
						timestamp: cache.timestamp))
				} else {
					completion(.empty)
				}
			} catch {
				completion(.failure(error))
			}
		}
	}
	
	public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
		let context = self.context
		context.perform {
			do {
				let managedCache = CoreDataFeed(context: context)
				managedCache.timestamp = timestamp
				managedCache.items = NSOrderedSet(array: feed.map { local in
					let managed = CoreDataFeedImage(context: context)
					managed.id = local.id
					managed.descriptionText = local.description
					managed.location = local.location
					managed.url = local.url
					return managed
				})

				try context.save()
				completion(nil)
			} catch {
				completion(error)
			}
		}
	}
	
	public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
		fatalError("Must be implemented")
	}
}
