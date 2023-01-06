const ENV env = ENV.dev;

// const String baseUrl = "http://hexeros.com/dev/finowise/api/V1/";

enum ENV { dev, qa, prod }

extension ConfigExt on ENV {
  String get baseurl {
    switch (this) {
      case ENV.qa:
        return 'http://hexeros.com/dev/finowise/api/V1/';
      case ENV.dev:
        return 'http://hexeros.com/dev/finowise/api/V1/';
      case ENV.prod:
        return 'http://hexeros.com/dev/finowise/api/V1/';
    }
  }
}

// https://newsapi.org/v2/everything?q=election&apiKey=c6817e0442a2480185720574e93c2cbfconst ENV env = ENV.prod;