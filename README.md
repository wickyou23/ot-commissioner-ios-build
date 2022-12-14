# My Guide

1. The project based on [ot-commissioner](https://github.com/openthread/ot-commissioner) support build library(.a) for iOS platform.

2. Building:

From the root project, run the script:

```sh
sudo sh ./script/build-ios-commissioner-libs.sh
```


> Note: The script runs on Mac M1. If using the Mac Intel, you can try to edit `brew` installer in file `./script/bootstrap.h` line 80.

3. If you get an error like the one below, ignore them, and then go to the root project -> ios-build -> ot-comission-release to get a build.


![Screen Shot 2022-11-07 at 10 29 04](https://user-images.githubusercontent.com/5183190/200220541-15e27bf8-2e08-498e-a8fb-b4db01949353.png)

4. [Basic Example](https://github.com/wickyou23/ot-commissioner-ios-example.git) for the library.


<br/><br/><br/><br/>

[![Build][ot-comm-gh-action-build-svg]][ot-comm-gh-action-build] [![Tests][ot-comm-gh-action-tests-svg]][ot-comm-gh-action-tests] [![Coverage Status][ot-comm-codecov-svg]][ot-comm-codecov]

---

# OpenThread Commissioner

Per the Thread 1.2.0 Specification, a Thread Commissioner connects to and manages a Thread network. A Thread network requires a Commissioner to commission new Joiner devices. A Thread Commissioner minimally supports the following functions:

- Connecting to a Thread network through a Thread Border Agent
- Steering and commissioning new devices
- Get/set Thread network datasets

OpenThread's implementation of a Thread Commissioner is called OpenThread Commissioner (OT Commissioner).

OT Commissioner features include:

- Implements both the Thread 1.1 and 1.2 Commissioner (with Commercial Extension)
- Cross-platform (Linux, Mac OS, Android) Commissioner library
- Interactive Commissioner CLI Tool (Linux, Mac OS)

More information about Thread can be found at [threadgroup.org](http://threadgroup.org/). Thread is a registered trademark of the Thread Group, Inc.

To learn more about OpenThread, visit [openthread.io](https://openthread.io).

[ot-comm-gh-action-build]: https://github.com/openthread/ot-commissioner/actions?query=workflow%3ABuild+branch%3Amain+event%3Apush
[ot-comm-gh-action-build-svg]: https://github.com/openthread/ot-commissioner/workflows/Build/badge.svg?branch=main&event=push
[ot-comm-gh-action-tests]: https://github.com/openthread/ot-commissioner/actions?query=workflow%3ATests+branch%3Amain+event%3Apush
[ot-comm-gh-action-tests-svg]: https://github.com/openthread/ot-commissioner/workflows/Tests/badge.svg?branch=main&event=push
[ot-comm-codecov]: https://codecov.io/gh/openthread/ot-commissioner
[ot-comm-codecov-svg]: https://codecov.io/gh/openthread/ot-commissioner/branch/main/graph/badge.svg

## Getting started

See [OT Commissioner guide](https://openthread.io/guides/commissioner) to get started. See OT [Commissioner CLI documentation](src/app/cli/README.md) for a reference of all CLI commands.

## Contributing

We would love for you to contribute to OpenThread and help make it even better than it is today! See our [Contributing Guidelines](CONTRIBUTING.md) for more information.

Contributors are required to abide by our [Code of Conduct](CODE_OF_CONDUCT.md) and [Coding Conventions and Style Guide](https://google.github.io/styleguide/cppguide.html).

## Version

OT Commissioner follows the [Semantic Versioning guidelines](http://semver.org/) for release cycle transparency and to maintain backwards compatibility. OpenThread's versioning is independent of the Thread protocol specification version but will clearly indicate which version of the specification it currently supports.

## License

OT Commissioner is released under the [BSD 3-Clause license](LICENSE). See the [`LICENSE`](LICENSE) file for more information.

Please only use the OpenThread name and marks when accurately referencing this software distribution. Do not use the marks in a way that suggests you are endorsed by or otherwise affiliated with Nest, Google, or The Thread Group.
