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
	@NSManaged public var id: UUID
	@NSManaged public var descriptionText: String?
	@NSManaged public var location: String?
	@NSManaged public var url: URL
}
