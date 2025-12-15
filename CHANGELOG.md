# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-12-15

### Added
- Initial release
- Flash message component with 4 types (success, error, warning, info)
- Auto-dismiss functionality with configurable duration
- Pause on hover feature
- Multiple message stacking
- Stimulus controller for animations
- Turbo Streams support
- Tailwind CSS styling
- Controller helper methods:
  - `flash_and_redirect`
  - `flash_and_render`
  - `flash_turbo_stream`
  - `flash_response`
- View helper for color and icon configuration
- Rails generator for easy installation
- Comprehensive documentation
- Example controllers

### Features
- Responsive design
- Customizable widths (per message or globally)
- Customizable auto-dismiss duration
- Clean, maintainable code
- Zero external dependencies beyond Rails

### Requirements
- Ruby on Rails 8.0+
- Tailwind CSS
- Stimulus (included in Rails 8)
- Turbo (included in Rails 8)
