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

For first time contributors, it's recommended to work on issues marked `Priority: LOW` or [unit tests](https://github.com/systers/volunteers-iOS/tree/development/VOLA/VOLATests).

1. Create a fork of the repo.
2. Browse open [issues](https://github.com/systers/volunteers-iOS/issues) and select one you want to attempt.
3. Make your changes for the issue on your fork of the repo as a new branch.
4. Make a pull request to the Systers [development branch](https://github.com/systers/volunteers-iOS/tree/development) for the project. Don't forget to tag the issue you're fixing in your pull request and the [GSoC mentors and student](#maintainers-and-contributors) as reviewers for your pull request.

Once you've made a pull request, it will be reviewed by at least one of the project maintainers or contributors. If any changes are required, the reviewer will make requested changes on the pull request. In this case, you should address the requested changes so that the pull request will be approved. When the pull request is approved, it will be merged onto the project.

### Getting Help

If you need help you can post your question in the `#vola` channel on the [Systers Open Source Slack](http://systers.io/slack-systers-opensource/). You can tag `@connie` in the channel if you don't get a response to your question.

### Maintainers and contributors

+ Connie (GSoC Student) - [Github](https://github.com/connienguyen)
+ Bruno (GSoC Mentor) - [Github](https://github.com/bphenriques)
+ Shruti (GSoC Mentor) - [Github](https://github.com/shruti-gupta)
+ Pichleap (GSoC Mentor) - [Github](https://github.com/psok)
+ [gsoc-admins@anitaborg.org](mailto:gsoc-admings@anitaborg.org), [gsoc-mentors@anitaborg.org](mailto:gsoc-mentors@anitaborg.org)
