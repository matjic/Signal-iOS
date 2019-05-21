//
//  Copyright (c) 2019 Open Whisper Systems. All rights reserved.
//

import Foundation
import GRDBCipher
import SignalCoreKit

// NOTE: This file is generated by /Scripts/sds_codegen/sds_generate.py.
// Do not manually edit it, instead run `sds_codegen.sh`.

// MARK: - Record

public struct AttachmentRecord: Codable, FetchableRecord, PersistableRecord, TableRecord {
    public static let databaseTableName: String = TSAttachmentSerializer.table.tableName

    public let id: UInt64

    // This defines all of the columns used in the table
    // where this model (and any subclasses) are persisted.
    public let recordType: SDSRecordType
    public let uniqueId: String

    // Base class properties
    public let albumMessageId: String?
    public let attachmentSchemaVersion: UInt
    public let attachmentType: TSAttachmentType
    public let byteCount: UInt32
    public let caption: String?
    public let contentType: String
    public let encryptionKey: Data?
    public let isDownloaded: Bool
    public let serverId: UInt64
    public let sourceFilename: String?

    // Subclass properties
    public let cachedAudioDurationSeconds: Double?
    public let cachedImageHeight: Double?
    public let cachedImageWidth: Double?
    public let creationTimestamp: Date?
    public let digest: Data?
    public let isUploaded: Bool?
    public let isValidImageCached: Bool?
    public let isValidVideoCached: Bool?
    public let lazyRestoreFragmentId: String?
    public let localRelativeFilePath: String?
    public let mediaSize: CGSize?
    public let mostRecentFailureLocalizedText: String?
    public let pointerType: TSAttachmentPointerType?
    public let shouldAlwaysPad: Bool?
    public let state: TSAttachmentPointerState?

    public enum CodingKeys: String, CodingKey, ColumnExpression, CaseIterable {
        case id
        case recordType
        case uniqueId
        case albumMessageId
        case attachmentSchemaVersion
        case attachmentType
        case byteCount
        case caption
        case contentType
        case encryptionKey
        case isDownloaded
        case serverId
        case sourceFilename
        case cachedAudioDurationSeconds
        case cachedImageHeight
        case cachedImageWidth
        case creationTimestamp
        case digest
        case isUploaded
        case isValidImageCached
        case isValidVideoCached
        case lazyRestoreFragmentId
        case localRelativeFilePath
        case mediaSize
        case mostRecentFailureLocalizedText
        case pointerType
        case shouldAlwaysPad
        case state
    }

    public static func columnName(_ column: AttachmentRecord.CodingKeys, fullyQualified: Bool = false) -> String {
        return fullyQualified ? "\(databaseTableName).\(column.rawValue)" : column.rawValue
    }

}

// MARK: - StringInterpolation

public extension String.StringInterpolation {
    mutating func appendInterpolation(attachmentColumn column: AttachmentRecord.CodingKeys) {
        appendLiteral(AttachmentRecord.columnName(column))
    }
    mutating func appendInterpolation(attachmentColumnFullyQualified column: AttachmentRecord.CodingKeys) {
        appendLiteral(AttachmentRecord.columnName(column, fullyQualified: true))
    }
}

// MARK: - Deserialization

// TODO: Rework metadata to not include, for example, columns, column indices.
extension TSAttachment {
    // This method defines how to deserialize a model, given a
    // database row.  The recordType column is used to determine
    // the corresponding model class.
    class func fromRecord(_ record: AttachmentRecord) throws -> TSAttachment {

