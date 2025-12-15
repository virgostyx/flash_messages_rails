require 'rails/generators'

module FlashMessages
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      
      desc "Install Flash Messages component"
      
      def copy_javascript_controller
        say "Installing Stimulus controller...", :green
        copy_file "../../../../app/assets/javascripts/flash_messages/controllers/flash_controller.js",
                  "app/javascript/controllers/flash_controller.js"
      end
      
      def show_readme
        readme "README" if behavior == :invoke
      end
      
      private
      
      def readme(path)
        say "\n" + "="*70, :green
        say "Flash Messages Installation Complete! 🎉", :green
        say "="*70, :green
        
        say "\n✅ Installed:", :cyan
        say "  • Stimulus controller (app/javascript/controllers/flash_controller.js)"
        say "  • View helpers (automatically loaded)"
        say "  • Controller helpers (automatically loaded)"
        
        say "\n🚀 Next Step:", :cyan
        say "  Add this line to your layout (app/views/layouts/application.html.erb):"
        say "  Right after the <body> tag:\n", :yellow
        say "    <%= render 'flash_messages/flash' %>\n", :cyan
        
        say "\n📖 Usage Examples:", :cyan
        say "  # Basic"
        say "  flash[:success] = 'Post created!'"
        say "  redirect_to @post\n"
        
        say "  # Using helpers"
        say "  flash_and_redirect(:success, 'Saved!', @post)"
        say "  flash_and_render(:error, 'Failed', :new)\n"
        
        say "  # With Turbo Streams"
        say "  flash_turbo_stream(:success, 'Updated!', width: 384)\n"
        
        say "📚 Documentation: https://github.com/yourusername/flash_messages", :cyan
        say "="*70 + "\n", :green
      end
    end
  end
end
