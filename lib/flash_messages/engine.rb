module FlashMessages
  class Engine < ::Rails::Engine
    isolate_namespace FlashMessages
    
    config.generators do |g|
      g.test_framework :rspec
    end
    
    # Automatically add the concern to ApplicationController
    initializer "flash_messages.load_controller_concern" do
      ActiveSupport.on_load(:action_controller_base) do
        include FlashMessages::ControllerHelpers
      end
    end
    
    # Ensure helpers are available
    initializer "flash_messages.load_helpers" do
      ActiveSupport.on_load(:action_view) do
        include FlashMessages::ViewHelper
      end
    end
  end
end