        switch record.recordType {
        case .attachment:

            let uniqueId: String = record.uniqueId
            let albumMessageId: String? = record.albumMessageId
            let attachmentSchemaVersion: UInt = record.attachmentSchemaVersion
            let attachmentType: TSAttachmentType = record.attachmentType
            let byteCount: UInt32 = record.byteCount
            let caption: String? = record.caption
            let contentType: String = record.contentType
            let encryptionKey: Data? = SDSDeserialization.optionalData(record.encryptionKey, name: "encryptionKey")
            let isDownloaded: Bool = record.isDownloaded
            let serverId: UInt64 = record.serverId
            let sourceFilename: String? = record.sourceFilename

            return TSAttachment(uniqueId: uniqueId,
                                albumMessageId: albumMessageId,
                                attachmentSchemaVersion: attachmentSchemaVersion,
                                attachmentType: attachmentType,
                                byteCount: byteCount,
                                caption: caption,
                                contentType: contentType,
                                encryptionKey: encryptionKey,
                                isDownloaded: isDownloaded,
                                serverId: serverId,
                                sourceFilename: sourceFilename)

        case .attachmentPointer:

            let uniqueId: String = record.uniqueId
            let albumMessageId: String? = record.albumMessageId
            let attachmentSchemaVersion: UInt = record.attachmentSchemaVersion
            let attachmentType: TSAttachmentType = record.attachmentType
            let byteCount: UInt32 = record.byteCount
            let caption: String? = record.caption
            let contentType: String = record.contentType
            let encryptionKey: Data? = SDSDeserialization.optionalData(record.encryptionKey, name: "encryptionKey")
            let isDownloaded: Bool = record.isDownloaded
            let serverId: UInt64 = record.serverId
            let sourceFilename: String? = record.sourceFilename
            let digest: Data? = SDSDeserialization.optionalData(record.digest, name: "digest")
            let lazyRestoreFragmentId: String? = record.lazyRestoreFragmentId
            let mediaSize: CGSize = try SDSDeserialization.required(record.mediaSize, name: "mediaSize")
            let mostRecentFailureLocalizedText: String? = record.mostRecentFailureLocalizedText
            guard let pointerType: TSAttachmentPointerType = record.pointerType else {
               throw SDSError.missingRequiredField
            }
            guard let state: TSAttachmentPointerState = record.state else {
               throw SDSError.missingRequiredField
            }

            return TSAttachmentPointer(uniqueId: uniqueId,
                                       albumMessageId: albumMessageId,
                                       attachmentSchemaVersion: attachmentSchemaVersion,
                                       attachmentType: attachmentType,
                                       byteCount: byteCount,
                                       caption: caption,
                                       contentType: contentType,
                                       encryptionKey: encryptionKey,
                                       isDownloaded: isDownloaded,
                                       serverId: serverId,
                                       sourceFilename: sourceFilename,
                                       digest: digest,
                                       lazyRestoreFragmentId: lazyRestoreFragmentId,
                                       mediaSize: mediaSize,
                                       mostRecentFailureLocalizedText: mostRecentFailureLocalizedText,
                                       pointerType: pointerType,
                                       state: state)

        case .attachmentStream:

            let uniqueId: String = record.uniqueId
            let albumMessageId: String? = record.albumMessageId
            let attachmentSchemaVersion: UInt = record.attachmentSchemaVersion
            let attachmentType: TSAttachmentType = record.attachmentType
            let byteCount: UInt32 = record.byteCount
            let caption: String? = record.caption
            let contentType: String = record.contentType
            let encryptionKey: Data? = SDSDeserialization.optionalData(record.encryptionKey, name: "encryptionKey")
            let isDownloaded: Bool = record.isDownloaded
            let serverId: UInt64 = record.serverId
            let sourceFilename: String? = record.sourceFilename
            let cachedAudioDurationSeconds: NSNumber? = SDSDeserialization.optionalNumericAsNSNumber(record.cachedAudioDurationSeconds, name: "cachedAudioDurationSeconds", conversion: { NSNumber(value: $0) })
            let cachedImageHeight: NSNumber? = SDSDeserialization.optionalNumericAsNSNumber(record.cachedImageHeight, name: "cachedImageHeight", conversion: { NSNumber(value: $0) })
            let cachedImageWidth: NSNumber? = SDSDeserialization.optionalNumericAsNSNumber(record.cachedImageWidth, name: "cachedImageWidth", conversion: { NSNumber(value: $0) })
            let creationTimestamp: Date = try SDSDeserialization.required(record.creationTimestamp, name: "creationTimestamp")
            let digest: Data? = SDSDeserialization.optionalData(record.digest, name: "digest")
            let isUploaded: Bool = try SDSDeserialization.required(record.isUploaded, name: "isUploaded")
            let isValidImageCached: NSNumber? = SDSDeserialization.optionalNumericAsNSNumber(record.isValidImageCached, name: "isValidImageCached", conversion: { NSNumber(value: $0) })
            let isValidVideoCached: NSNumber? = SDSDeserialization.optionalNumericAsNSNumber(record.isValidVideoCached, name: "isValidVideoCached", conversion: { NSNumber(value: $0) })
            let localRelativeFilePath: String? = record.localRelativeFilePath
            let shouldAlwaysPad: Bool = try SDSDeserialization.required(record.shouldAlwaysPad, name: "shouldAlwaysPad")

            return TSAttachmentStream(uniqueId: uniqueId,
                                      albumMessageId: albumMessageId,
                                      attachmentSchemaVersion: attachmentSchemaVersion,
                                      attachmentType: attachmentType,
                                      byteCount: byteCount,
                                      caption: caption,
                                      contentType: contentType,
                                      encryptionKey: encryptionKey,
                                      isDownloaded: isDownloaded,
                                      serverId: serverId,
                                      sourceFilename: sourceFilename,
                                      cachedAudioDurationSeconds: cachedAudioDurationSeconds,
                                      cachedImageHeight: cachedImageHeight,
                                      cachedImageWidth: cachedImageWidth,
                                      creationTimestamp: creationTimestamp,
                                      digest: digest,
                                      isUploaded: isUploaded,
                                      isValidImageCached: isValidImageCached,
                                      isValidVideoCached: isValidVideoCached,
                                      localRelativeFilePath: localRelativeFilePath,
                                      shouldAlwaysPad: shouldAlwaysPad)

        default:
            owsFailDebug("Unexpected record type: \(record.recordType)")
            throw SDSError.invalidValue
        }
    }
}

