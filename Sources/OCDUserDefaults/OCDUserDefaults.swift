import Foundation

private let OCD_PREFIX = "com.ocd"

private extension RawRepresentable where Self.RawValue == String {
    func withOCDPrefix() -> String {
        "\(OCD_PREFIX).\(self.rawValue)"
    }
}

public extension UserDefaults {

    func set<T: RawRepresentable>(_ value: Any?, forKey defaultName: T) where T.RawValue == String {
        set(value, forKey: defaultName.withOCDPrefix())
    }

    func removeObject<T: RawRepresentable>(forKey defaultName: T) where T.RawValue == String {
        removeObject(forKey: defaultName.withOCDPrefix())
    }

    func string<T: RawRepresentable>(forKey defaultName: T) -> String? where T.RawValue == String {
        string(forKey: defaultName.withOCDPrefix())
    }

    func array<T: RawRepresentable>(forKey defaultName: T) -> [Any]? where T.RawValue == String {
        array(forKey: defaultName.withOCDPrefix())
    }

    func dictionary<T: RawRepresentable>(forKey defaultName: T) -> [String : Any]? where T.RawValue == String {
        dictionary(forKey: defaultName.withOCDPrefix())
    }

    func data<T: RawRepresentable>(forKey defaultName: T) -> Data? where T.RawValue == String {
        data(forKey: defaultName.withOCDPrefix())
    }

    func stringArray<T: RawRepresentable>(forKey defaultName: T) -> [String]? where T.RawValue == String {
        stringArray(forKey: defaultName.withOCDPrefix())
    }

    func integer<T: RawRepresentable>(forKey defaultName: T) -> Int where T.RawValue == String {
        integer(forKey: defaultName.withOCDPrefix())
    }

    func float<T: RawRepresentable>(forKey defaultName: T) -> Float where T.RawValue == String {
        float(forKey: defaultName.withOCDPrefix())
    }

    func double<T: RawRepresentable>(forKey defaultName: T) -> Double where T.RawValue == String {
        double(forKey: defaultName.withOCDPrefix())
    }

    func bool<T: RawRepresentable>(forKey defaultName: T) -> Bool where T.RawValue == String {
        bool(forKey: defaultName.withOCDPrefix())
    }

    func cleanUp<T: RawRepresentable>(_ type: T.Type) where T.RawValue == String {
        let prefixWithDot = "\(OCD_PREFIX)."
        let res = self.dictionaryRepresentation()
            .keys
            .compactMap { (key: String) -> String? in
                guard key.hasPrefix(prefixWithDot)
                else {
                    return nil
                }
                return String(key.dropFirst(prefixWithDot.count))
            }

        res.forEach {
            guard type.init(rawValue: $0) != nil
            else {
                removeObject(forKey: "\(OCD_PREFIX).\($0)")
                return
            }
        }
    }
}
