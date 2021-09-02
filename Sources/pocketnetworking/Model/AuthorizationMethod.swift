public enum AuthorizationMethod {
    case bearer(token: String)
    case basic(username: String, password: String)
    case none
}
