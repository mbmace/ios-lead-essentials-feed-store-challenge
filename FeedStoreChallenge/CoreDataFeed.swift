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
}
