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

- **Filter**:
    - Filter by Type: Allows for the filtering of absences based on their type (e.g., vacation or sick leave).
    - Filter by Date: Enables filtering absences by start date or end date.
 
- **Pagination**:
    - Load and navigate through absences 10 at a time. The list initially shows the first 10 absences, with the ability to paginate through the remaining entries.
      
- **Error Handling**:
    - Displays user-friendly error messages if the JSON file cannot be retrieved or contains invalid data.
      
- **Search Functionality**:
    - Find absences by entering keywords (e.g., member name).

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

 ##  Why I Used Clean Architecture

I chose Clean Architecture to keep the app modular, easy to maintain, and ready for future updates. It splits the app into clear layers like Domain, Data, and Presentation, which makes it easier to add new features, fix bugs, or change things without breaking the app.

For example, I can easily add features like iCal generation or advanced filters later because the code is well-organized. It’s also easy to test the logic separately from the UI.

Overall, this architecture makes the app more flexible and ready for growth, which is why I used it.

## Dependencies

- State Management: flutter_bloc

- Dependency Injection: injector

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

 * Implemented using flutter_test to ensure the robustness of the business logic.
 * Converted unit tests to cover the following layers:
 *  Data Layer: Tests for data parsing, fetching, and handling from the JSON file.
 * Domain Layer: Tests for use cases to validate business logic and edge cases.
 * Repository: Tests to ensure proper communication between the data layer and the domain layer.
 * Presentation Layer: Comprehensive tests for all BLoC classes, events, and states to validate UI interactions and state transitions.

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
To Generate:

```bash
dart run build_runner build
```

##  Author

Shahanaj Parvin

License

This project is licensed under the MIT License.