// MARK: - SDSSerializable

extension TSAttachment: SDSSerializable {
    public var serializer: SDSSerializer {
        // Any subclass can be cast to it's superclass,
        // so the order of this switch statement matters.
        // We need to do a "depth first" search by type.
        switch self {
        case let model as TSAttachmentStream:
            assert(type(of: model) == TSAttachmentStream.self)
            return TSAttachmentStreamSerializer(model: model)
        case let model as TSAttachmentPointer:
            assert(type(of: model) == TSAttachmentPointer.self)
            return TSAttachmentPointerSerializer(model: model)
        default:
            return TSAttachmentSerializer(model: self)
        }
    }
}

// MARK: - Table Metadata

extension TSAttachmentSerializer {

    // This defines all of the columns used in the table
    // where this model (and any subclasses) are persisted.
    static let recordTypeColumn = SDSColumnMetadata(columnName: "recordType", columnType: .int, columnIndex: 0)
    static let idColumn = SDSColumnMetadata(columnName: "id", columnType: .primaryKey, columnIndex: 1)
    static let uniqueIdColumn = SDSColumnMetadata(columnName: "uniqueId", columnType: .unicodeString, columnIndex: 2)
    // Base class properties
    static let albumMessageIdColumn = SDSColumnMetadata(columnName: "albumMessageId", columnType: .unicodeString, isOptional: true, columnIndex: 3)
    static let attachmentSchemaVersionColumn = SDSColumnMetadata(columnName: "attachmentSchemaVersion", columnType: .int64, columnIndex: 4)
    static let attachmentTypeColumn = SDSColumnMetadata(columnName: "attachmentType", columnType: .int, columnIndex: 5)
    static let byteCountColumn = SDSColumnMetadata(columnName: "byteCount", columnType: .int64, columnIndex: 6)
    static let captionColumn = SDSColumnMetadata(columnName: "caption", columnType: .unicodeString, isOptional: true, columnIndex: 7)
    static let contentTypeColumn = SDSColumnMetadata(columnName: "contentType", columnType: .unicodeString, columnIndex: 8)
    static let encryptionKeyColumn = SDSColumnMetadata(columnName: "encryptionKey", columnType: .blob, isOptional: true, columnIndex: 9)
    static let isDownloadedColumn = SDSColumnMetadata(columnName: "isDownloaded", columnType: .int, columnIndex: 10)
    static let serverIdColumn = SDSColumnMetadata(columnName: "serverId", columnType: .int64, columnIndex: 11)
    static let sourceFilenameColumn = SDSColumnMetadata(columnName: "sourceFilename", columnType: .unicodeString, isOptional: true, columnIndex: 12)
    // Subclass properties
    static let cachedAudioDurationSecondsColumn = SDSColumnMetadata(columnName: "cachedAudioDurationSeconds", columnType: .double, isOptional: true, columnIndex: 13)
    static let cachedImageHeightColumn = SDSColumnMetadata(columnName: "cachedImageHeight", columnType: .double, isOptional: true, columnIndex: 14)
    static let cachedImageWidthColumn = SDSColumnMetadata(columnName: "cachedImageWidth", columnType: .double, isOptional: true, columnIndex: 15)
    static let creationTimestampColumn = SDSColumnMetadata(columnName: "creationTimestamp", columnType: .int64, isOptional: true, columnIndex: 16)
    static let digestColumn = SDSColumnMetadata(columnName: "digest", columnType: .blob, isOptional: true, columnIndex: 17)
    static let isUploadedColumn = SDSColumnMetadata(columnName: "isUploaded", columnType: .int, isOptional: true, columnIndex: 18)
    static let isValidImageCachedColumn = SDSColumnMetadata(columnName: "isValidImageCached", columnType: .int, isOptional: true, columnIndex: 19)
    static let isValidVideoCachedColumn = SDSColumnMetadata(columnName: "isValidVideoCached", columnType: .int, isOptional: true, columnIndex: 20)
    static let lazyRestoreFragmentIdColumn = SDSColumnMetadata(columnName: "lazyRestoreFragmentId", columnType: .unicodeString, isOptional: true, columnIndex: 21)
    static let localRelativeFilePathColumn = SDSColumnMetadata(columnName: "localRelativeFilePath", columnType: .unicodeString, isOptional: true, columnIndex: 22)
    static let mediaSizeColumn = SDSColumnMetadata(columnName: "mediaSize", columnType: .blob, isOptional: true, columnIndex: 23)
    static let mostRecentFailureLocalizedTextColumn = SDSColumnMetadata(columnName: "mostRecentFailureLocalizedText", columnType: .unicodeString, isOptional: true, columnIndex: 24)
    static let pointerTypeColumn = SDSColumnMetadata(columnName: "pointerType", columnType: .int, isOptional: true, columnIndex: 25)
    static let shouldAlwaysPadColumn = SDSColumnMetadata(columnName: "shouldAlwaysPad", columnType: .int, isOptional: true, columnIndex: 26)
    static let stateColumn = SDSColumnMetadata(columnName: "state", columnType: .int, isOptional: true, columnIndex: 27)

