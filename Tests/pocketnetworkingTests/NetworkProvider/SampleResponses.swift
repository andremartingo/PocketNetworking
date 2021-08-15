import Foundation


var validCurrentPriceResponse =
"""
{
  "disclaimer": "This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org",
  "chartName": "Bitcoin",
  "bpi": {
    "USD": {
      "code": "USD",
      "symbol": "&#36;",
      "rate": "48,471.6516",
      "description": "United States Dollar",
      "rate_float": 48471.651
    },
    "GBP": {
      "code": "GBP",
      "symbol": "&pound;",
      "rate": "35,563.5053",
      "description": "British Pound Sterling",
      "rate_float": 35563.505
    },
    "EUR": {
      "code": "EUR",
      "symbol": "&euro;",
      "rate": "41,501.0403",
      "description": "Euro",
      "rate_float": 41501.040
    }
  }
}
""".data(using: .utf8)!

var invalidCurrentPriceResponse =
"""
{
  "disclaimer": "This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org",
  "chartName": "Bitcoin",
  "randomerror": {
    "USD": {
      "code": "USD",
      "symbol": "&#36;",
      "rate": "48,471.6516",
      "description": "United States Dollar",
      "rate_float": 48471.651
    },
    "GBP": {
      "code": "GBP",
      "symbol": "&pound;",
      "rate": "35,563.5053",
      "description": "British Pound Sterling",
      "rate_float": 35563.505
    },
    "EUR": {
      "code": "EUR",
      "symbol": "&euro;",
      "rate": "41,501.0403",
      "description": "Euro",
      "rate_float": 41501.040
    }
  }
}
""".data(using: .utf8)!


