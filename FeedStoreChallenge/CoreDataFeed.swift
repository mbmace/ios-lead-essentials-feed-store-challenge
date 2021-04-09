//
//  CoreDataFeed.swift
//  FeedStoreChallenge
//
//  Created by Matthias Sehrbrock on 09.04.21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation
import CoreData

@objc(CoreDataFeed)
class CoreDataFeed: NSManagedObject {
	@NSManaged public var timestamp: Date
	@NSManaged public var items: NSOrderedSet

	static func find(in context: NSManagedObjectContext) throws -> CoreDataFeed? {
		let request = NSFetchRequest<CoreDataFeed>(entityName: entity().name!)
		request.returnsObjectsAsFaults = false
		return try context.fetch(request).first
	}

	static func newInstance(in context: NSManagedObjectContext) throws -> CoreDataFeed {
		try find(in: context).map(context.delete)
		return CoreDataFeed(context: context)
	}
}