    // TODO: We should decide on a naming convention for
    //       tables that store models.
    public static let table = SDSTableMetadata(tableName: "model_TSAttachment", columns: [
        recordTypeColumn,
        idColumn,
        uniqueIdColumn,
        albumMessageIdColumn,
        attachmentSchemaVersionColumn,
        attachmentTypeColumn,
        byteCountColumn,
        captionColumn,
        contentTypeColumn,
        encryptionKeyColumn,
        isDownloadedColumn,
        serverIdColumn,
        sourceFilenameColumn,
        cachedAudioDurationSecondsColumn,
        cachedImageHeightColumn,
        cachedImageWidthColumn,
        creationTimestampColumn,
        digestColumn,
        isUploadedColumn,
        isValidImageCachedColumn,
        isValidVideoCachedColumn,
        lazyRestoreFragmentIdColumn,
        localRelativeFilePathColumn,
        mediaSizeColumn,
        mostRecentFailureLocalizedTextColumn,
        pointerTypeColumn,
        shouldAlwaysPadColumn,
        stateColumn
        ])
}

// MARK: - Save/Remove/Update

@objc
extension TSAttachment {
    public func anySave(transaction: SDSAnyWriteTransaction) {
        switch transaction.writeTransaction {
        case .yapWrite(let ydbTransaction):
            save(with: ydbTransaction)
        case .grdbWrite(let grdbTransaction):
            SDSSerialization.save(entity: self, transaction: grdbTransaction)
        }
    }

    // This method is used by "updateWith..." methods.
    //
    // This model may be updated from many threads. We don't want to save
    // our local copy (this instance) since it may be out of date.  We also
    // want to avoid re-saving a model that has been deleted.  Therefore, we
    // use "updateWith..." methods to:
    //
    // a) Update a property of this instance.
    // b) If a copy of this model exists in the database, load an up-to-date copy,
    //    and update and save that copy.
    // b) If a copy of this model _DOES NOT_ exist in the database, do _NOT_ save
    //    this local instance.
    //
    // After "updateWith...":
    //
    // a) Any copy of this model in the database will have been updated.
    // b) The local property on this instance will always have been updated.
    // c) Other properties on this instance may be out of date.
    //
    // All mutable properties of this class have been made read-only to
    // prevent accidentally modifying them directly.
    //
    // This isn't a perfect arrangement, but in practice this will prevent
    // data loss and will resolve all known issues.
    public func anyUpdateWith(transaction: SDSAnyWriteTransaction, block: (TSAttachment) -> Void) {
        guard let uniqueId = uniqueId else {
            owsFailDebug("Missing uniqueId.")
            return
        }

        guard let dbCopy = type(of: self).anyFetch(uniqueId: uniqueId,
                                                   transaction: transaction) else {
            return
        }

        block(self)
        block(dbCopy)

        dbCopy.anySave(transaction: transaction)
    }

