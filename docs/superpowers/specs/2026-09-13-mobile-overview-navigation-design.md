# Mobile overview navigation design

## Goal

Make the OverviewPage device frame render the four existing mobile pages through the existing bottom navigation. Each navigation item must show its corresponding real page.

## Design

`OverviewPage` keeps ownership of the selected navigation index and renders a page widget from a fixed four-item mapping: `HomePage`, `VaultPage`, `GeneratorPage`, and `SettingsPage`. The page widgets retain their existing `Scaffold`, app bar, controls, and synthetic demo data. `AppBottomNavigation` remains the device frame's bottom navigation and receives the selected index plus callback.

## Testing

Add a widget test that taps each navigation label and asserts the corresponding page-specific title or content appears inside `product-frame`. The test also asserts that the other placeholder-only behavior is gone. Run formatting, static analysis, and the complete Flutter test suite before committing.

## Constraints

No backend, authentication, encryption, or synchronization integration. Preserve synthetic data only.
