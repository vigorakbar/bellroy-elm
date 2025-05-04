# Bellroy Product Card Component in Elm

A recreation of the Bellroy product card component from [bellroy.com](https://bellroy.com) using Elm, focusing on maintainable and well-structured code.

## Live Demo

[https://vigorakbar.github.io/bellroy-elm/public/index.html](https://vigorakbar.github.io/bellroy-elm/public/index.html)

## Features

- **Product Cards** with images, names, prices, and descriptions
- **Color Selection** that updates product images
- **Inside View Toggle** showing the product interior
- **"New Color" Label** for new variants
- **Responsive Design** for different screen sizes
- **JSON Data Fetching** for product information

## Project Structure

```
bellroy-elm/
├── public/               # Compiled assets and static files
├── src/                  # Source code
│   ├── Main.elm          # Application entry point
│   ├── Product.elm       # Type definitions
│   └── ProductCard.elm   # Component implementation
└── styles/               # CSS files
```

## Implementation Details

### Elm Architecture

The application follows the standard Elm Architecture (Model-View-Update) with:

- **Model**: State of each product card (selected variant, inside view status)
- **Update**: Handlers for variant selection and view toggling
- **View**: Product card rendering based on current state

### Key Interactions

- Color selection updates product images and applies active styling
- Inside view toggle button appears on hover
- Responsive grid layout adapts to screen sizes
- BEM methodology for CSS structure and naming

## Technical Highlights

- Type-safe implementation with Elm
- Pure functional approach with immutable data
- JSON decoding for data handling
- Component-based CSS organization

## Running the Project Locally

1. Clone the repository
2. Install Elm: `npm install -g elm`
3. Build: `elm make src/Main.elm --output=public/main.js`
4. Open `public/index.html` in your browser
