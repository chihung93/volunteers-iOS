# Volunteers iOS

Volunteers (VOLA) is an iOS app intended for the Systers community. With it, Systers members can search for nearby events and volunteering opportunities. The VOLA app facilitates networking within the Systers community. In particular, users can find affinity groups within the Systers community.

+ [Set Up and Install](#set-up-and-install)
+ [How to Contribute](#how-to-contribute)

## Set Up and Install

Fork the repo. Navigate to the project folder and install the required CocoaPods.

```sh
cd VOLA/
pod install
```

If you are an authorized developer on this project, request access fo the `GoogleService-Info.plist` and `SecretKeys.plist` files. Add the plist files to the root of the project in XCode. The project can now be compiled and run.

If you are not yet an authorized developer on this project, you are still able to contribute, but will have to use your own `GoogleService-Info.plist` and `SecretKeys.plist` files. You can read more about the structure of the plist files on the [project wiki](https://github.com/systers/volunteers-iOS/wiki/Required-files).

You may get an error when trying to log into Facebook if you are not on the list of the app's approved testers. To become a test user or developer user, request to become one and provide your facebook ID or username.

## How to Contribute

If you're interested in contributing to the project, follow these steps:

>For first time contributors, it's recommended to work on issues marked `Priority: LOW` or writing additional [unit tests](https://github.com/systers/volunteers-iOS/tree/development/VOLA/VOLATests) to improve code coverage.

1. Create a fork of the repo.
2. Browse open [issues](https://github.com/systers/volunteers-iOS/issues) and select one you want to attempt.
3. Make your changes for the issue on your fork of the repo as a new branch.
4. Make a pull request to the Systers [development branch](https://github.com/systers/volunteers-iOS/tree/development) for the project. Your pull requests should follow the [guidelines](#contribution-guidelines) below to be successful. Don't forget to add [GSoC mentors and student](#maintainers-and-contributors) as reviewers for your pull request.

Once you've made a pull request, it will be reviewed by at least one of the project maintainers or contributors. If any changes are required, the reviewer will make requested changes on the pull request. In this case, you should address the requested changes so that the pull request will be approved. When the pull request is approved, it will be merged onto the project.

### Contribution Guidelines

#### Pull Requests

Pull requests to the project should follow this format:
```
fix #<number of issue>: <brief summary>

* Commit summary 1
* Commit summary 2
```

Following this format makes your pull request easier to review and more likely to be approved.

#### Commit Conventions

Commit messages should follow this format:
```
fix #<number of issue>: <brief summary>

* Bulletpoint 1
* Bulletpoint 2
```

#### Unit Tests

Unit tests are included on this project, and they are passing on a clean slate. If you would like to contribute by writing unit tests, your additional unit tests should also pass on a clean late.

If you are adding a new feature to the project, ensure that the current unit tests still pass. If your new feature is not covered by the current unit tests, it is ideal to include unit tests for your feature.

#### Linter

This project is equipped with a linter to help keep the code clean and consistent. Your pull request should have no lint warnings except where applicable (e.g. `TODO`, `FIXME`). Even then, your pull request should avoid adding `TODO`s and `FIXME`s unless absolutely necessary.

### Getting Help

If you need help, you should first consult the available project documentation on the [wiki](https://github.com/systers/volunteers-iOS/wiki). If the wiki doesn't answer your question, you can post a question in the `#vola` channel on the [Systers Open Source Slack](http://systers.io/slack-systers-opensource/). You can tag `@connie` in the channel if you don't get a response to your question.

### Maintainers and contributors

+ Connie (GSoC Student) - [Github](https://github.com/connienguyen)
+ Bruno (GSoC Mentor) - [Github](https://github.com/bphenriques)
+ Shruti (GSoC Mentor) - [Github](https://github.com/shruti-gupta)
+ Pichleap (GSoC Mentor) - [Github](https://github.com/psok)
+ [gsoc-admins@anitaborg.org](mailto:gsoc-admings@anitaborg.org), [gsoc-mentors@anitaborg.org](mailto:gsoc-mentors@anitaborg.org)
