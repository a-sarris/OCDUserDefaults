    import XCTest
    @testable import OCDUserDefaults

    enum Keys: String {
        case key
    }

    enum AlternateKeys: String {
        case alternateKey
    }

    final class OCDUserDefaultsTests: XCTestCase {

        override func tearDown() {
            UserDefaults.standard.dictionaryRepresentation().keys
                .forEach {
                    UserDefaults.standard.removeObject(forKey: $0)
                }
        }

        func testSet() {
            let defaults = UserDefaults.standard
            defaults.set("Key Value", forKey: Keys.key)

            XCTAssertEqual(defaults.value(forKey: "com.ocd.key") as? String, "Key Value")
        }

        func testCleanupWithNoChangesInTheEnum() {
            let defaults = UserDefaults.standard
            defaults.set("Key Value", forKey: Keys.key)
            defaults.cleanUp(Keys.self)
            XCTAssertEqual(defaults.value(forKey: "com.ocd.key") as? String, "Key Value")
        }

        func testCleanupWithChangesInTheEnum() {
            let defaults = UserDefaults.standard
            defaults.set("Key Value", forKey: Keys.key)
            // To simulate changes we are using a different enum
            defaults.cleanUp(AlternateKeys.self)
            XCTAssertEqual(defaults.value(forKey: "com.ocd.key") as? String, nil)
        }

        func testRemoveObject() {
            let defaults = UserDefaults.standard
            defaults.set("Key Value", forKey: Keys.key)
            defaults.removeObject(forKey: Keys.key)
            XCTAssertEqual(defaults.value(forKey: "com.ocd.key") as? String, nil)
        }

        func testGetString() {
            let defaults = UserDefaults.standard
            defaults.set("Key Value", forKey: Keys.key)
            XCTAssertEqual(defaults.string(forKey: Keys.key), "Key Value")
        }

        func testGetArray() {
            let defaults = UserDefaults.standard
            defaults.set(["Key Value1", "Key value2"], forKey: Keys.key)
            XCTAssertEqual(defaults.array(forKey: Keys.key) as? [String], ["Key Value1", "Key value2"])
        }

        func testGetDictionary() {
            let defaults = UserDefaults.standard
            defaults.set(["Key": "Value1"], forKey: Keys.key)
            XCTAssertEqual(defaults.dictionary(forKey: Keys.key) as? [String: String], ["Key": "Value1"])
        }

        func testGetData() {
            let data = "value".data(using: .utf8)
            let defaults = UserDefaults.standard
            defaults.set(data, forKey: Keys.key)
            XCTAssertEqual(defaults.data(forKey: Keys.key), data)
        }

        func testGetStringArray() {
            let defaults = UserDefaults.standard
            defaults.set(["Key Value1", "Key value2"], forKey: Keys.key)
            XCTAssertEqual(defaults.stringArray(forKey: Keys.key), ["Key Value1", "Key value2"])
        }

        func testGetInt() {
            let defaults = UserDefaults.standard
            defaults.set(1, forKey: Keys.key)
            XCTAssertEqual(defaults.integer(forKey: Keys.key), 1)
        }

        func testGetFloat() {
            let defaults = UserDefaults.standard
            defaults.set(Float(1), forKey: Keys.key)
            XCTAssertEqual(defaults.float(forKey: Keys.key), Float(1))
        }

        func testGetDouble() {
            let defaults = UserDefaults.standard
            defaults.set(Double(1), forKey: Keys.key)
            XCTAssertEqual(defaults.double(forKey: Keys.key), Double(1))
        }

        func testGetBool() {
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: Keys.key)
            XCTAssertEqual(defaults.bool(forKey: Keys.key), true)
        }
    }
