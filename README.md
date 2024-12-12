# Absence Manager

A Flutter application to manage employee absences efficiently. This project implements Clean Code Architecture, adheres to best coding practices, and demonstrates the use of modern Flutter development tools and principles. It is designed to be maintainable, scalable, and testable.

## Features

- **Absence List**: Displays a list of absent employees retrieved from a local JSON file.

- **Details Page**: Shows detailed information about the absence when an item is selected from the list.
    - Member name
    - Image
    - Type of absence
    - Period
    - Member note (if available)
    - Status (Requested, Confirmed, or Rejected)
    - Admitter note (if available)

- **Localization**: Multi-language support using the intl package.

- **State Management**: Implemented using Flutter BLoC (with events).

- **Code Quality**: Enforced through lint package and adherence to SOLID, DRY, and KISS principles.

- **Dependency Injection**: Managed using the get_it package.

- **Code Generation**: Simplified with Freezed for immutable data classes and JSON serialization.

- **Unit Testing**: Comprehensive testing with flutter_test.

- **Modular Codebase**: Structured for scalability and maintainability.

## Project Structure

The codebase follows Clean Architecture with the following layers:

- Presentation: UI and Widgets (e.g., AbsenceListPage, AbsenceDetailPage).

- Application: BLoC classes to handle business logic and events.

- Domain: Entities and use cases.

- Data: Repositories and JSON data source.

- Core: Shared utilities, localization, and constants.

## Dependencies

- State Management: flutter_bloc

- Dependency Injection: get_it

- Code Generation: freezed, build_runner

- Localization: intl

- Testing: flutter_test

- Linting: lint

## Design Principles

- SOLID: Single responsibility, Open/Closed, Liskov substitution, Interface segregation, Dependency inversion.

- DRY: Avoid duplication of logic and code.

- KISS: Keep It Simple and Straightforward.

## Testing

### Unit Tests

- Implemented using flutter_test to ensure the robustness of the business logic.

Run tests:

```bash
flutter test
```

## Localization

Localization is managed using the intl package. All text strings are defined in ARB files in the lib/l10n directory.

To add a new language:

Create a new .arb file (e.g., app_es.arb).

To Generate Translation:

```bash
flutter gen-l10n
```

##  Author

Shahanaj Parvin

License

This project is licensed under the MIT License.

