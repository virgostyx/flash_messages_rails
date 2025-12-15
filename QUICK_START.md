# ⚡ Quick Start - Flash Messages Gem

## 🚀 Installation (3 Steps)

### Step 1: Add to Gemfile

```ruby
gem 'flash_messages'
```

### Step 2: Install

```bash
bundle install
rails generate flash_messages:install
```

### Step 3: Add to Layout

Edit `app/views/layouts/application.html.erb`:

```erb
<body>
  <%= render 'flash_messages/flash' %>
  <%= yield %>
</body>
```

**Done!** 🎉

---

## 🧪 Test It

In any controller:

```ruby
flash[:success] = "It works! 🎉"
redirect_to root_path
```

Visit the page → See a beautiful green flash message!

---

## 📖 Basic Usage

### Traditional Flash

```ruby
flash[:success] = "Post created!"
flash[:error] = "Something went wrong"
flash[:warning] = "Please review"
flash[:info] = "Just so you know"
redirect_to @post
```

### Using Helper Methods (Cleaner)

```ruby
def create
  if @post.save
    flash_and_redirect(:success, "Post created!", @post)
  else
    flash_and_render(:error, "Unable to create post", :new)
  end
end
```

### Custom Width

```ruby
flash_and_redirect(:success, "Saved!", @post, width: 384)
flash_and_render(:error, "Fix errors", :new, width: 672)
```

### With Turbo Streams

```ruby
respond_to do |format|
  format.html { flash_and_redirect(:success, "Updated!", @post) }
  format.turbo_stream do
    render turbo_stream: [
      turbo_stream.replace("post", partial: "post"),
      flash_turbo_stream(:success, "Updated!", width: 384)
    ]
  end
end
```

---

## 🎨 Message Types

| Type | Color | Icon |
|------|-------|------|
| `:success` or `:notice` | Green | ✓ |
| `:error` or `:danger` | Red | ✗ |
| `:warning` or `:alert` | Yellow | ⚠ |
| `:info` | Blue | ⓘ |

---

## 📏 Width Options

```ruby
width: 320   # Extra small
width: 384   # Small
width: 448   # Medium (default)
width: 512   # Large
width: 672   # Extra large
```

---

## 🛠️ Helper Methods

### `flash_and_redirect(type, message, path, width: 448)`
Simple redirect with flash.

### `flash_and_render(type, message, template, width: 448, status: :unprocessable_entity)`
Render template with flash error.

### `flash_turbo_stream(type, message, width: 448, duration: 5000)`
Add flash to Turbo Stream response.

### `flash_response(options)`
Complete CRUD pattern handler. See README for details.

---

## 📚 Full Documentation

See [README.md](README.md) for complete API documentation.

---

**That's it! Start building!** 🚀
