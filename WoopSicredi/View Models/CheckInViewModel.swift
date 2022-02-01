class CheckInViewModel {
    private var apiService: APIService!
    
    init() {
        apiService = APIService.shared
    }
    
    func postCheckIn(with info: CheckIn) {
        apiService.postCheckIn(with: info)
    }
}
