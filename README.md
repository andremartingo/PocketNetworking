# 📡 PocketNetworking
<p align="left">
    <img src="https://img.shields.io/badge/Swift-5.1-orange.svg" />
    <img src="https://img.shields.io/badge/iOS-15-orange.svg" />
    <img src="https://img.shields.io/badge/platforms-iOS | macOS | watchOS | tvOS-brightgreen.svg?style=flat" alt="Mac" />
    <a href="https://twitter.com/andremartingo">
        <img src="https://img.shields.io/badge/twitter-@andremartingo-blue.svg?style=flat" alt="Twitter: @andremartingo" />
    </a>
</p>

## 🔑 Features

- [x] API made with `Async/Await`
- [x] A simple network abstraction layer written in Swift.
- [x] Supports CRUD methods.
- [x] Compile-time checking for correct API endpoint accesses.
- [x] No external dependencies. 

## 📚 Description

**Pocket Networking** doesn't claim to be unique in this area, but it's not another monster
library that gives you a god's power. It does nothing but networking, but it does it well. It offers a good public API
with out-of-box implementations and great customization possibilities. `PocketNetworking` utilizes `Async/Awaut` in Swift 5.

## 🏃‍♀️ Getting started
Create a `struct` conforming to `EndpointProtocol` with all of your API resources like the following: 

```swift
class CurrentPriceEndpoint: EndpointProtocol {
    typealias Response = CurrentPriceResponse
    
    let baseURL: URL = .init(string: "https://api.coindesk.com")!
    let path = "/v1/bpi/currentprice.json"
    let method = HTTP.Method.get
    let query: HTTP.Query = [:]
    let headers: HTTP.Headers = [:]
}
```

`Response` should conform to `Decodable` protocol 

```swift
struct CurrentPriceResponse: Decodable {
    let disclaimer: String
    let chartName: String
    let bpi: Currency
}
```

### ⚙️ Making and handling a request
```swift
import pocketnetworking

let networking = NetworkProvider()

let endpoint = CurrentPriceEndpoint()
let result = await network.request(endpoint: endpoint)

Task {
    switch result {
    case .success(let model):
        self.state = updateState(with: model)

    case .failure(let error):
        print(error)
}
```

## ✨ Example
See [Example app](https://github.com/andremartingo/PocketNetworking/tree/main/Example)

## 👤 Author
This tiny library is created with ❤️ by [André Martingo](https://twitter.com/andremartingo) 
