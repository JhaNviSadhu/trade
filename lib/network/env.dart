const ENV env = ENV.dev;

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