    public func anyRemove(transaction: SDSAnyWriteTransaction) {
        switch transaction.writeTransaction {
        case .yapWrite(let ydbTransaction):
            remove(with: ydbTransaction)
        case .grdbWrite(let grdbTransaction):
            SDSSerialization.delete(entity: self, transaction: grdbTransaction)
        }
    }
}

// MARK: - TSAttachmentCursor

@objc
public class TSAttachmentCursor: NSObject {
    private let cursor: RecordCursor<AttachmentRecord>?

    init(cursor: RecordCursor<AttachmentRecord>?) {
        self.cursor = cursor
    }

    public func next() throws -> TSAttachment? {
        guard let cursor = cursor else {
            return nil
        }
        guard let record = try cursor.next() else {
            return nil
        }
        return try TSAttachment.fromRecord(record)
    }

    public func all() throws -> [TSAttachment] {
        var result = [TSAttachment]()
        while true {
            guard let model = try next() else {
                break
            }
            result.append(model)
        }
        return result
    }
}

// MARK: - Obj-C Fetch

// TODO: We may eventually want to define some combination of:
//
// * fetchCursor, fetchOne, fetchAll, etc. (ala GRDB)
// * Optional "where clause" parameters for filtering.
// * Async flavors with completions.
//
// TODO: I've defined flavors that take a read transaction.
//       Or we might take a "connection" if we end up having that class.
@objc
extension TSAttachment {
    public class func grdbFetchCursor(transaction: GRDBReadTransaction) -> TSAttachmentCursor {
        let database = transaction.database
        do {
            let cursor = try AttachmentRecord.fetchCursor(database)
            return TSAttachmentCursor(cursor: cursor)
        } catch {
            owsFailDebug("Read failed: \(error)")
            return TSAttachmentCursor(cursor: nil)
        }
    }

    // Fetches a single model by "unique id".
    public class func anyFetch(uniqueId: String,
                               transaction: SDSAnyReadTransaction) -> TSAttachment? {
        assert(uniqueId.count > 0)

        switch transaction.readTransaction {
        case .yapRead(let ydbTransaction):
            return TSAttachment.fetch(uniqueId: uniqueId, transaction: ydbTransaction)
        case .grdbRead(let grdbTransaction):
            let sql = "SELECT * FROM \(AttachmentRecord.databaseTableName) WHERE \(attachmentColumn: .uniqueId) = ?"
            return grdbFetchOne(sql: sql, arguments: [uniqueId], transaction: grdbTransaction)
        }
    }

    // Traverses all records.
    // Records are not visited in any particular order.
    // Traversal aborts if the visitor returns false.
    public class func anyVisitAll(transaction: SDSAnyReadTransaction, visitor: @escaping (TSAttachment) -> Bool) {
        switch transaction.readTransaction {
        case .yapRead(let ydbTransaction):
            TSAttachment.enumerateCollectionObjects(with: ydbTransaction) { (object, stop) in
                guard let value = object as? TSAttachment else {
                    owsFailDebug("unexpected object: \(type(of: object))")
                    return
                }
                guard visitor(value) else {
                    stop.pointee = true
                    return
                }
            }
        case .grdbRead(let grdbTransaction):
            do {
                let cursor = TSAttachment.grdbFetchCursor(transaction: grdbTransaction)
                while let value = try cursor.next() {
                    guard visitor(value) else {
                        return
                    }
                }
            } catch let error as NSError {
                owsFailDebug("Couldn't fetch models: \(error)")
            }
        }
    }

    // Does not order the results.
    public class func anyFetchAll(transaction: SDSAnyReadTransaction) -> [TSAttachment] {
        var result = [TSAttachment]()
        anyVisitAll(transaction: transaction) { (model) in
            result.append(model)
            return true
        }
        return result
    }
}

// MARK: - Swift Fetch

