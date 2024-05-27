# To-Do with MFEs and Clean Arch

This is a to-do app example with a micro front-ends and clean architecture.

## What is MFEs?

This project have MFEs in a monorepo strategy. The MFEs means `Micro Front-Ends`. It is a way to split the front-end application into small parts, which can be developed, tested, and deployed independently if you want. This approach can help you to scale your front-end application.

## Where are the MFEs?

The MFEs are in the `packages` folder. Each MFE is a Flutter project.

## How to create a new MFE?

To create a new MFE, you can use the command below:

```bash
flutter create --template=package <mfe_name>
```

## How to run

Only run the main.dart file in the `lib` folder, like any other Flutter project.

## Dependency Injection and Navigation

This project uses the `flutter_modular` package to manage the dependency injection and navigation. You can see more details about the package [here](https://modular.flutterando.com.br/docs/flutter_modular/start/).

## Architecture

You can see more details about the architecture here:

- [To-Do with Clean Arch](https://github.com/mathsilva-dev/todo_monolith)
