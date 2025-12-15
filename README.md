# Flash Messages

Beautiful, animated flash messages for Ruby on Rails 8 with Stimulus and Tailwind CSS.

## Features

- ✨ **4 Message Types** - Success, Error, Warning, Info with color-coding
- ⚡ **Auto-dismiss** - Configurable fade-out (default: 5 seconds)
- 🎯 **Pause on Hover** - Messages pause when you hover over them
- 📚 **Multiple Messages** - Stack beautifully with proper spacing
- 🔄 **Turbo Streams Ready** - Full support for AJAX updates
- 💅 **Tailwind Styled** - Beautiful, responsive design out of the box
- 🎮 **Stimulus Powered** - Clean, modern JavaScript
- 🛠️ **Helper Methods** - Simplify your controller code

## Requirements

- Ruby on Rails 8.0+
- Tailwind CSS
- Stimulus (included in Rails 8)
- Turbo (included in Rails 8)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'flash_messages'
```

And then execute:

```bash
bundle install
```

Run the installer:

```bash
rails generate flash_messages:install
```

Add to your layout (`app/views/layouts/application.html.erb`):

```erb
<body>
  <%= render 'flash_messages/flash' %>
  
  <%= yield %>
</body>
```

## Usage

### Basic Flash Messages

```ruby
class PostsController < ApplicationController
  def create
    @post = Post.new(post_params)
    
    if @post.save
      flash[:success] = "Post created successfully!"
      redirect_to @post
    else
      flash[:error] = "Unable to create post."
      render :new
    end
  end
end
```

### Using Helper Methods (Recommended)

The gem automatically adds helper methods to your controllers:

```ruby
class PostsController < ApplicationController
  def create
    @post = Post.new(post_params)
    
    if @post.save
      flash_and_redirect(:success, "Post created!", @post)
    else
      flash_and_render(:error, "Unable to create post.", :new)
    end
  end
end
```

### Custom Width

```ruby
# Small message (384px)
flash_and_redirect(:success, "Saved!", @post, width: 384)

# Large message (672px)
flash_and_render(:error, "Please fix these errors...", :new, width: 672)
```

### With Turbo Streams

```ruby
def update
  if @post.update(post_params)
    respond_to do |format|
      format.html { flash_and_redirect(:success, "Updated!", @post) }
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("post_#{@post.id}", partial: "posts/post", locals: { post: @post }),
          flash_turbo_stream(:success, "Updated!", width: 384)
        ]
      end
    end
  else
    flash_and_render(:error, "Unable to update.", :edit)
  end
end
```

### Complete CRUD Pattern

```ruby
def create
  @post = Post.new(post_params)
  
  flash_response(
    success: @post.save,
    success_message: "Post created!",
    error_message: "Unable to create post.",
    success_path: @post,
    error_template: :new,
    turbo_success: -> {
      render turbo_stream: [
        turbo_stream.prepend("posts", partial: "posts/post", locals: { post: @post }),
        flash_turbo_stream(:success, "Created!", width: 384)
      ]
    }
  )
end
```

## Helper Methods

### `flash_and_redirect(type, message, path, width: 448)`

Redirects with a flash message.

```ruby
flash_and_redirect(:success, "Post created!", @post)
flash_and_redirect(:error, "Not found", root_path, width: 672)
```

### `flash_and_render(type, message, template, width: 448, status: :unprocessable_entity)`

Renders a template with a flash message.

```ruby
flash_and_render(:error, "Fix the errors", :new)
flash_and_render(:warning, "Check your input", :edit, width: 512)
```

### `flash_turbo_stream(type, message, width: 448, duration: 5000)`

Returns a turbo stream for appending a flash message.

```ruby
render turbo_stream: [
  turbo_stream.update("post", partial: "post"),
  flash_turbo_stream(:success, "Done!", width: 384)
]
```

### `flash_response(options)`

Handles complete CRUD response pattern.

**Options:**
- `success:` (required) - Boolean indicating success/failure
- `success_message:` (required) - Message to show on success
- `error_message:` (required) - Message to show on error
- `success_path:` - Where to redirect on success (HTML)
- `error_template:` - Template to render on error (HTML)
- `turbo_success:` - Lambda for Turbo Stream success response
- `turbo_error:` - Lambda for Turbo Stream error response
- `success_width:` - Width for success message (default: 384)
- `error_width:` - Width for error message (default: 672)

## Message Types

| Type | Alias | Color | Icon | Use Case |
|------|-------|-------|------|----------|
| `:success` | `:notice` | Green | ✓ | Successful actions |
| `:error` | `:danger` | Red | ✗ | Errors, failures |
| `:warning` | `:alert` | Yellow | ⚠ | Warnings, cautions |
| `:info` | - | Blue | ⓘ | Information |

## Customization

### Change Default Width

Edit the view partial to change the default width:

```ruby
# In your app, create:
# app/views/flash_messages/_flash.html.erb

# Copy from gem and modify:
default_width = 512  # Instead of 448
```

### Change Auto-Dismiss Duration

Override the Stimulus controller:

```javascript
// app/javascript/controllers/flash_controller.js

import FlashController from "flash_messages/controllers/flash_controller"

export default class extends FlashController {
  static values = {
    duration: { type: Number, default: 7000 } // 7 seconds
  }
}
```

### Change Colors

Create your own helper to override colors:

```ruby
# app/helpers/application_helper.rb

module ApplicationHelper
  def flash_message_config(type)
    # Your custom colors here
    super # Call the gem's method for types you don't override
  end
end
```

## Width Reference

| Width (px) | Tailwind | Best For |
|------------|----------|----------|
| 320 | max-w-xs | Very short messages |
| 384 | max-w-sm | Short messages |
| 448 | max-w-md | **Default** - Balanced |
| 512 | max-w-lg | Longer messages |
| 672 | max-w-2xl | Detailed messages |
| 800+ | Custom | Very long content |

## Examples

See the `/examples` directory in the gem for complete controller examples.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yourusername/flash_messages.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