extension TSAttachment {
    public class func grdbFetchCursor(sql: String,
                                      arguments: [DatabaseValueConvertible]?,
                                      transaction: GRDBReadTransaction) -> TSAttachmentCursor {
        var statementArguments: StatementArguments?
        if let arguments = arguments {
            guard let statementArgs = StatementArguments(arguments) else {
                owsFailDebug("Could not convert arguments.")
                return TSAttachmentCursor(cursor: nil)
            }
            statementArguments = statementArgs
        }
        let database = transaction.database
        do {
            let statement: SelectStatement = try database.cachedSelectStatement(sql: sql)
            let cursor = try AttachmentRecord.fetchCursor(statement, arguments: statementArguments)
            return TSAttachmentCursor(cursor: cursor)
        } catch {
            Logger.error("sql: \(sql)")
            owsFailDebug("Read failed: \(error)")
            return TSAttachmentCursor(cursor: nil)
        }
    }

    public class func grdbFetchOne(sql: String,
                                   arguments: StatementArguments,
                                   transaction: GRDBReadTransaction) -> TSAttachment? {
        assert(sql.count > 0)

        do {
            guard let record = try AttachmentRecord.fetchOne(transaction.database, sql: sql, arguments: arguments) else {
                return nil
            }

            return try TSAttachment.fromRecord(record)
        } catch {
            owsFailDebug("error: \(error)")
            return nil
        }
    }
}

// MARK: - SDSSerializer

// The SDSSerializer protocol specifies how to insert and update the
// row that corresponds to this model.
class TSAttachmentSerializer: SDSSerializer {

    private let model: TSAttachment
    public required init(model: TSAttachment) {
        self.model = model
    }

    public func serializableColumnTableMetadata() -> SDSTableMetadata {
        return TSAttachmentSerializer.table
    }

    public func insertColumnNames() -> [String] {
        // When we insert a new row, we include the following columns:
        //
        // * "record type"
        // * "unique id"
        // * ...all columns that we set when updating.
        return [
            TSAttachmentSerializer.recordTypeColumn.columnName,
            uniqueIdColumnName()
            ] + updateColumnNames()

    }

    public func insertColumnValues() -> [DatabaseValueConvertible] {
        let result: [DatabaseValueConvertible] = [
            SDSRecordType.attachment.rawValue
            ] + [uniqueIdColumnValue()] + updateColumnValues()
        if OWSIsDebugBuild() {
            if result.count != insertColumnNames().count {
                owsFailDebug("Update mismatch: \(result.count) != \(insertColumnNames().count)")
            }
        }
        return result
    }

    public func updateColumnNames() -> [String] {
        return [
            TSAttachmentSerializer.albumMessageIdColumn,
            TSAttachmentSerializer.attachmentSchemaVersionColumn,
            TSAttachmentSerializer.attachmentTypeColumn,
            TSAttachmentSerializer.byteCountColumn,
            TSAttachmentSerializer.captionColumn,
            TSAttachmentSerializer.contentTypeColumn,
            TSAttachmentSerializer.encryptionKeyColumn,
            TSAttachmentSerializer.isDownloadedColumn,
            TSAttachmentSerializer.serverIdColumn,
            TSAttachmentSerializer.sourceFilenameColumn
            ].map { $0.columnName }
    }

    public func updateColumnValues() -> [DatabaseValueConvertible] {
        let result: [DatabaseValueConvertible] = [
            self.model.albumMessageId ?? DatabaseValue.null,
            self.model.attachmentSchemaVersion,
            self.model.attachmentType.rawValue,
            self.model.byteCount,
            self.model.caption ?? DatabaseValue.null,
            self.model.contentType,
            self.model.encryptionKey ?? DatabaseValue.null,
            self.model.isDownloaded,
            self.model.serverId,
            self.model.sourceFilename ?? DatabaseValue.null

        ]
        if OWSIsDebugBuild() {
            if result.count != updateColumnNames().count {
                owsFailDebug("Update mismatch: \(result.count) != \(updateColumnNames().count)")
            }
        }
        return result
    }

    public func uniqueIdColumnName() -> String {
        return TSAttachmentSerializer.uniqueIdColumn.columnName
    }

    // TODO: uniqueId is currently an optional on our models.
    //       We should probably make the return type here String?
    public func uniqueIdColumnValue() -> DatabaseValueConvertible {
        // FIXME remove force unwrap
        return model.uniqueId!
    }
}