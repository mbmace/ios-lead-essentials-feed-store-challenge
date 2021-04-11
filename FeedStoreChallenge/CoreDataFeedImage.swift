//
//  CoreDataFeedImage.swift
//  FeedStoreChallenge
//
//  Created by Matthias Sehrbrock on 09.04.21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation
import CoreData

@objc(CoreDataFeedImage)
class CoreDataFeedImage: NSManagedObject {
	@NSManaged var id: UUID
	@NSManaged var descriptionText: String?
	@NSManaged var location: String?
	@NSManaged var url: URL
	@NSManaged var cache: CoreDataFeed

	func toLocal() -> LocalFeedImage {
		LocalFeedImage(id: id, description: descriptionText, location: location, url: url)
	}
}
