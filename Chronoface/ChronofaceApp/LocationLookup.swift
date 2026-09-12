import CoreLocation

/// Однократно определяет город по геопозиции для кнопки «My Location» в настройках.
/// Работает только в Chronoface.app: extension живёт в sandbox без доступа к
/// Location Services и получает выбранное место через общие настройки.
final class LocationLookup: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    private var completion: ((Result<LocationInfo, Error>) -> Void)?
    private var awaitingAuthorization = false

    private static let accessError = LocationLookupError(
        message: "Chronoface has no access to Location Services. Allow it in System Settings → Privacy & Security → Location Services, or search for your city instead.",
        settingsURL: URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_LocationServices")
    )

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
    }

    func request(completion: @escaping (Result<LocationInfo, Error>) -> Void) {
        guard self.completion == nil else { return }
        self.completion = completion
        switch manager.authorizationStatus {
        case .notDetermined:
            awaitingAuthorization = true
            manager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            finish(.failure(LocationLookup.accessError))
        default:
            manager.requestLocation()
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard awaitingAuthorization else { return }
        switch manager.authorizationStatus {
        case .notDetermined:
            return
        case .denied, .restricted:
            awaitingAuthorization = false
            finish(.failure(LocationLookup.accessError))
        default:
            awaitingAuthorization = false
            manager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let completion = completion, let location = locations.last else { return }
        self.completion = nil
        let coordinate = location.coordinate
        // Английские названия: шрифт циферблата (Futura) без кириллицы и CJK.
        CLGeocoder().reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "en_US")) { placemarks, _ in
            let placemark = placemarks?.first
            let name = placemark?.locality
                ?? placemark?.subAdministrativeArea
                ?? placemark?.administrativeArea
                ?? String(format: "%.2f, %.2f", coordinate.latitude, coordinate.longitude)
            let timeZoneID = placemark?.timeZone?.identifier ?? TimeZone.current.identifier
            completion(.success(LocationInfo(name: name, lat: coordinate.latitude,
                                             lon: coordinate.longitude, timeZoneID: timeZoneID)))
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard completion != nil else { return }
        if (error as? CLError)?.code == .denied {
            finish(.failure(LocationLookup.accessError))
        } else {
            finish(.failure(LocationLookupError(message: "Your Mac couldn't determine its location right now. Try again later or search for your city.")))
        }
    }

    private func finish(_ result: Result<LocationInfo, Error>) {
        let completion = self.completion
        self.completion = nil
        completion?(result)
    }
}
