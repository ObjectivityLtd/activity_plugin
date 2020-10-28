// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

import HealthKit
import Foundation

typealias HKSampleQueryResultHandler = (HKSampleQuery, [HKSample]?, Error?) -> Void

extension HKSampleQuery {

    convenience init(arguments: ReadDataArguments, resultsHandler: @escaping HKSampleQueryResultHandler) {
        let sampleQuerySampleType = arguments.type.toPlatform()!
        let sampleQueryPredicate = HKQuery.predicateForSamples(
            withStart: arguments.startDate(),
            end: arguments.endDate(),
            options: [
                .strictStartDate,
                .strictEndDate])

        let sampleQueryLimit = HKObjectQueryNoLimit
        let sampleQuerySortDescriptor = NSSortDescriptor(
            key: HKSampleSortIdentifierEndDate,
            ascending: true)

        self.init(
            sampleType: sampleQuerySampleType,
            predicate: sampleQueryPredicate,
            limit: sampleQueryLimit,
            sortDescriptors: [sampleQuerySortDescriptor],
            resultsHandler: resultsHandler)
    }

}
