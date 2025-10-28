# Pure UI Rails

A Ruby gem that provides ViewComponent wrappers for [Pure UI](https://github.com/ssjblue197/pure-ui), making it easy to use Pure UI web components in Rails applications

## Features

- 🎨 ViewComponent wrappers for all Pure UI components
- 🎯 CSS Parts styling support
- 🚀 On-demand CSS boilerplate generation
- 📦 Bundled Pure UI assets (optional)
- 📝 Custom FormBuilder with ActiveRecord validation support
- ✅ Automatic error display for form fields

## Installation

Add this line to your application's Gemfile:
```ruby
gem 'pure-ui-rails'
```
Or run
```ruby
bundle add pure-ui-rails
```

Then execute:
```bash
bundle install
rails pureui:install
```

## Usage

### Basic Component Usage
```erb
<%= render Pureui::ButtonComponent.new(variant: "primary") do %>
  Click Me
<% end %>

<%= render Pureui::InputComponent.new(
  placeholder: "Enter text...",
  type: "email"
) %>

<%= render Pureui::CardComponent.new do %>
  Card Title
  Card content goes here
<% end %>
```

### Generating Component Styles

Generate CSS boilerplate for specific components:
```bash
rails generate pureui:component_styles button input card
```

Or generate styles for all components at once:
```bash
rails generate pureui:component_styles --all
```

This will add CSS part selectors to `app/assets/stylesheets/components/pureui_components.css`:
```css
/* Button (p-button) */

.pureui-rails-button-component::part(base) {
  /* Add styles for base part */
}

.pureui-rails-button-component::part(label) {
  /* Add styles for label part */
}
```

### Form Builder with ActiveRecord

The gem provides a custom FormBuilder that integrates seamlessly with Rails forms and ActiveRecord validations:
```erb
<%= form_with model: @user, builder: Pureui::FormBuilder do |f| %>
  <%= f.input :email, 
    label: "Email Address",
    type: "email",
    placeholder: "user@example.com",
    help_text: "We'll never share your email"
  %>
  
  <%= f.textarea :bio,
    label: "Biography",
    rows: 5,
    placeholder: "Tell us about yourself..."
  %>
<% end %>
```

### Available Components

- Alert
- Avatar
- Badge
- Button
- Card
- Checkbox
- Dialog
- Drawer
- Input
- Select
- And 40+ more...

See the full list at [Pure UI Components](https://pureui.online/).

## Configuration
```ruby
# config/initializers/pureui.rb
Pureui.configure do |config|
  config.default_theme = :light # or :dark
  config.auto_import_styles = true
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.

To update Pure UIkit assets:
```bash
rake download_assets[1.6.30]
```

To regenerate component metadata:
```bash
rake generate_metadata[1.6.30]
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).