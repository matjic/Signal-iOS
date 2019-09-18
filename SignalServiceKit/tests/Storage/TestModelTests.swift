//
//  Copyright (c) 2019 Open Whisper Systems. All rights reserved.
//

import Foundation
import XCTest
@testable import SignalServiceKit

class TestModelTests: SSKBaseTestSwift {

    func testTestModel() {

        let writeModel = TestModel()

        self.write { transaction in
            writeModel.anyInsert(transaction: transaction)

            let readModel = TestModel.anyFetch(uniqueId: writeModel.uniqueId, transaction: transaction)!
            XCTAssertFalse(writeModel === readModel)
            XCTAssertEqual(0, readModel.doubleValue)
            XCTAssertEqual(0, readModel.floatValue)
            XCTAssertEqual(0, readModel.uint64Value)
            XCTAssertEqual(0, readModel.int64Value)
            XCTAssertEqual(0, readModel.nsuIntegerValue)
            XCTAssertEqual(0, readModel.nsIntegerValue)
            XCTAssertNil(readModel.nsNumberValueUsingInt64)
            XCTAssertNil(readModel.nsNumberValueUsingUInt64)
            XCTAssertNil(readModel.dateValue)
        }

        // MARK: - Happy path

        self.write { transaction in

            let now = Date(timeIntervalSince1970: 123456)
            let nsNumberUsingInt64: Int64 = -1
            let nsNumberUsingUInt64: UInt64 = 1

            writeModel.anyUpdate(transaction: transaction) { model in
                model.doubleValue = 1
                model.floatValue = 1
                model.uint64Value = 1
                model.int64Value = 1
                model.nsuIntegerValue = 1
                model.nsIntegerValue = 1
                model.nsNumberValueUsingInt64 = NSNumber(value: nsNumberUsingInt64)
                model.nsNumberValueUsingUInt64 = NSNumber(value: nsNumberUsingUInt64)
                model.dateValue = now
            }

            let readModel = TestModel.anyFetch(uniqueId: writeModel.uniqueId, transaction: transaction)!
            XCTAssertFalse(writeModel === readModel)
            XCTAssertEqual(1, readModel.doubleValue)
            XCTAssertEqual(1, readModel.floatValue)
            XCTAssertEqual(1, readModel.uint64Value)
            XCTAssertEqual(1, readModel.int64Value)
            XCTAssertEqual(1, readModel.nsuIntegerValue)
            XCTAssertEqual(1, readModel.nsIntegerValue)
            XCTAssertEqual(NSNumber(value: nsNumberUsingInt64), readModel.nsNumberValueUsingInt64)
            XCTAssertEqual(NSNumber(value: nsNumberUsingUInt64), readModel.nsNumberValueUsingUInt64)
            XCTAssertEqual(now, readModel.dateValue)
        }

        // MARK: - Max values

        self.write { transaction in

            // SQLite doesn't support numeric values larger than Int64.max;
            // UInt64.max for example is not valid.
            let uint64Max: UInt64 = UInt64(Int64.max)
            let int64Max: Int64 = Int64.max
            let nsUintMax: UInt = NSUIntegerMaxValue() < Int64.max ? NSUIntegerMaxValue() : UInt(Int64.max)
            let nsIntMax: Int = NSIntegerMax
            let nsNumberUsingInt64 = int64Max
            let nsNumberUsingUInt64 = uint64Max

            writeModel.anyUpdate(transaction: transaction) { model in
                model.doubleValue = Double.greatestFiniteMagnitude
                model.floatValue = Float.greatestFiniteMagnitude
                model.uint64Value = uint64Max
                model.int64Value = int64Max
                model.nsuIntegerValue = nsUintMax
                model.nsIntegerValue = nsIntMax
                model.nsNumberValueUsingInt64 = NSNumber(value: nsNumberUsingInt64)
                model.nsNumberValueUsingUInt64 = NSNumber(value: nsNumberUsingUInt64)
            }

            let readModel = TestModel.anyFetch(uniqueId: writeModel.uniqueId, transaction: transaction)!
            XCTAssertFalse(writeModel === readModel)
            XCTAssertEqual(Double.greatestFiniteMagnitude, readModel.doubleValue)
            XCTAssertEqual(Float.greatestFiniteMagnitude, readModel.floatValue)
            XCTAssertEqual(uint64Max, readModel.uint64Value)
            XCTAssertEqual(int64Max, readModel.int64Value)
            XCTAssertEqual(nsUintMax, readModel.nsuIntegerValue)
            XCTAssertEqual(nsIntMax, readModel.nsIntegerValue)
            XCTAssertEqual(NSNumber(value: nsNumberUsingInt64), readModel.nsNumberValueUsingInt64)
            XCTAssertEqual(NSNumber(value: nsNumberUsingUInt64), readModel.nsNumberValueUsingUInt64)
        }

        // MARK: - Min values

        self.write { transaction in

            writeModel.anyUpdate(transaction: transaction) { model in
                model.doubleValue = Double.leastNormalMagnitude
                model.floatValue = Float.leastNormalMagnitude
                model.uint64Value = UInt64.min
                model.int64Value = Int64.min
                model.nsuIntegerValue = UInt.min
                model.nsIntegerValue = Int.min
            }

            let readModel = TestModel.anyFetch(uniqueId: writeModel.uniqueId, transaction: transaction)!
            XCTAssertFalse(writeModel === readModel)
            XCTAssertEqual(Double.leastNormalMagnitude, readModel.doubleValue)
            XCTAssertEqual(Float.leastNormalMagnitude, readModel.floatValue)
            XCTAssertEqual(UInt64.min, readModel.uint64Value)
            XCTAssertEqual(Int64.min, readModel.int64Value)
            XCTAssertEqual(UInt.min, readModel.nsuIntegerValue)
            XCTAssertEqual(Int.min, readModel.nsIntegerValue)
        }

        // MARK: - Date rounding/precision

        self.write { transaction in

            let now = Date(timeIntervalSince1970: 123456.123456)

            writeModel.anyUpdate(transaction: transaction) { model in
                model.dateValue = now
            }

            let readModel = TestModel.anyFetch(uniqueId: writeModel.uniqueId, transaction: transaction)!
            XCTAssertFalse(writeModel === readModel)
            // This date value will be truncated during the roundtrip.
            // NSDate is backed by NSTimeInterval (seconds as double) but we
            // persist using ms as UInt64.
            XCTAssertNotEqual(now, readModel.dateValue)
        }
    }
}
